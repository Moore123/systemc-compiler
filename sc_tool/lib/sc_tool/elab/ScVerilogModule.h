/******************************************************************************
 * Copyright (c) 2020, Intel Corporation. All rights reserved.
 * 
 * SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception.
 * 
 *****************************************************************************/

/**
 * Representation of Verilog Module body.
 * 
 * Key for providing unique names for MIF array element members, 
 * including record/record array fields 
 * Same name should be for same member in different MIF array elements
 * 
 * Author: Roman Popov
 */

#ifndef SCTOOL_SCVERILOGMODULE_H
#define SCTOOL_SCVERILOGMODULE_H

#include "sc_tool/cfg/SValue.h"
#include "sc_tool/elab/ScObjectView.h"
#include "sc_tool/utils/InsertionOrderSet.h"

#include "llvm/ADT/StringRef.h"
#include "llvm/ADT/Optional.h"
#include "llvm/ADT/APSInt.h"
#include <iostream>
#include <vector>
#include <deque>
#include <unordered_map>

namespace sc_elab 
{
struct RecordMemberNameKey {
    // Parent records/arrays declarations (starting with bottommost) 
    // @my_module.rec_a.rec_b.m -> {@rec_a, @rec_b}
    std::vector<const clang::ValueDecl*> parDecls;
    // Parent module/MIF 
    ObjectView parent;
    const clang::ValueDecl* decl; 
    
    RecordMemberNameKey(ObjectView parent, const clang::ValueDecl* decl) :
        parent(parent), decl(decl)
    {}
    
    bool operator == (const RecordMemberNameKey& other) const {
        return (decl == other.decl && parent == other.parent && 
                parDecls == other.parDecls);
    }
};
}

namespace std 
{
template<> struct hash<sc_elab::RecordMemberNameKey>
{
    typedef sc_elab::RecordMemberNameKey argument_type;
    typedef std::size_t result_type;
    result_type operator()(argument_type const &obj) const noexcept
    {
        result_type res = std::hash<uint32_t>{}(obj.parent.getID()) ^ 
                          std::hash<void*>{}((void*)obj.decl);
        for (auto i : obj.parDecls) {
            res = res ^ std::hash<const void*>{}((const void*)i);
        }
        return res;
    }
};
}

namespace sc_elab 
{
typedef llvm::SmallVector<VerilogVar*,1> VerilogVarsVec;

/// Generates unique names inside module body
class UniqueNamesGenerator {
public:
    void reset() { 
        takenNames.clear(); 
        changedNames.clear(); 
    }
    std::string getUniqueName (const std::string & suggestedName);
    
    bool isTaken(const std::string & name);
    bool isChanged(const std::string & name);

    UniqueNamesGenerator () = default;
    UniqueNamesGenerator (UniqueNamesGenerator &&) = default;
    UniqueNamesGenerator (const UniqueNamesGenerator &) = delete;
    UniqueNamesGenerator& operator=(UniqueNamesGenerator &&) = default;

private:
    // Names already taken
    std::set<std::string> takenNames;
    // Names have collision, store original name which has been modified
    std::set<std::string> changedNames;
};

//=============================================================================
/// Verilog Variable object
class VerilogVar {
public:

    VerilogVar(const VerilogVar&) = delete;
    VerilogVar(VerilogVar&&) = default;

    ~VerilogVar() {}
    const std::string& getName() const { return name;}
    size_t getBitwidth() const { return bitwidth; }
    const IndexVec getArrayDims() const { return arrayDims; }
    const std::string & getComment() const { return comment; }
    void setComment(const std::string& str) { comment = str; }

    bool isSigned() const { return isSignedVal; }
    bool isArray() const { return !arrayDims.empty(); }

    bool isConstant() const { return !initVals.empty(); }
    const APSIntVec & getInitVals() const { return initVals; };

    bool operator == (const VerilogVar &other) const
    {
        return (name == other.name) && (bitwidth == other.bitwidth)
            && (arrayDims == other.arrayDims) && (initVals == other.initVals)
            && (isSignedVal == other.isSignedVal);
    }

    bool operator != (const VerilogVar &other) const
    {
        return !(*this == other);
    }

private:
    // VerilogVars are created by VerilogModule to keep names unique
    friend class VerilogModule;
    VerilogVar(llvm::StringRef name, size_t bitwidth
        , IndexVec arrayDims
        , bool isSigned
        , APSIntVec initVals = {}
        , llvm::StringRef comment = "" )
        : name (name), bitwidth (bitwidth), arrayDims(std::move(arrayDims))
        , initVals(std::move(initVals)), isSignedVal(isSigned), comment(comment)
    {}

    std::string name;
    size_t bitwidth;
    IndexVec arrayDims;
    APSIntVec initVals;
    bool isSignedVal;
    std::string comment;
};

/// Reference to Verilog variable, unpacked array element
class VerilogVarRef
{
public:
    const VerilogVar *var;
    IndexVec indicies;

    VerilogVarRef(const VerilogVar *var, IndexVec indicies = {})
    : var(var), indicies(std::move(indicies))
    {}

    bool operator == (const VerilogVarRef& other) const
    {
        return (var == other.var) && (indicies == other.indicies);
    }

    bool operator != (const VerilogVarRef& other) const
    {
        return !(*this == other);
    }
};

//=============================================================================
/// Verilog module instance with port bindings
class VerilogModuleInstance {
public:

    // we store strings here istead of VerilogVar* pointers, because during
    // unification actual variables may be destroyed
    typedef std::pair<std::string, std::string> PortBinding;

    VerilogModuleInstance (llvm::StringRef name, ModuleMIFView modObj)
        : name (name)
        , modObj (modObj)
    {}

    const std::string& getName() const
    {
        return name;
    }

    const ModuleMIFView& getModObj() const
    {
        return modObj;
    }

    const std::vector<PortBinding>& getBindings() const
    {
        return bindings;
    }


    /// Creates port binding in Verilog in form
    /// .instancePort( hostVar[x][y][z] )
    void addBinding(VerilogVar* instancePort, VerilogVarRef hostVarRef);

    bool operator == (const VerilogModuleInstance &other) const
    {
        if (name != other.name)
            return false;

        if (bindings.size() != other.bindings.size())
            return false;

        for (size_t i = 0; i < bindings.size(); ++i) {
            auto thisBind = bindings[i];
            auto otherBind = other.bindings[i];

            if (thisBind.first != otherBind.first)
                return false;

            if (thisBind.second != otherBind.second)
                return false;
        }

        return true;
    }

private:
    const std::string name;
    ModuleMIFView modObj;
    std::vector<PortBinding> bindings;
};

//=============================================================================
/// Verilog Variable with direction
class VerilogPort {
public:

    VerilogPort(PortDirection dir, const VerilogVar * var)
    : direction(dir), variable(var)
    {}

    PortDirection getDirection() const
    {
        return direction;
    }

    const VerilogVar *getVariable() const
    {
        return variable;
    }

    bool operator == (const VerilogPort &other) const
    {
        if (direction != other.direction)
            return false;

        if ((*variable) != (*(other.variable)))
            return false;

        return true;
    }

    bool operator != (const VerilogPort &other) const
    {
        return !(*this == other);
    }

private:
    PortDirection direction;
    const VerilogVar * variable;

};

//=============================================================================
/// Assignment in Verilog module body A[...] =  B[...];
class Assignment {
    VerilogVarRef left;
    VerilogVarRef right;

public:

    Assignment (const VerilogVar * lval, const VerilogVar * rval)
        : left{lval, {}}, right{rval, {}} {}

    Assignment (VerilogVarRef left, VerilogVarRef right)
        : left(std::move(left)), right(std::move(right)) {}

    VerilogVarRef getLeft() const { return left; }
    VerilogVarRef getRight() const { return right; }
    const VerilogVar* getLeftVar() const { return left.var; }
    const VerilogVar* getRightVar() const { return right.var; }
    const IndexVec& getLeftIdx() const { return left.indicies; }
    const IndexVec& getRightIdx() const { return right.indicies; }

    bool operator == (const Assignment &other) const
    {
        return (*left.var == *other.left.var) &&
            (left.indicies == other.left.indicies) &&
            (*right.var == *other.right.var) &&
            (right.indicies == other.right.indicies);
    }

    bool operator != (const Assignment &other) const
    {
        return !(*this == other);
    }

};

struct VerilogProcCode {

    VerilogProcCode () {}

    VerilogProcCode (std::string body)
    : body(std::move(body)) {}

    VerilogProcCode (std::string body, std::string localVars, 
                     std::string resetSection, std::string tempAsserts,
                     std::string tempRstAsserts) : 
        body(std::move(body)), localVars(std::move(localVars)), 
        resetSection(std::move(resetSection)), 
        tempAsserts(std::move(tempAsserts)),
        tempRstAsserts(std::move(tempRstAsserts))
    {}

    std::string body = "";
    std::string localVars = "";
    std::string resetSection = "";
    std::string tempAsserts = "";
    std::string tempRstAsserts = "";
};

//=============================================================================
/// Generated Verlog module
class VerilogModule
{
public:
    /// Variable kind to detect multiple use violations
    /// vkConst -- constant qualified variable with no known integer value
    enum class VarKind {vkVariable, vkConst, vkChannel};
    
    VerilogModule(ModuleMIFView elabObj) : elabModObj(elabObj) 
    {}

    VerilogModule(VerilogModule &&) = delete;
    VerilogModule(const VerilogModule&) = delete;
    VerilogModule& operator=(const VerilogModule&) = delete;
    VerilogModule& operator=(VerilogModule&&) = delete;

    bool operator == (VerilogModule &other) const { return getName() == other.getName(); }

    /// Remove assignments for unused variables (@assignments) and 
    /// update required variables (@requiredVars)
    void filterAssignments();
    
    /// Remove unused ports and signals declarations and their assignments
    void removeUnusedVariables();
    
    /// Detect multiple used/defined variable/channel in different processes
    void detectUseDefErrors();
    
    void serializeToStream(llvm::raw_ostream &os) const;

    const ModuleMIFView getModObj() const { return elabModObj; }
    const std::string& getName() const { return name; }
    void setName(const std::string& newName) { name = newName; }
    void setCommentName(const std::string& newName) { commentName = newName; }
    const std::string& getComment() const { return comment; }
    void setComment(const std::string &newComment) { comment = newComment; }
    
    const std::vector<PortView> & getScPorts() const { return scPorts; }

    void addScPort(PortView port) { scPorts.push_back(port); }

    void addModuleInstance(ModuleMIFView modObj, llvm::StringRef name);

    // signal or port
    VerilogVar *createChannelVariable( ObjectView systemcObject,
                                    llvm::StringRef suggestedName,
                                    size_t bitwidth,
                                    IndexVec arrayDims,
                                    bool isSigned,
                                    APSIntVec initVals = {},
                                    llvm::StringRef comment = "");

    // not sc_object, plain C++
    VerilogVar *createDataVariable( ObjectView cppObject,
                                    llvm::StringRef suggestedName,
                                    size_t bitwidth,
                                    IndexVec arrayDims,
                                    bool isSigned,
                                    APSIntVec initVals = {},
                                    llvm::StringRef comment = "");

    /// The same as previous, but for member variable of MIF array element,
    /// provides the same name for all array instances
    VerilogVar* createDataVariableMIFArray(ObjectView cppObject,
                                           ObjectView parentObject,
                                           llvm::StringRef suggestedName,
                                           size_t bitwidth,
                                           IndexVec arrayDims,
                                           bool isSigned,
                                           APSIntVec initVals = {},
                                           llvm::StringRef comment = "");
    
    // Create process local variable or member variable used in the process
    VerilogVar* createProcessLocalVariable(ProcessView procView,
                                           llvm::StringRef suggestedName,
                                           size_t bitwidth,
                                           IndexVec arrayDims,
                                           bool isSigned,
                                           APSIntVec initVals = {},
                                           llvm::StringRef comment = "");
    
    // Create process local variable or member variable used in the process
    // Do not register variable in @procVarMap to avoid its declaration,
    // required for non zero elements of MIF array
    VerilogVar* createProcessLocalVariableMIFNonZero(ProcessView procView,
                                           llvm::StringRef suggestedName,
                                           size_t bitwidth,
                                           IndexVec arrayDims,
                                           bool isSigned,
                                           APSIntVec initVals = {},
                                           llvm::StringRef comment = "");

    // Create auxilary Verilog variable for port binding purposes, it has no mapping
    // to elaboration object (not exists in SystemC source)
    VerilogVar* createAuxilarySignal(llvm::StringRef suggestedName,
                                     size_t bitwidth,
                                     IndexVec arrayDims,
                                     bool isSigned,
                                     APSIntVec initVals = {},
                                     llvm::StringRef comment = "");

    // Create auxilary Verilog port for port binding purposes, it has no mapping
    // to elaboration object (not exists in SystemC source)
    VerilogVar* createAuxilaryPort(PortDirection dir,
                                   llvm::StringRef suggestedName,
                                   size_t bitwidth,
                                   IndexVec arrayDims,
                                   bool isSigned,
                                   APSIntVec initVals = {},
                                   llvm::StringRef comment = "");


    /// Create @var = @next_var assignment pair for variable
    void addProcRegisterNextValPair(ProcessView procView, VerilogVar *regVar,
                                    VerilogVar *nextVar, 
                                    const std::string& suffix = "");
    
    /// Check uniqueness of given variable to prevent multiple 
    /// @var = @next_var assignments for a member of MIF array elements
    bool checkProcUniqueVar(ProcessView procView, VerilogVar *regVar);
    
    /// Makes existing variable process-local
    void convertToProcessLocalVar(const VerilogVar* var, ProcessView procView);

    void addConstDataVariable(ObjectView objView, const std::string &name);

    /// sc_signal
    void addSignal(VerilogVar *var);

    /// Add Verilog @assign statement
    void addAssignment(VerilogVar *lval, VerilogVar *rval) {
        assignments.push_back({lval, rval});
    }

    // Add Verilog @assign statement
    void addAssignment(VerilogVarRef left, VerilogVarRef right) {
        assignments.emplace_back(std::move(left), std::move(right));
    }

    VerilogVarsVec getVerVariables(ObjectView scObj) const;

    VerilogModuleInstance* getInstance(ModuleMIFView modObj);

    // converts existing variable to port
    void convertToPort(const VerilogVar * var, PortDirection dir);

    // converts existing variable to signal
    void convertToSignal(const VerilogVar * var);

    void addVerilogPort(VerilogVar *var, PortDirection dir);

    void addProcess(ProcessView proc);
    
    std::deque<ProcessView> &getProcesses() {return processes; }

    void addProcessBody(ProcessView proc, VerilogProcCode code);

    /// Add code for all module level SVA properties
    void addSvaPropertyCode(const std::string& code) {
        svaPropCode = code; 
    }
    
    UniqueNamesGenerator& getNameGen() { return nameGen; }

    bool isIntrinsic() const
    {
        return verilogIntrinsic.hasValue();
    }

    llvm::Optional<std::string> getVerilogIntrinsic() const
    {
        return verilogIntrinsic;
    }

    void setVerilogIntrinsic(std::string &moduleStr) {
        verilogIntrinsic = moduleStr;
    }

    bool hasSvaProperties() const
    {
        return !svaProperties.empty();
    }

    std::vector<const clang::FieldDecl*> getSvaProperties() const
    {
        return svaProperties;
    }

    void setSvaProperties(const std::vector<const clang::FieldDecl*>& props) {
        svaProperties = props;
    }

    bool isEquivalentTo(VerilogModule &otherMod) const;
    
    void addVarUsedInProc(const ProcessView& proc, const VerilogVar* var,
                          const bool isConst, const bool isChannel) {
        const VarKind varKind = isConst ? VarKind::vkConst : 
                                    isChannel ? VarKind::vkChannel :
                                                VarKind::vkVariable;
        procUseVars[proc].emplace(var, varKind);
    }
    
    void addVarUsedInSva(const VerilogVar* var, bool isConst, bool isChannel) {
        const VarKind varKind = isConst ? VarKind::vkConst : 
                                    isChannel ? VarKind::vkChannel :
                                                VarKind::vkVariable;
        svaUseVars.emplace(var, varKind);
    }

    void addVarDefinedInProc(const ProcessView& proc, const VerilogVar* var,
                             const bool isConst, const bool isChannel) {
        const VarKind varKind = isConst ? VarKind::vkConst : 
                                    isChannel ? VarKind::vkChannel :
                                                VarKind::vkVariable;
        procDefVars[proc].emplace(var, varKind);
    }

    void addVarBindedInMod(const VerilogVar* var) {
        procBindVars.insert(var);
    }
    
    void addNotReplacedVar(const sc::SValue& val) {
        notReplacedVars.insert(val);
    }
    
    void putValueForVerVar(const VerilogVar* var, const sc::SValue& val) {
        verVar2Value.emplace(var, val);
    }

    const sc::SValue& getValueForVerVar(const VerilogVar* var) const {
        auto i = verVar2Value.find(var);
        if (i == verVar2Value.end()) {
            return sc::NO_VALUE;
        }
        return i->second;
    }
    
public:
    /// If @procObj executed in module IF get modular IF instance name if possible
    /// It is possible for topmost class if it directly inherited @sc_interface
    llvm::Optional<std::string> getModularIfName(ProcessView procObj) const;
    /// Get process name unique in the module
    std::string getProcName(ProcessView procObj) const;

    /// Generate verilog code for process
    void serializeProcess(llvm::raw_ostream &os, ProcessView procObj) const;
    
    /// Check SVA argument does not have changed names and trim spaces
    llvm::Optional<std::string> parseSvaArg(const std::string& origStr) const;
    
    /// Check for SVA property instances have @clk port connected
    //void checkSvaClkBound() const;

    /// Translate SystemC assertion string into SVA string
    //llvm::Optional<std::string> transSvaString(const std::string& origStr) const;
    
    /// Generate always block for method process and for thread process in 
    /// non-split mode 
    void serializeProcSingle(llvm::raw_ostream &os, ProcessView procObj) const;
    /// Generate pair of always_comb/always_ff for thread process in split mode
    void serializeProcSplit(llvm::raw_ostream &os, ProcessView procObj) const;
    /// generate sensitivity list for always @(...)
    void serializeSensList(llvm::raw_ostream &os, ProcessView procObj) const;
    /// Get process sensitivity string
    std::string getSensEventStr(const ProcessView& procObj) const;
    /// serialize reset condition : if ( ~reset )
    void serializeResetCondition(llvm::raw_ostream &os, ProcessView procObj) const;

    ModuleMIFView elabModObj;

    std::string name;
    std::string commentName;
    std::string comment;

    /// Map VerilogVar to SValue
    std::unordered_map<const VerilogVar*, sc::SValue> verVar2Value;
    
    /// Plain data variables
    std::deque<VerilogVar> dataVars;

    std::unordered_map<ObjectView, VerilogVar*> dataVarMap;

    /// Member of MIF array element variables, 
    /// excluded from multiple process access error reporting
    std::unordered_set<const VerilogVar*> memMifArrVars;

    /// Signal / Port variables
    std::deque<VerilogVar> channelVars;

    /// SystemC object -> verilog variable, use VerilogVarsVec to support 
    /// signal of record
    std::unordered_map<ObjectView, VerilogVarsVec > channelVarMap;

    /// all systemc ports
    std::vector<PortView> scPorts;

    /// all verilog ports
    std::vector<VerilogPort> verilogPorts;

    /// all verilog variables representing signals
    std::vector<const VerilogVar*> verilogSignals;

    /// module instances
    std::deque<VerilogModuleInstance> instances;
    std::unordered_map<ModuleMIFView, VerilogModuleInstance*> instanceMap;

    /// processes
    std::deque<ProcessView> processes;
    std::unordered_map<ProcessView, VerilogProcCode> procBodies;

    /// Process-local variables (registers?)
    std::deque<VerilogVar> procVars;
    std::unordered_map<ProcessView, 
                       sc::InsertionOrderSet<const VerilogVar*>> procVarMap;
    /// Process-local constants defined in reset section
    std::unordered_map<ProcessView, std::vector<const VerilogVar*>> procConstMap;

    /// @reg <= @reg_next assignments for process, pointers to dataVars and others
    /// <<curr, next>, MIF array element suffix>
    std::unordered_map<ProcessView, std::vector<
        std::pair<std::pair<const VerilogVar*, const VerilogVar*>, 
                  std::string>>> procRegNextPairs;

    /// To provide uniqueness in @procRegNextPairs/@procVarMap
    std::unordered_map<ProcessView, std::unordered_set<VerilogVar*>> procRegVars;

    /// Variables/channels used and defined in processes
    std::unordered_map<ProcessView, std::unordered_map<const VerilogVar*, 
                        const VarKind>> procUseVars;
    std::unordered_map<ProcessView, std::unordered_map<const VerilogVar*, 
                        const VarKind>> procDefVars;
    /// Channels binded in host module up/down/cross module 
    std::unordered_set<const VerilogVar*> procBindVars;
    /// Variables/channels used in SVA properties at module scope
    std::unordered_map<const VerilogVar*, const VarKind> svaUseVars;
    
    /// Variables not eligible to remove, will be declared in the module
    std::unordered_set<const VerilogVar*> requiredVars;
    
    /// Variables and constants not replaced by integer values, 
    /// used to detect required variables
    std::unordered_set<sc::SValue> notReplacedVars;

    // Continous assignments
    std::vector<Assignment> assignments;

    mutable UniqueNamesGenerator nameGen;
    
    /// Names for member variables of MIF array elements
    /// <parent, variable>
    std::unordered_map<RecordMemberNameKey, std::string> memberMIFArrayNames;

    llvm::Optional<std::string> verilogIntrinsic;
    
    /// Field declarations for SVA properties
    std::vector<const clang::FieldDecl*> svaProperties;
    std::string svaPropCode;

};


} // end namespace sc_elab

//=============================================================================

namespace std {

template<> struct hash<sc_elab::VerilogModule>
{
    typedef sc_elab::VerilogModule argument_type;
    typedef std::size_t result_type;
    result_type operator()(argument_type const &obj) const noexcept
    {
        // unique name is guaranteed
        return std::hash<std::string>{}(obj.getName());
    }
};

}

#endif // SCTOOL_SCVERILOGMODULE_H

