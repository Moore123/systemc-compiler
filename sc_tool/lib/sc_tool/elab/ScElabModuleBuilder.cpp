/******************************************************************************
 * Copyright (c) 2020, Intel Corporation. All rights reserved.
 * 
 * SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception.
 * 
 *****************************************************************************/

/**
 * Author: Roman Popov
 */

#include <sc_tool/elab/ScElabModuleBuilder.h>
#include <sc_tool/utils/RawIndentOstream.h>
#include <sc_tool/ScCommandLine.h>
#include <sc_tool/diag/ScToolDiagnostic.h>
#include <sc_tool/elab/ScElabProcBuilder.h>
#include <sc_tool/elab/ScElabDatabase.h>
#include <sc_tool/elab/ScVerilogModule.h>
#include <sc_tool/utils/ScTypeTraits.h>
#include <sc_tool/utils/DebugOptions.h>
#include <sc_tool/ScCommandLine.h>
#include <clang/AST/Type.h>
#include <clang/AST/Expr.h>
#include <llvm/Support/raw_ostream.h>
#include <sc_elab.pb.h>
#include <iostream>

using namespace sc_elab;
using namespace llvm;
using namespace clang;
using namespace sc;

namespace
{
using std::cout; using std::endl;
    
// -----------------------------------------------------------------------------
// -----------------------------------------------------------------------------

struct NameNode
{

    enum NodeKind
    {
        ARRAY = 0, STRUCT = 1
    };

    const NodeKind kind;
    const std::string name;
    const std::vector<size_t> dims;
    const std::vector<size_t> ids;

    NameNode(NodeKind kind,
             std::string name,
             std::vector<size_t> dims = {},
             std::vector<size_t> ids = {})
        : kind(kind),
          name(std::move(name)),
          dims(std::move(dims)),
          ids(std::move(ids)) {}
};

// -----------------------------------------------------------------------------
// -----------------------------------------------------------------------------

class ScElabModuleBuilder
{

public:
    explicit ScElabModuleBuilder(
                        ElabDatabase *elabDB,
                        const std::unordered_map<size_t, size_t>& movedObjs) : 
            elabDB(elabDB), movedObjs(movedObjs) 
    {}

    void run();

private:

    /// Port bind direction
    enum BindDirection
    {
        BIND_SAME,       /// < Port bound in same module where defined
        BIND_UP,         /// < Upwards (normal bind)
        BIND_DOWN,       /// < Downwards (binded to submodule)
        BIND_CROSS,      /// < Cross-hierarchy bind (binded in other subtree)
        BIND_EXTERNAL    /// < Port is connected outside of design hierarchy
    };

    using FlattenReq = bool;

    ElabDatabase *elabDB;
    // Dynamic objects moved from module where allocated to module where 
    // pointer to this object
    std::unordered_map<size_t, size_t> movedObjs;
    
    std::unordered_set<ObjectView> visitedObj;
    VerilogModule *curVerMod = nullptr;
    std::vector<NameNode> nameStack;
    
    /// Dynamic object with multiple pointer already traversed, used to exclude
    /// multiple traverse 
    std::unordered_set<ObjectView> multPtrObjs;
    
    /// Bound signals with its auxiliary variable in parent module which used
    /// to bind in-port to out-port (in-port->auxiliary-variable<-out-port)
    /// <child signal object bound to port, variable for signal in parent module>
    std::unordered_map<ObjectView, VerilogVar*> boundSigObjs;
    /// Bound signals collection, used to avoid multiple bound to auxiliary
    // variable if original signal has multiple binds
    std::unordered_set<ObjectView> boundSignals;

    bool activeSignal = false;
    bool activePort = false;

    /// channel arrays support
    bool activeChanArray = false;
    ArrayView *chanArrayView = nullptr;

    ObjectView curScObj;

    UniqueNamesGenerator modNameGen;

private:

    void traverseModule(ModuleMIFView modView);
    FlattenReq traverseDFS(ObjectView obj);
    FlattenReq traverseRecord(RecordView record);
    FlattenReq traverseValue(PrimitiveView prim);
    FlattenReq traverseArray(ArrayView arrView);
    FlattenReq traverseSignal(SignalView signalView);
    FlattenReq traversePtrOrRef(PtrOrRefView ptrref);
    FlattenReq traversePort(PortView port);
    FlattenReq traverseProcess(ProcessView proc);
    FlattenReq generateVariable(ObjectView objView);

    //void createPortBindings(VerilogModule &verMod);

    void createPortBindingsKeepArrays(VerilogModule &verMod);

    BindDirection getBindDirection(PortView portView) const;

//    void bindPortSame(VerilogModule &verMod,
//                      PortView port,
//                      bool arrayBind = false);
//    void bindPortDown(VerilogModule &verMod,
//                      PortView port,
//                      bool arrayBind = false);
//    void bindPortUp(VerilogModule &verMod,
//                    PortView port,
//                    bool arrayBind = false);
//    void bindPortCross(VerilogModule &verMod,
//                       PortView port,
//                       bool arrayBind = false);
    //void materializePort(VerilogModule &verMod, PortView port);


    void bindAux(PortView portEl, const VerilogVarsVec &verPortVars,
        BindDirection bindDirection, bool isUniformBind);
    void bindPortUpAux(PortView portEl, const VerilogVarsVec &verPortVars, bool isUniformArrayBind);
    void bindPortSameAux(PortView portEl, const VerilogVarsVec &verPortVars, bool isUniformArrayBind);
    void bindPortDownAux(PortView portEl, const VerilogVarsVec &verPortVars, bool isUniformArrayBind);
    void bindPortCrossAux(PortView portEl, const VerilogVarsVec &verPortVars, bool isUniformArrayBind);
    void bindPortExternalAux(PortView portEl, const VerilogVarsVec &verPortVars, bool isUniformArrayBind);

    void createProcessBodies(VerilogModule &verMod);

    llvm::Optional<std::string> getVerilogIntrinsic(const ModuleMIFView& modView);
    /// Get vendor memory name to use in Verilog module instead of module name
    /// @__SC_TOOL_MEMORY_NAME__ string in module 
    llvm::Optional<std::string> getVerilogMemName(const ModuleMIFView& modView);

    /// Get assert properties from @SCT_ASSERT macro in module scope
    std::vector<const clang::FieldDecl*> 
    getSvaProperties(const RecordView& recView);
    
    /// Check if port array needs to be flattened so each port is binded
    /// separately
    bool isFlattenArrayBind(const ArrayElemVec &allArrayPorts,
                            const ArrayElemVec &allArrayBinds) const;

    /// Binding singular port or binding array to array uniformly
    void uniformBind(const PortView &port);


    /// Binding each element of Verilog array separately :
    /// Create a Verilog variable for each array element and bind it
    void flattenArrayBind(VerilogModule &portHostMod,
                          const PortView &firstPort,
                          const ArrayElemVec &allArrayPorts);
};

void ScElabModuleBuilder::run()
{
    RecordValues::setElabDB(elabDB);
    
    // Create module bodies w/o processes
    for (auto modView : elabDB->getModules()) {
        //std::cout << "--------------------------------------" << std::endl 
        //      << "Module " << modView.getName() << std::endl;
        
        // Add module to static collection, used to resolve pointer to module
        RecordValues::addRecordView(modView);
        
        // Create all module members (member signals, variables). 
        // do not traverse MIF
        if (!modView.isModularInterface()) {
            traverseModule(modView);
        }
    }

    // Fill record values for each module/MIF, only module/MIF can be passed 
    // through pointer into another module
    RecordValues::fillValues();
    //RecordValues::print();

    // Create bindings
    //std::cout << "--------------------------------------" << std::endl 
    //          << "Create bindings "<< std::endl;
    for (auto &verMod : elabDB->getVerilogModules()) 
    {
        createPortBindingsKeepArrays(verMod);
    }

    // Compare and remove redundant modules, only equivalent C++ types compared
    elabDB->uniquifyVerilogModules();
    
    std::unordered_set<clang::QualType> modTypes;
    for (const auto& mod : elabDB->getModules()) {
        //std::cout << "   " << mod.getName() << std::endl;
        modTypes.insert(mod.getType());
    }
    std::cout << "--------------------------------------" << std::endl 
              << "Module number " << modTypes.size()  << std::endl;

    size_t procNum = 0;
    for (auto &verMod : elabDB->getVerilogModules()) {
        procNum += verMod.getProcesses().size();
    }
    std::cout << "Process number " << procNum << std::endl
              << "--------------------------------------" << std::endl 
              << std::flush;

    // Fill state, run method and thread process analysis in ScProcAnalyzer
    for (auto &verMod : elabDB->getVerilogModules()) {
        // Process analysis for all threads and methods
        createProcessBodies(verMod);

        // Remove unused ports and signals declarations and their assignments
        verMod.removeUnusedVariables();
        
        // Detect multiple used/defined variable/channel in different processes
        verMod.detectUseDefErrors();
    }
    
    DEBUG_WITH_TYPE(DebugOptions::doModuleBuilder,
                    for (auto &verMod : elabDB->getVerilogModules()) {
                        if (!verMod.isIntrinsic())
                            verMod.serializeToStream(outs());
                        outs() << "\n";
                    });
}

void ScElabModuleBuilder::traverseModule(ModuleMIFView modView)
{
    curVerMod = elabDB->addVerilogModule(modView);

    auto recordDecl = modView.getType()->getAsCXXRecordDecl();

    std::string name = recordDecl->getNameAsString();

    // Verilog intrinsic
    auto intrinsic = getVerilogIntrinsic(modView);
    
    // Try to get Verilog module name, used for vendor memory 
    auto memory = getVerilogMemName(modView);
    
    // Replace module name with Verilog module name
    if (memory) {
        if (!memory.getValue().empty()) {
            name = memory.getValue();
        }
    }
    
    // Add SVA properties to Verilog module
    if (!noSvaGenerate) {
        curVerMod->setSvaProperties(getSvaProperties(modView));
    }

    curVerMod->setCommentName(name);  // Module name w/o prefix      
    curVerMod->setComment(modView.getName()); // Hierarchical name

    if (intrinsic) {
        // Intrinsic with or w/o implementation, including memory
        curVerMod->setVerilogIntrinsic(*intrinsic);
        curVerMod->setName(name);
        
    } else 
    if (memory) {
        // Memory module with implementation 
        std::string uniqueName = modNameGen.getUniqueName(name);
        if (uniqueName != name) {
            ScDiag::reportScDiag(recordDecl->getBeginLoc(),
                                 ScDiag::SYNTH_MEMORY_NON_UNIQUE) << name;
        }
        curVerMod->setName(uniqueName);
       
    } else {
        // Normal module with implementation
        std::string uniqueName = modNameGen.getUniqueName(modulePrefix + name);
        curVerMod->setName(uniqueName);
    }

    for (auto memberView : modView.getAllMembers()) {
        SCT_TOOL_ASSERT (nameStack.empty(), "Name stack is not empty");
        
        if (memberView.isDynamic()) {
            // Skip dynamically allocated objects, since they must be traversed
            // from their owning pointers, with exception for modules and 
            // processes since they have no explicit owning pointers

            if (memberView.isModule()) {
                nameStack.emplace_back(NameNode::STRUCT, "DYN_ALLOC");
            } else 
            if (memberView.isPrimitive() && memberView.primitive()->isProcess()) {
                // No name for process
            } else {
                continue;
            }
        }
        
        traverseDFS(memberView);

        if (memberView.isDynamic() && memberView.isModule()) {
            nameStack.pop_back();
        }
    }
}

// Return @true means all other elements of array must be traversed, 
// Return @true means elements are already generated (when first element traversed)
ScElabModuleBuilder::FlattenReq ScElabModuleBuilder::traverseDFS(ObjectView obj)
{
    //std::cout << "traverseDFS #" << obj.getID() << std::endl;
    
    // Skip special variable
    if (obj.isDataMember() && obj.getFieldName() && 
        !obj.getFieldName()->compare("__SC_TOOL_MEMORY_NAME__"))
        return false;

    if (visitedObj.count(obj) && !(activePort || activeSignal))
        return false;

    visitedObj.insert(obj);

    if (obj.isDataMember() || obj.isStatic())
        nameStack.emplace_back(NameNode::STRUCT, *obj.getFieldName());

    FlattenReq flatten = false;

    if (obj.isAggragete()) {
        if (obj.isArrayLike()) {
            flatten = traverseArray(obj);
        } else 
        if (obj.isRecord()) {
            flatten = traverseRecord(obj);
        }
    } else 
    if (auto prim = obj.primitive()) {
        
        if (prim->isValue()) {
            flatten = traverseValue(*prim);
        }
        else if (prim->isPointer()) {
            flatten = traversePtrOrRef(*prim);
        }
        else if (prim->isReference()) {
            flatten = traversePtrOrRef(*prim);
        }
        else if (prim->isPort()) {
            flatten = traversePort(*prim);
        }
        else if (prim->isProcess()) {
            flatten = traverseProcess(*prim);
        }
        else { /* o nothing */}
    }

    if (obj.isDataMember() || obj.isStatic())
        nameStack.pop_back();

    return flatten;
}

ScElabModuleBuilder::FlattenReq ScElabModuleBuilder::traverseRecord(
                                                        RecordView record)
{
    FlattenReq flatten = false;

    if (record.isModule()) {
        flatten = generateVariable(record);
    } else 
    if (record.isSignal()) {
        activeSignal = true;
        curScObj = record;
        flatten = traverseSignal(record);
        activeSignal = false;
        
    } else 
    if (record.isModularInterface()) {
        for (auto member : record.moduleMIF()->getAllMembers())
            flatten |= traverseDFS(member);
        
    } else {
        // Plain record
        for (auto member : record.getMembers())
            flatten |= traverseDFS(member);
    }

    return flatten;
}

ScElabModuleBuilder::FlattenReq ScElabModuleBuilder::traverseValue(
                                                        PrimitiveView prim)
{
    return generateVariable(prim);
}

ScElabModuleBuilder::FlattenReq ScElabModuleBuilder::traverseArray(
                                                        ArrayView arrView)
{
    //using std::cout; using std::endl;
    bool chanArray = false;
    if (!activeChanArray && arrView.isChannelArray()) {
        chanArray = true;
        activeChanArray = true;
        chanArrayView = &arrView;
    }

    FlattenReq flatten = false;
    if (arrView.hasElements()) {
        // Constant or non-integer array
        if (arrView.isConstPrimitiveArray()) {
            generateVariable(arrView);
            flatten = true;
            
        } else {
//            auto elmObj = arrView.at(0);
//            auto modObj = elmObj.getParentModuleOrMIF();
//            cout << "elmObj " << elmObj.getDebugString() << ", modObj " << modObj.getDebugString() << endl;
//            if (modObj.isModularInterface()) {
//                cout << "is MIF" << endl;
//            }
            
            nameStack.push_back(NameNode(NameNode::ARRAY,
                                         "",
                                         {arrView.size()},
                                         {0}));
            flatten = traverseDFS(arrView.at(0));
            nameStack.pop_back();
            
            if (flatten) {
                for (size_t i = 1; i < arrView.size(); ++i) {
                    nameStack.push_back(NameNode(NameNode::ARRAY,
                                                 "",
                                                 {arrView.size()},
                                                 {i}));
                    flatten = traverseDFS(arrView.at(i));
                    SCT_TOOL_ASSERT (flatten, "");
                    nameStack.pop_back();
                }
            }
        }
        
    } else {
        // Non-constant integer array
        auto dims = arrView.getOptimizedArrayDims();
        std::vector<size_t> ids(dims.size(), 0);
        nameStack.emplace_back(NameNode::ARRAY, "", dims, ids);
        generateVariable(arrView);
        nameStack.pop_back();
    }

    if (chanArray) {
        activeChanArray = false;
        chanArrayView = nullptr;
    }

    return flatten;
}

ScElabModuleBuilder::FlattenReq ScElabModuleBuilder::traverseSignal(SignalView signalView)
{
    auto valueView = signalView.getSignalValue();

    if (valueView.isRecord())
        return traverseRecord(valueView);
    else if (valueView.isPrimitive())
        return generateVariable(valueView);
    else
        llvm_unreachable("bad signal type");

    return true;
}

static unsigned countStartPtrs(ObjectView pointee)
{
    unsigned ptrToStartCnt = 0;

    for (auto objPtr : pointee.getPointers()) {
        auto ptr = *objPtr.primitive()->ptrOrRef();

        if (ptr.isBaseOffsetPtr()) {
            if (*ptr.getOffset() == 0)
                ptrToStartCnt++;
        } else {
            ptrToStartCnt++;
        }
    }

    return ptrToStartCnt;
}

ScElabModuleBuilder::FlattenReq ScElabModuleBuilder::traversePtrOrRef(
    PtrOrRefView ptrref)
{
    if (ptrref.isNull())
        return true;

    if (ptrref.isNotNullDangling()) {
        ScDiag::reportScDiag(ScDiag::SC_WARN_ELAB_DANGLING_PTR, false) << 
                             ptrref.getDebugString();
        return true;
    }

    llvm::Optional<ObjectView> pointee = ptrref.pointeeOrArray();

    if (pointee) {
        //std::cout << "pointee " << pointee->getDebugString() << std::endl;

        // Ignore pointers to static objects
        if (!pointee->isDynamic()) {
            // Module/MIF can have multiple pointers when passed through
            // sc_port/pointer to another module but can lead to issues
            // with right object owner determination, so warning reported
            if (countStartPtrs(*pointee) > 1 && 
                (pointee->isModule() || pointee->isModularInterface())) {
                ScDiag::reportScDiag(ScDiag::SC_WARN_ELAB_MULT_PTRS) << 
                                     pointee->getDebugString();
            }
            
            return true;
        }

        if (countStartPtrs(*pointee) > 1) {
            // Module/MIF can have multiple pointers when passed through
            // sc_port/pointer to another module but can lead to issues
            // with right object owner determination, so warning reported
            if (pointee->isModule() || pointee->isModularInterface()) {
                ScDiag::reportScDiag(ScDiag::SC_WARN_ELAB_MULT_PTRS) << 
                                     pointee->getDebugString();
                // Control one traverse of such module object
                if (multPtrObjs.count(*pointee) == 0) {
                    multPtrObjs.insert(*pointee);
                    return traverseDFS(*pointee);
                }
                
            } else {
                ScDiag::reportScDiag(ScDiag::SC_ERROR_ELAB_MULT_PTRS) << 
                                     pointee->getDebugString();
            }
            return true;
        }
        
        return traverseDFS(*pointee);
        
    } else {
        return true;
    }
}

ScElabModuleBuilder::FlattenReq ScElabModuleBuilder::traversePort(PortView port)
{
    if (!port.isSignalPort()) // sc_port<IF>
        return true;

    activePort = true;
    // To generate port declaration after bindings
    curVerMod->addScPort(port);
    curScObj = port;
    auto signal = port.getBindedSignal();
    auto flatten = traverseSignal(signal);
    activePort = false;
    return flatten;
}

ScElabModuleBuilder::FlattenReq ScElabModuleBuilder::traverseProcess(
                                                           ProcessView proc)
{
    curVerMod->addProcess(proc);
    return true;
}

ScElabModuleBuilder::FlattenReq ScElabModuleBuilder::generateVariable(
                                                            ObjectView objView)
{
    using std::cout; using std::endl; using std::hex; using std::dec;
    //std::cout << "Generate variable " << objView.getDebugString() << " id " << objView.getID() << std::endl;

    FlattenReq flatten = false;

    if (objView.isModule())
        flatten = true;

    if (objView.isPrimitive() && objView.isConstant())
        flatten = true;

    // Checking for MIF array element
    bool zeroElmntMIF = false;
    bool noneZeroElmntMIF = false;
    ObjectView parent; 

    if (!objView.hasNoParent()) {
        parent = objView.getParentModuleOrMIF();
        //std::cout << "   parent " << parent.getDebugString() << std::endl;
        
        // Restore real parent for moved object
        auto i = movedObjs.find(objView.getID());
        if (i != movedObjs.end()) {
            parent = elabDB->getObj(i->second);
            //std::cout << "   restored parent " << parent.getDebugString() << " id " << i->second << std::endl;
        }
        
        if (parent.isModularInterface()) {
            // Get pointer to check if it is an array element
            if (parent.isDynamic()) {
                if (parent.getPointers().size() > 0) {
                    parent = parent.getPointers()[0];
                }
            }

            /*
            // Go through parents and pointers up to top or array
            while (!parent.isTopMod() && 
                   !parent.isArrayElement() && 
                   !parent.isArrayLike())
            {
                if (parent.getPointers().size() > 0) {
                    parent = parent.getPointers()[0];
                } else {
                    parent = parent.getParent();
                }
            }*/
            
            // Get indices and array element at index [0][0]...[0]
            const auto& objIndx = parent.getAsArrayElementWithIndicies();

            // Check zero/non-zero MIF array element
            if (!objIndx.indices.empty()) {
                for (auto i : objIndx.indices) {
                    if (i != 0) noneZeroElmntMIF = true;
                }
                zeroElmntMIF = !noneZeroElmntMIF;
            }
            parent = objIndx.obj;
        }
    }
    
    // Prevent instantiate top/parent module for module pointer in child module
    if (objView.isModule() && (objView.isTopMod() || parent == objView)) {
        return flatten;
    }
    
//    if (zeroElmntMIF || noneZeroElmntMIF) {
//        std::cout << "--- elementMIFArr parent " << parent.getDebugString() 
//                  << " id " << parent.getID() << " " << zeroElmntMIF 
//                  << noneZeroElmntMIF << std::endl;
//    }
    
    std::string name = nameStack.front().name;
    IndexVec arrayDims;

    for (size_t i = 1; i < nameStack.size(); ++i) {
        auto node = nameStack[i];
        if (node.kind == NameNode::ARRAY) {
            if (flatten)
                for (auto id : node.ids)
                    name += "_" + std::to_string(id);
            else
                for (auto dim : node.dims)
                    arrayDims.push_back(dim);
        }
        else
            name += "_" + node.name;
    }

    size_t bitwidth;
    bool isSigned = isSignedOrArrayOfSigned(objView.getType());

    APSIntVec initVals;

    if (objView.isModule()) {
        curVerMod->addModuleInstance(objView, name);
        
    } else {
        if (auto arrayView = objView.array()) {
            // generate constant array as localparam
            if (arrayView->isConstPrimitiveArray()) {
                curVerMod->addConstDataVariable(objView, name);
                return flatten;
            }
        }

        if (objView.isArrayLike()) {
            // array or std::vector of non-constant integer
            bitwidth = objView.array()->getOptimizedArrayBitwidth();
            
        } else {
            // primitive
            SCT_TOOL_ASSERT (objView.isPrimitive() && 
                             objView.primitive()->isValue(), "");
            auto valueView = *objView.primitive()->value();

            bitwidth = valueView.bitwidth();

            if (valueView.isConstant()) {
                if (valueView.int64Val())
                    initVals.emplace_back(APSInt(APInt(bitwidth,
                                                       *valueView.int64Val()),
                                                 false));
                else if (valueView.uint64Val())
                    initVals.emplace_back(APSInt(APInt(bitwidth,
                                                       *valueView.uint64Val()),
                                                 true));
            }
        }

        if (activePort) {
            curVerMod->createChannelVariable(curScObj,
                                    name, bitwidth, arrayDims, isSigned, 
                                    zeroElmntMIF || noneZeroElmntMIF);
        } else 
        if (activeSignal) {
            auto* sigVerVar = curVerMod->createChannelVariable(curScObj,
                                    name, bitwidth, arrayDims, isSigned, 
                                    zeroElmntMIF || noneZeroElmntMIF);
            // Avoid multiple declaration of signal variable
            if (!noneZeroElmntMIF) {
                curVerMod->addSignal(sigVerVar);
            }
            
        } else {
            // Provide same name for all MIF array instances
            if (zeroElmntMIF || noneZeroElmntMIF) {
                curVerMod->createDataVariableMIFArray(objView, parent, name, 
                                    bitwidth, arrayDims, isSigned, initVals);
            } else {
                curVerMod->createDataVariable(objView, name, 
                                    bitwidth, arrayDims, isSigned, initVals);
            }
        }
    }

    return flatten;
}

// Used for flatten array mode
/*void ScElabModuleBuilder::createPortBindings(VerilogModule &verMod)
{
    for (auto portView : verMod.getScPorts()) {
        auto bindDirection = getBindDirection(portView);

        switch (bindDirection) {
            case BIND_SAME:bindPortSame(verMod, portView);
                break;

            case BIND_DOWN:bindPortDown(verMod, portView);
                break;

            case BIND_UP:bindPortUp(verMod, portView);
                break;

            case BIND_CROSS:bindPortCross(verMod, portView);
                break;

            case BIND_EXTERNAL:materializePort(verMod, portView);
                break;
        }
    }
}*/

void ScElabModuleBuilder::createPortBindingsKeepArrays(VerilogModule &verMod)
{
    //cout << endl << "Module : " << verMod.getName() << endl;
    std::unordered_set<PortView> bindedPortsSet; // set of already bound ports

    for (PortView port : verMod.getScPorts()) {
        
        if (bindedPortsSet.count(port)) continue;
        
        // Get directly bound port/signal to this port
        auto directBind = port.getDirectBind();
        // If port is array element this function returns all elements with indices
        // Index object is vector contains all indices to support 
        // multidimensional array 
        auto allArrayPorts = port.getAllSimilarArrayElements();
        auto allArrayBinds = directBind.getAllSimilarArrayElements();
        // Check each element is bound to element with the same index
        bool isFlattenBind = isFlattenArrayBind(allArrayPorts, allArrayBinds);

        // All array elements will be bounded
        for (auto portel : allArrayPorts) {
            bindedPortsSet.insert(portel.obj);
        }

        if (!isFlattenBind) {
            uniformBind(port);
        } else {
            flattenArrayBind(verMod, port, allArrayPorts);
        }
    }
}

void ScElabModuleBuilder::uniformBind(const PortView &port)
{
    auto portHostMod = elabDB->getVerilogModule(port.getParentModule());
    auto verVars = portHostMod->getVerVariables(port);
    auto bindDirection = getBindDirection(port);

    for (auto * verVar : verVars) {
        if (bindDirection == BIND_UP || bindDirection == BIND_CROSS || bindDirection == BIND_EXTERNAL) {
            portHostMod->convertToPort(verVar, port.getDirection());
        } else if (bindDirection == BIND_DOWN || bindDirection == BIND_SAME) {
            portHostMod->convertToSignal(verVar);
        }
    }

    bindAux(port, verVars, bindDirection, true);

}

void ScElabModuleBuilder::flattenArrayBind( VerilogModule &portHostMod,
    const PortView &firstPort, const ArrayElemVec &allArrayPorts)
{
    // One variable represents all the array, but for record one variable per field
    const auto verVars = portHostMod.getVerVariables(firstPort);

    // Convert port array to signal array, so it can be accessed as array
    // from processes
    for (auto verVar : verVars) {
        portHostMod.convertToSignal(verVar);
    }

    // Create a separate port for each array element and assign statement
    for (auto portArrEl : allArrayPorts) {

        auto portEl = *portArrEl.obj.primitive()->port();
        auto bindDirection = getBindDirection(portEl);

        VerilogVarsVec portVerVarVec;

        // Generate auxiliary variables to represent array elements
        for (auto *verVar : verVars) {
            // Name for array element is generated from array name
            // by adding element indexes, like array_name_x_y
            auto portArrElName = verVar->getName();
            for (auto idx : portArrEl.indices)
                portArrElName += /*"_" +*/ std::to_string(idx);

            // If binding array element up/cross hierarchically, we generate
            // auxiliary port to represent it, when binding down, or in
            // same module, we generate auxiliary signal to represent it
            // BIND_UP -- normal bind to parent module port/signal
            // BIND_EXTR -- bound to something outside of module hierarchy
            // BIND_CROSS -- bound to port of module which is not parent or child
            // BIND_DOWN -- bound to port of child module
            // BIND_SAME -- bound to signal in the same module
            VerilogVar *auxVerVar;
            if (bindDirection == BIND_UP || bindDirection == BIND_CROSS || 
                bindDirection == BIND_EXTERNAL) {
                auxVerVar = portHostMod.createAuxilaryPort(
                                portEl.getDirection(),
                                portArrElName, verVar->getBitwidth(), 
                                {}, verVar->isSigned() );
            } else 
            if (bindDirection == BIND_DOWN || bindDirection == BIND_SAME) {
                auxVerVar = portHostMod.createAuxilarySignal(portArrElName,
                    verVar->getBitwidth(), {}, verVar->isSigned());
            } else {
                SCT_TOOL_ASSERT(false, "Incorrect bind direction");
            }

            // Assign generated variable to array element, or vice versa
            if (portEl.isInput()) {
                portHostMod.addAssignment({verVar, portArrEl.indices}, 
                                          {auxVerVar, {}});
            } else {
                portHostMod.addAssignment({auxVerVar, {}}, 
                                          {verVar, portArrEl.indices});
            }
            portVerVarVec.push_back(auxVerVar);
        }

        // Do binding
        bindAux(portEl, portVerVarVec, bindDirection, false);
    }
}

void ScElabModuleBuilder::bindAux(PortView portEl, 
                                  const VerilogVarsVec &verPortVars,
                                  BindDirection bindDirection, 
                                  bool isUniformBind)
{
    bool isArrayBind = !portEl.getAsArrayElementWithIndicies().indices.empty();
    bool isUniformArrayBind = isUniformBind && isArrayBind;

//    if (StringRef(verPortVars[0]->getName()).contains("benable")) {
//        int x;
//        x++;
//    }

    // Do binding
    switch (bindDirection) {
        case BIND_SAME:
            bindPortSameAux(portEl, verPortVars, isUniformArrayBind);
            break;

        case BIND_DOWN:
            bindPortDownAux(portEl, verPortVars, isUniformArrayBind);
            break;

        case BIND_UP:
            bindPortUpAux(portEl, verPortVars, isUniformArrayBind);
            break;

        case BIND_CROSS:
            bindPortCrossAux(portEl, verPortVars, isUniformArrayBind);
            break;

        case BIND_EXTERNAL:
            bindPortExternalAux(portEl, verPortVars, isUniformArrayBind);
            break;
    }
}

void ScElabModuleBuilder::bindPortUpAux(PortView portEl,
    const VerilogVarsVec &verPortVars, bool isUniformArrayBind)
{
    auto portHostMod = portEl.getParentModule();
    auto bindedObj = portEl.getDirectBind().getAsArrayElementWithIndicies();
    auto topParentMod = bindedObj.obj.getParentModule();

    DEBUG_WITH_TYPE(DebugOptions::doPortBind,
        llvm::outs() << "bindPortUpAux BIND " << portEl << " to " << bindedObj.obj << "\n";
    );
    
    auto parentModsList = portEl.getParentModulesList(topParentMod);
    SCT_TOOL_ASSERT (parentModsList.size() > 1, "");
    SCT_TOOL_ASSERT (parentModsList.back() == portHostMod, "");

    VerilogVarsVec hostVars;
    VerilogVarsVec instanceVars = verPortVars;
    IndexVec bindedIndexes;

    // Create auxilary ports and port bindings in parent module
    for (size_t i = parentModsList.size() - 1; i > 0; --i) {
        bool last = i == 1;

        ModuleMIFView instanceModObj = parentModsList.at(i);

        VerilogModule* hostVerMod = elabDB->getVerilogModule(
                                                parentModsList.at(i - 1));
        VerilogModuleInstance *instance = hostVerMod->getInstance(
                                                instanceModObj);

        // We need to create auxiliary ports in all host modules except last one
        // which contains a signal we will be binding to
        if (!last) {
            for (const auto *verVar : verPortVars) {
                auto *portVar = hostVerMod->createAuxilaryPort(
                                portEl.getDirection(), verVar->getName(), 
                                verVar->getBitwidth(), verVar->getArrayDims(), 
                                verVar->isSigned());

                hostVars.push_back(portVar);
            }
        } else {
            hostVars = hostVerMod->getVerVariables(bindedObj.obj);
            if (!isUniformArrayBind)
                bindedIndexes = bindedObj.indices;
        }

        SCT_TOOL_ASSERT (hostVars.size() == instanceVars.size(), "");

        for (size_t i = 0; i < hostVars.size(); ++i) {
            instance->addBinding(instanceVars[i], {hostVars[i], bindedIndexes});
            hostVerMod->addVarBindedInMod(hostVars[i]);
        }

        // on next iteration current host is an instance
        instanceVars = hostVars;
        hostVars.clear();
    }
}

void ScElabModuleBuilder::bindPortSameAux(PortView portEl, 
                                          const VerilogVarsVec &verPortVars,
                                          bool isUniformArrayBind)
{
    auto bindedObj = portEl.getDirectBind().getAsArrayElementWithIndicies();
    IndexVec bindedIndices;
    if (!isUniformArrayBind) {
        bindedIndices = bindedObj.indices;
    }
    
    DEBUG_WITH_TYPE(DebugOptions::doPortBind,
        llvm::outs() << "bindPortSameAux BIND " << portEl << " to " << bindedObj.obj << "\n";
    );

    auto *hostVerMod = elabDB->getVerilogModule(portEl.getParentModule());
    auto bindedVerVars = hostVerMod->getVerVariables(bindedObj.obj);
    bool isPortInMIF = portEl.getParentModuleOrMIF().isModularInterface();
    bool isIntrinsic = hostVerMod->isIntrinsic();

    if (bindedObj.obj.isSignal() && !isPortInMIF && !isIntrinsic) {
        ScDiag::reportScDiag(ScDiag::SC_PORT_BOUND_SIGNAL_SAME, false) << 
                             portEl.getSCName();
    }
    
    SCT_TOOL_ASSERT (bindedVerVars.size() != 0, "No bind port variable found");
    SCT_TOOL_ASSERT (verPortVars.size() != 0, "No port variable found");
    SCT_TOOL_ASSERT (bindedVerVars.size() == verPortVars.size(), 
                     "Different sizes of bind and target port variables");

    for (size_t i = 0; i < verPortVars.size(); ++i) {
        if (portEl.isInput()) {
            hostVerMod->addAssignment({verPortVars[i], {}},
                                 {bindedVerVars[i], bindedIndices});
        }
        else if (portEl.isOutput()) {
            hostVerMod->addAssignment({bindedVerVars[i], bindedIndices},
                                 {verPortVars[i], {}});
        }
    }
}

void ScElabModuleBuilder::bindPortDownAux(PortView portEl,
                                          const VerilogVarsVec &verPortVars,
                                          bool isUniformArrayBind)
{
    auto bindedObj = portEl.getDirectBind().getAsArrayElementWithIndicies();
    auto bindedParentMods = bindedObj.obj.getParentModulesList(portEl.getParentModule());

    DEBUG_WITH_TYPE(DebugOptions::doPortBind,
        llvm::outs() << "bindPortDownAux BIND " << portEl << " to " << bindedObj.obj << "\n";
    );
    
    PortDirection virtualDirection;
    if (portEl.getDirection() == PortDirection::IN)
        virtualDirection = PortDirection::OUT;
    else
        virtualDirection = PortDirection::IN;

    VerilogVarsVec hostVars = verPortVars;
    VerilogVarsVec instanceVars;

    for (size_t i = 1; i < bindedParentMods.size(); i++) {
        bool last = i == (bindedParentMods.size() - 1);

        ModuleMIFView instModView = bindedParentMods[i];
        VerilogModule *instVerMod = elabDB->getVerilogModule(instModView);
        VerilogModule *hostVerMod = elabDB->getVerilogModule(
                                                bindedParentMods[i - 1]);
        VerilogModuleInstance *instance = hostVerMod->getInstance(instModView);

        // create virtual ports inside instance module
        for (const auto *verVar: verPortVars) {
            auto *portVar = instVerMod->createAuxilaryPort(virtualDirection,
                verVar->getName(), verVar->getBitwidth(), verVar->getArrayDims(), verVar->isSigned());

            instanceVars.push_back(portVar);
        }

        SCT_TOOL_ASSERT (instanceVars.size() == hostVars.size(), "");
        // bind virtual ports
        for (size_t i = 0; i < instanceVars.size(); i++) {
            instance->addBinding(instanceVars[i], {hostVars[i]});
            hostVerMod->addVarBindedInMod(hostVars[i]);
        }

        // in bottom module create assignments to virtual ports
        if (last) {
            IndexVec indexes;
            if (!isUniformArrayBind) {
                indexes = bindedObj.indices;
            }

            VerilogVarsVec bindedVerVars = instVerMod->getVerVariables(bindedObj.obj);
            SCT_TOOL_ASSERT (bindedVerVars.size() == instanceVars.size(), "");

            for (size_t i = 0; i < bindedVerVars.size(); i++) {

                if (portEl.getDirection() == PortDirection::IN) {
                    instVerMod->addAssignment({instanceVars[i]}, { bindedVerVars[i], indexes});
                }
                else {
                    instVerMod->addAssignment({bindedVerVars[i], indexes}, {instanceVars[i]});
                }
            }
        }

        // current instance is next host
        hostVars = instanceVars;
        instanceVars.clear();
    }
}

void ScElabModuleBuilder::bindPortCrossAux(PortView portEl,
                                           const VerilogVarsVec &verPortVars, 
                                           bool isUniformArrayBind) 
{
    // First bind up to common Parent, then bind down to bindedObj
    auto bindedObj = portEl.getDirectBind().getAsArrayElementWithIndicies();
    ModuleMIFView commonParentMod = portEl.nearestCommonParentModule(bindedObj.obj);
    
    DEBUG_WITH_TYPE(DebugOptions::doPortBind,
        llvm::outs() << "bindPortCrossAux BIND " << portEl << " to " << bindedObj.obj << "\n";
    );

    VerilogVarsVec hostVars;
    VerilogVarsVec instanceVars = verPortVars;
    // Keep signal name in module interface and do not create auxiliary variable
    bool keepSigVar = verPortVars.size() == 1;
        
    {
        // 1. Bind  UP
        auto bindUpParentMods = portEl.getParentModulesList(commonParentMod);
        SCT_TOOL_ASSERT (bindUpParentMods.size() > 1, "");
        SCT_TOOL_ASSERT (bindUpParentMods[0] == commonParentMod, "");

        for (size_t i = bindUpParentMods.size() - 1; i > 0; --i) {
            bool last = i == 1;

            hostVars.clear();

            ModuleMIFView instanceModObj = bindUpParentMods.at(i);

            VerilogModule *hostVerMod = elabDB->getVerilogModule(bindUpParentMods.at(i - 1));
            VerilogModuleInstance *instance = hostVerMod->getInstance(instanceModObj);

            // We need to create auxiliary ports in all host modules,
            // in a topmost module we create an auxiliary signal instead of port
            for (const auto *verVar : verPortVars) {
                if (!last) {
                    auto *portVar = hostVerMod->createAuxilaryPort(
                                        portEl.getDirection(),
                                        verVar->getName(), verVar->getBitwidth(),
                                        verVar->getArrayDims(), verVar->isSigned());
                    hostVars.push_back(portVar);
                    
                } else {
                    // Do not keep signal name if signals and ports have 
                    // different dimension, possible if bind to array element
                    keepSigVar = keepSigVar && (verVar->getArrayDims().size() == 
                                 bindedObj.indices.size());
                    
                    VerilogVar* sigVar;
                    if (keepSigVar) {
                        // Create only one variable in parent module 
                        // for multiple binds of the signal
                        auto i = boundSigObjs.find(bindedObj.obj);
                        if (i != boundSigObjs.end()) {
                            // Next binds of the signal, reuse the same variable 
                            sigVar = i->second;
                        } else {
                            // First bind of the signal
                            sigVar = hostVerMod->createAuxilarySignal(
                                        verVar->getName(), verVar->getBitwidth(), 
                                        verVar->getArrayDims(), verVar->isSigned());
                            boundSigObjs.emplace(bindedObj.obj, sigVar);
                        }
                    } else {
                        // Normal mode, port name used for module with the signal,
                        // multiple variables created in parent module
                        sigVar = hostVerMod->createAuxilarySignal(
                                    verVar->getName(), verVar->getBitwidth(), 
                                    verVar->getArrayDims(), verVar->isSigned());
                    }
                    hostVars.push_back(sigVar);
                }
            }

            DEBUG_WITH_TYPE(DebugOptions::doPortBind,
                llvm::outs() << portEl << "\n";

                llvm::outs() << "Host vars: \n";

                for (auto var : hostVars)
                    llvm::outs() << var->getName() << "\n";

                llvm::outs() << "Instance vars: \n";

                for (auto var : instanceVars)
                    llvm::outs() << var->getName() << "\n";

            );


            SCT_TOOL_ASSERT (hostVars.size() == instanceVars.size(), "");

            for (size_t i = 0; i < hostVars.size(); ++i) {
                instance->addBinding(instanceVars[i], { hostVars[i] });
                hostVerMod->addVarBindedInMod(hostVars[i]);
            }

            // on next iteration current host is an instance
            instanceVars = hostVars;
        }

    }
    
    // hostVars now holds auxiliary signals created in commonParentMod
    instanceVars.clear();
    // Bind signal to port flag 
    bool bindSigVar = true;
    // Do not bind a signal multiple time in keep signal name mode
    if (keepSigVar) {
        bindSigVar = boundSignals.insert(bindedObj.obj).second;
    }

    // Bind DOWN
    if (bindSigVar) {
        auto bindDownParentMods = bindedObj.obj.
                                  getParentModulesList(commonParentMod);
        
        PortDirection bottomDirection;
        if (portEl.getDirection() == PortDirection::IN)
            bottomDirection = PortDirection::OUT;
        else
            bottomDirection = PortDirection::IN;

        for (size_t i = 1; i < bindDownParentMods.size(); i++) {
            bool last = i == (bindDownParentMods.size() - 1);

            ModuleMIFView instModView = bindDownParentMods.at(i);
            VerilogModule *instVerMod = elabDB->getVerilogModule(instModView);
            VerilogModule *hostVerMod = elabDB->getVerilogModule(
                                        bindDownParentMods.at(i - 1));
            VerilogModuleInstance *instance = hostVerMod->getInstance(instModView);
            //cout << "bindPortCrossAux hostVerMod " << hostVerMod->getName() 
            //     << " instVerMod " << instVerMod->getName() << endl;

            // Create virtual ports for signals inside instance module 
            if (keepSigVar && last) {
                // In keep signal name mode module port with the name created
                VerilogVarsVec bindedVerVars = instVerMod->getVerVariables(
                                               bindedObj.obj);
                for (auto* verVar : bindedVerVars) {
                    auto *sigVar = instVerMod->createAuxilaryPortForSignal(
                                   bottomDirection, verVar);
                    instanceVars.push_back(sigVar);
                }
                
            } else {
                // In normal mode module port with bound port name and 
                // auxiliary variable in signal module created
                for (auto* verVar: verPortVars) {
                    auto portVar = instVerMod->createAuxilaryPort(bottomDirection,
                                    verVar->getName(), verVar->getBitwidth(), 
                                    verVar->getArrayDims(), verVar->isSigned());

                    instanceVars.push_back(portVar);
                }
            }

            SCT_TOOL_ASSERT (instanceVars.size() == hostVars.size(), "");

            // Bind virtual ports, skip duplicate bind for shared signal variable
            for (size_t i = 0; i < instanceVars.size(); i++) {
                instance->addBinding(instanceVars[i], {hostVars[i]});
                hostVerMod->addVarBindedInMod(hostVars[i]);
            }

            // in bottom module create assignments to virtual ports

            IndexVec indexes;
            if (!isUniformArrayBind) {
                indexes = bindedObj.indices;
            }

            // Add assignment of signal port and auxiliary variable in signal module
            if (!keepSigVar && last) {
                VerilogVarsVec bindedVerVars = instVerMod->getVerVariables(
                                               bindedObj.obj);
                SCT_TOOL_ASSERT (bindedVerVars.size() == instanceVars.size(), "");

                for (size_t i = 0; i < bindedVerVars.size(); i++) {

                    if (portEl.getDirection() == PortDirection::IN) {
                        instVerMod->addAssignment({instanceVars[i]}, 
                                                  {bindedVerVars[i], indexes});
                    } else {
                        instVerMod->addAssignment({bindedVerVars[i], indexes}, 
                                                  {instanceVars[i]});
                    }
                }
            }

            // current instance is next host
            hostVars = instanceVars;
            instanceVars.clear();
        }
    }

}

void ScElabModuleBuilder::bindPortExternalAux(PortView portEl,
                                              const VerilogVarsVec &verPortVars, 
                                              bool isUniformArrayBind) 
{
    auto topModView = elabDB->getTopModule();

    DEBUG_WITH_TYPE(DebugOptions::doPortBind,
        llvm::outs() << "bindPortExternalAux BIND " << portEl << "\n";
    );
    
    VerilogVarsVec hostVars;
    VerilogVarsVec instanceVars = verPortVars;

    if (!(topModView == portEl.getParentModule())) {
        // promote inner module port to top-level

        auto parentModsList = portEl.getParentModulesList(topModView);

        for (size_t i = parentModsList.size() - 1; i > 0; --i) {

            ModuleMIFView instanceModObj = parentModsList.at(i);

            VerilogModule *hostVerMod = elabDB->getVerilogModule(parentModsList.at(i - 1));
            VerilogModuleInstance *instance = hostVerMod->getInstance(instanceModObj);

            // create auxiliary port in host module
            for (const auto *verVar : verPortVars) {
                auto *portVar = hostVerMod->createAuxilaryPort(
                                portEl.getDirection(), verVar->getName(), 
                                verVar->getBitwidth(), verVar->getArrayDims(), 
                                verVar->isSigned());

                hostVars.push_back(portVar);
            }

            SCT_TOOL_ASSERT (hostVars.size() == instanceVars.size(), "");

            // bind
            for (size_t i = 0; i < hostVars.size(); ++i) {
                instance->addBinding(instanceVars[i], { hostVars[i]});
                hostVerMod->addVarBindedInMod(hostVars[i]);
            }

            // on next iteration current host is an instance
            instanceVars = hostVars;
            hostVars.clear();
        }
    }
}

bool ScElabModuleBuilder::isFlattenArrayBind (
    const ArrayElemVec &allArrayPorts, const ArrayElemVec &allArrayBinds) const
{
    bool flattenArrayBind = false;

    if (allArrayPorts.size() > 1) {
        // Port bound outside of module hierarchy (promoted to top level)
        
        // No flatten for external port required
        bool isExternal = true;
        for (size_t i = 0; i < allArrayPorts.size(); ++i) {
            auto portEl = *allArrayPorts[i].obj.primitive()->port();

            if (!portEl.getDirectBind().hasNoParent())
                isExternal = false;
        }

        if (!isExternal) {
            if (allArrayPorts.size() != allArrayBinds.size()) {
                // Different array dimension numbers
                flattenArrayBind = true;
                
            } else {
                // Check port is bound to object with the sam eindex
                for (size_t i = 0; i < allArrayPorts.size(); ++i) {
                    auto portEl = *allArrayPorts[i].obj.primitive()->port();
                    if (portEl.getDirectBind() != allArrayBinds[i].obj)
                        flattenArrayBind = true;
                    if (allArrayPorts[i].indices.size() != allArrayBinds[i].indices.size()) {
                        flattenArrayBind = true;
                    }
                }
            }
        }
    } else if (allArrayPorts.size() == 1) {
        // Array with one element or non-array 
        
        // Binds are empty for external signals
        if (allArrayBinds.empty())
            return false;
        
        if (allArrayPorts[0].indices.size() > 0) {
            // Different array dimension numbers
            if (allArrayPorts.size() != allArrayBinds.size()) {
                flattenArrayBind = true;
            }
            // Check index size to flatten bound array to non-array 
            if (allArrayPorts[0].indices.size() != allArrayBinds[0].indices.size())
                flattenArrayBind = true;
        }
    }

    return flattenArrayBind;
}

ScElabModuleBuilder::BindDirection ScElabModuleBuilder::getBindDirection (
    PortView portView) const
{
    auto bindedObj = portView.getDirectBind();

    if (bindedObj.hasNoParent())
        return BindDirection::BIND_EXTERNAL;

    auto thisParentMod = portView.getParentModule();
    auto bindedParentMod = bindedObj.getParentModule();
    // Find common parent
    auto commonParentMod = portView.nearestCommonParentModule(bindedObj);

    if (bindedParentMod == thisParentMod)
        return BindDirection::BIND_SAME;
    else if (commonParentMod == thisParentMod)
        return BindDirection::BIND_DOWN;
    else if (commonParentMod == bindedParentMod)
        return BindDirection::BIND_UP;
    else
        return BindDirection::BIND_CROSS;
}

/*void ScElabModuleBuilder::bindPortSame(VerilogModule &verMod,
                                       PortView port,
                                       bool arrayBind)
{
    const auto &verVars = verMod.getVerVariables(port);
    auto bindedObj = port.getDirectBind();

    llvm::SmallVector<VerilogVar *, 1> bindedVerVars;
    IndexVec bindedIndices;

    auto arrayEl = bindedObj.getAsArrayElementWithIndicies();
    bindedObj = arrayEl.obj;
    bindedIndices = arrayEl.indices;

    bindedVerVars = verMod.getVerVariables(bindedObj);

    SCT_TOOL_ASSERT (bindedVerVars.size() == verVars.size(), "");

    for (size_t i = 0; i < verVars.size(); ++i) {

        verMod.convertToSignal(verVars[i]);

        if (port.isInput()) {
            verMod.addAssignment({verVars[i], {}},
                                 {bindedVerVars[i], bindedIndices});
        } else 
        if (port.isOutput()) {
            verMod.addAssignment({bindedVerVars[i], bindedIndices},
                                 {verVars[i], {}});
        } else
            SCT_TOOL_ASSERT (false, "");
    }
}

void ScElabModuleBuilder::bindPortDown(VerilogModule &verMod,
                                       PortView port,
                                       bool arrayBind)
{
    auto bindedObj = port.getDirectBind();
    auto bindedParentMods = bindedObj.getParentModulesList(verMod.getModObj());
    const auto &verVars = verMod.getVerVariables(port);

    SCT_TOOL_ASSERT (bindedParentMods.size() > 1, "");
    SCT_TOOL_ASSERT (bindedParentMods[0] == verMod.getModObj(), "");

    const auto &bindedVars = bindedObj.getVerilogVars();

    PortDirection virtualDirection;
    if (port.getDirection() == PortDirection::IN)
        virtualDirection = PortDirection::OUT;
    else
        virtualDirection = PortDirection::IN;

    for (size_t i = 1; i < bindedParentMods.size(); i++) {
        bool first = i == 1;
        bool last = i == (bindedParentMods.size() - 1);

        ModuleMIFView instModView = bindedParentMods[i];
        VerilogModule *instVerMod = elabDB->getVerilogModule(instModView);
        VerilogModule
            *hostVerMod = elabDB->getVerilogModule(bindedParentMods[i - 1]);
        VerilogModuleInstance *instance = hostVerMod->getInstance(instModView);

        llvm::SmallVector<VerilogVar *, 1>
            hostVars = hostVerMod->getVerVariables(port);

        if (first) {
            for (const auto *verVar: verVars)
                hostVerMod->convertToSignal(verVar);
        }

        // create virtual ports
        for (const auto verVar: bindedVars) {

            auto *portVerVar = instVerMod->createChannelVariable(port,
                                                                 verVar.var->getName(),
                                                                 verVar.var->getBitwidth(),
                                                                 verVar.var->getArrayDims(),
                                                                 verVar.var->isSigned());
            instVerMod->addVerilogPort(portVerVar, virtualDirection);
        }

        VerilogVarsVec            instVars = instVerMod->getVerVariables(port);
        // bind virtual ports
        SCT_TOOL_ASSERT (instVars.size() == hostVars.size(), "");
        for (size_t i = 0; i < instVars.size(); i++) {
            instance->addBinding(instVars[i], {hostVars[i]});
            hostVerMod->addVarBindedInMod(hostVars[i]);
        }

        if (last) {
            VerilogVarsVec bindedVerVars = instVerMod->getVerVariables(bindedObj);

            for (size_t i = 0; i < verVars.size(); i++) {

                if (port.getDirection() == PortDirection::IN) {
                    instVerMod->addAssignment(instVars[i], bindedVerVars[i]);
                }
                else {
                    instVerMod->addAssignment(bindedVerVars[i], instVars[i]);
                }
            }
        }
    }
}

void ScElabModuleBuilder::bindPortUp(VerilogModule &verMod,
                                     PortView port,
                                     bool arrayBind)
{
    const auto &verVars = verMod.getVerVariables(port);
    auto bindedObj = port.getDirectBind();


    auto topParentMod = bindedObj.getParentModule();
    auto parentModsList = port.getParentModulesList(topParentMod);

    SCT_TOOL_ASSERT (parentModsList.size() > 1, "");
    SCT_TOOL_ASSERT (parentModsList.back() == verMod.getModObj(), "");

    for (size_t i = parentModsList.size() - 1; i > 0; --i) {
        bool last = i == 1;
        bool first = i == (parentModsList.size() - 1);

        ModuleMIFView instanceModObj = parentModsList.at(i);
        VerilogModule
            *instanceVerMod = elabDB->getVerilogModule(instanceModObj);
        VerilogModule
            *hostVerMod = elabDB->getVerilogModule(parentModsList.at(i - 1));
        VerilogModuleInstance
            *instance = hostVerMod->getInstance(instanceModObj);

        // create verilog ports
        if (first) {
            for (const auto *verVar: verVars) {
                instanceVerMod->convertToPort(verVar, port.getDirection());
            }
        }

        if (!last) {
            for (const auto *verVar: verVars) {
                auto *portVar = hostVerMod->createChannelVariable(port,
                                                                  verVar->getName(),
                                                                  verVar->getBitwidth(),
                                                                  verVar->getArrayDims(),
                                                                  verVar->isSigned());

                hostVerMod->addVerilogPort(portVar, port.getDirection());
            }
        }

        // create bindings
        if (last) {
            // bind to bindedObj signals
            const auto &bindedVerVars = hostVerMod->getVerVariables(bindedObj);

            const auto &instanceVerVars = instanceVerMod->getVerVariables(port);

            SCT_TOOL_ASSERT (bindedVerVars.size() == instanceVerVars.size(), "");

            for (size_t i = 0; i < bindedVerVars.size(); ++i) {
                instance->addBinding(instanceVerVars[i], {bindedVerVars[i]});
                hostVerMod->addVarBindedInMod(bindedVerVars[i]);
            }

        } else {
            // bind to "virtual" ports
            const auto &bindedVerVars = hostVerMod->getVerVariables(port);

            const auto &instanceVerVars = instanceVerMod->getVerVariables(port);

            SCT_TOOL_ASSERT (bindedVerVars.size() == instanceVerVars.size(), "");

            for (size_t i = 0; i < bindedVerVars.size(); ++i) {
                instance->addBinding(instanceVerVars[i], {bindedVerVars[i]});
                hostVerMod->addVarBindedInMod(bindedVerVars[i]);
            }
        }
    }
}

void ScElabModuleBuilder::bindPortCross(VerilogModule &verMod,
                                        PortView port,
                                        bool arrayBind)
{
    // First bind up to common Parent, then bind down to bindedObj

    const auto &verVars = verMod.getVerVariables(port);
    ObjectView bindedObj = port.getDirectBind();
    ModuleMIFView commonParentMod = port.nearestCommonParentModule(bindedObj);

    const auto &bindedVars = bindedObj.getVerilogVars();

    // Bind  UP
    std::deque<ModuleMIFView>
        bindUpParentMods = port.getParentModulesList(commonParentMod);

    SCT_TOOL_ASSERT (bindUpParentMods.size() > 1, "");
    SCT_TOOL_ASSERT (bindUpParentMods[0] == commonParentMod, "");

    for (size_t i = bindUpParentMods.size() - 1; i > 0; --i) {
        bool last = i == 1;
        bool first = i == bindUpParentMods.size() - 1;

        ModuleMIFView instanceModObj = bindUpParentMods.at(i);
        VerilogModule
            *instanceVerMod = elabDB->getVerilogModule(instanceModObj);
        VerilogModule
            *hostVerMod = elabDB->getVerilogModule(bindUpParentMods.at(i - 1));
        VerilogModuleInstance
            *instance = hostVerMod->getInstance(instanceModObj);

        // create verilog ports
        if (first) {
            for (const auto *verVar: verVars) {
                instanceVerMod->convertToPort(verVar, port.getDirection());
            }
        }

        for (const auto *verVar: verVars) {
            auto *virtualVar = hostVerMod->createChannelVariable(port,
                                                                 verVar->getName(),
                                                                 verVar->getBitwidth(),
                                                                 verVar->getArrayDims(),
                                                                 verVar->isSigned());

            if (last) {
                // create virtual signals
                hostVerMod->addSignal(virtualVar);
            }
            else
                hostVerMod->addVerilogPort(virtualVar, port.getDirection());
        }

        // create bindings
        const auto &hostVerVars = hostVerMod->getVerVariables(port);
        const auto &instanceVerVars = instanceVerMod->getVerVariables(port);
        SCT_TOOL_ASSERT (hostVerVars.size() == instanceVerVars.size(), "");

        for (size_t i = 0; i < hostVerVars.size(); ++i) {
            instance->addBinding(instanceVerVars[i], {hostVerVars[i]});
            hostVerMod->addVarBindedInMod(hostVerVars[i]);
        }
    }

    // Bind  DOWN

    std::deque<ModuleMIFView>
        bindDownParentMods = bindedObj.getParentModulesList(commonParentMod);

    PortDirection bottomDirection;
    if (port.getDirection() == PortDirection::IN)
        bottomDirection = PortDirection::OUT;
    else
        bottomDirection = PortDirection::IN;

    for (size_t i = 1; i < bindDownParentMods.size(); i++) {
        bool last = i == (bindDownParentMods.size() - 1);

        ModuleMIFView instModView = bindDownParentMods.at(i);
        VerilogModule *instVerMod = elabDB->getVerilogModule(instModView);
        VerilogModule *hostVerMod =
            elabDB->getVerilogModule(bindDownParentMods.at(i - 1));
        VerilogModuleInstance *instance = hostVerMod->getInstance(instModView);

        for (const auto verVar: bindedVars) {
            auto *virtualVar = instVerMod->createChannelVariable( port,
                      verVar.var->getName(),
                      verVar.var->getBitwidth(),
                      verVar.var->getArrayDims(),
                      verVar.var->isSigned() );

            instVerMod->addVerilogPort(virtualVar, bottomDirection);
        }

        // create bindings
        auto hostVerVars = hostVerMod->getVerVariables(port);
        auto instVerVars = instVerMod->getVerVariables(port);

        if (hostVerVars.size() != instVerVars.size()) {
            llvm::outs() << "Bug in binding \n";
            llvm::outs() << port << "\n";
            llvm::outs() << port.getSCName() << "\n";

            llvm::outs() << "BINDED TO:" << bindedObj << "\n";
            SCT_TOOL_ASSERT (false, "");
        }

        for (size_t i = 0; i < hostVerVars.size(); ++i) {
            instance->addBinding(instVerVars[i], {hostVerVars[i]});
            hostVerMod->addVarBindedInMod(hostVerVars[i]);
        }

        if (last) {
            llvm::SmallVector<VerilogVar *, 1>
                bindedVerVars = instVerMod->getVerVariables(bindedObj);

            SCT_TOOL_ASSERT (bindedVerVars.size() == instVerVars.size(), "");

            for (size_t i = 0; i < instVerVars.size(); i++) {

                if (bottomDirection == PortDirection::IN) {
                    instVerMod->addAssignment(bindedVerVars[i], instVerVars[i]);
                }
                else {
                    instVerMod->addAssignment(instVerVars[i], bindedVerVars[i]);
                }
            }
        }
    }
}

void ScElabModuleBuilder::materializePort(VerilogModule &verMod, PortView port)
{
    auto topModView = elabDB->getTopModule();
    const auto &verVars = verMod.getVerVariables(port);

    std::string namePrefix;

    if (topModView == verMod.getModObj()) {
        // materialize top-level module port
        for (const auto *verVar: verVars) {
            verMod.convertToPort(verVar, port.getDirection());
        }

    }
    else {
        // promote inner module port to top-level
        auto parentModsList = port.getParentModulesList(topModView);

        SCT_TOOL_ASSERT (parentModsList.size() > 1, "");
        SCT_TOOL_ASSERT (parentModsList.back() == verMod.getModObj(), "");

        for (size_t i = parentModsList.size() - 1; i > 0; --i) {
            bool first = i == (parentModsList.size() - 1);

            ModuleMIFView instanceModObj = parentModsList.at(i);
            VerilogModule
                *instanceVerMod = elabDB->getVerilogModule(instanceModObj);
            VerilogModule *hostVerMod =
                elabDB->getVerilogModule(parentModsList.at(i - 1));
            VerilogModuleInstance
                *instance = hostVerMod->getInstance(instanceModObj);

            //namePrefix = instance->getName() + "_" + namePrefix;
            namePrefix = instance->getName() + namePrefix;

            // create verilog ports
            if (first) {
                for (const auto *verVar: verVars) {
                    instanceVerMod->convertToPort(verVar, port.getDirection());
                }
            }

            // create virtual ports in host module

            for (const auto *verVar: verVars) {
                auto *portVar = hostVerMod->createChannelVariable(
                                            port, namePrefix + verVar->getName(),
                                            verVar->getBitwidth(),
                                            verVar->getArrayDims(),
                                            verVar->isSigned() );

                hostVerMod->addVerilogPort(portVar, port.getDirection());
            }

            // create bindings
            // bind to "virtual" ports
            const auto &bindedVerVars = hostVerMod->getVerVariables(port);

            const auto &instanceVerVars = instanceVerMod->getVerVariables(port);

            SCT_TOOL_ASSERT (bindedVerVars.size() == instanceVerVars.size(), "");

            for (size_t i = 0; i < bindedVerVars.size(); ++i) {
                instance->addBinding(instanceVerVars[i], {bindedVerVars[i]});
                hostVerMod->addVarBindedInMod(bindedVerVars[i]);
            }
        }
    }
}*/

// Run for each module in design
void ScElabModuleBuilder::createProcessBodies(VerilogModule &verMod)
{
    //using std::cout; using std::endl;
    //cout << "createProcessBodies verMod " << verMod.getName() << endl;
    
    // Avoid black boxed module process analysis
    if (verMod.isIntrinsic()) return;
    
    // ELAB_ONLY flag true
    if (noProcessAnalysis) {
        for (auto &proc : verMod.getProcesses()) {
            verMod.addProcessBody(proc,
                                  VerilogProcCode(
                                      "//  Process analysis disabled\n"));
        }
    } else {
//        cout << "------------- channelVarMap " << verMod.getName() << endl;
//        for (auto& e : verMod.channelVarMap) {
//            cout << "   " << e.first.getID() << " : " 
//                 << ((e.second.size() > 0) ? e.second[0]->getName() : "---") << endl;
//        }
        
        // Create @state common for this module, could be modified for 
        // local static constant and global variable outside of the module
        ProcBuilder procBuilder(verMod.getModObj(), *elabDB);
        procBuilder.prepareState(verMod.getModObj());

        // Generate code for SVA properties in module body
        if (!noSvaGenerate) {
            std::string svaCode = procBuilder.generateSvaProperties(verMod);
            verMod.addSvaPropertyCode(svaCode);
        }
        
        // Generate process bodies 
        for (ProcessView& proc : verMod.getProcesses()) {    
            auto procBody = procBuilder.generateVerilogProcess(proc);
            verMod.addProcessBody(proc, procBody);
            // Set unique name for process
            proc.procName = verMod.getProcName(proc);
        }
    }
}

/// Get string value from const std::string and const char*
llvm::Optional<std::string> ScElabModuleBuilder::getVerilogIntrinsic(
                                    const ModuleMIFView& modView)
{
    for (const ObjectView& field : modView.getFields()) {
        
        if (field.getFieldName() && 
            !field.getFieldName()->compare("__SC_TOOL_VERILOG_MOD__")) {
            
            if (auto strRec = field.string()) {
                return strRec;
            }
            
            std::string errMsg = 
                        "Incorrect __SC_TOOL_VERILOG_MOD__ declaration in "+ 
                        modView.getName();
            SCT_INTERNAL_ERROR_NOLOC(errMsg);
        }
    }

    return llvm::None;
}

// Get string value from const std::string and const char*
llvm::Optional<std::string> ScElabModuleBuilder::getVerilogMemName(
                                    const ModuleMIFView& modView)
{
    for (const ObjectView& field : modView.getFields()) {
        
        if (field.getFieldName() && 
            !field.getFieldName()->compare("__SC_TOOL_MEMORY_NAME__")) 
        {
            auto strRec = field.string();
            SCT_TOOL_ASSERT (strRec, "Unsupported std::string implementation");
            return strRec;
        }
    }

    return llvm::None;
}


// Get assert properties from @SCT_ASSERT macro in module scope
std::vector<const clang::FieldDecl*> 
ScElabModuleBuilder::getSvaProperties(const RecordView& recView)
{
    std::vector<const clang::FieldDecl*> props;
    
    for (const ObjectView& field : recView.getFields()) {
        if (field.getFieldName() && 
            field.getFieldName()->find("sctTmpVar") != std::string::npos) 
        {
            props.push_back(field.getFieldDecl());
            //std::cout << "SCT_ASSERT : " << *field.getFieldName() << std::endl;
            //field.getFieldDecl()->dumpColor();
        }
    }
    
    // Traverse base classes recursively
    for (RecordView baseView : recView.getBases()) {
        auto baseProps = getSvaProperties(baseView);
        props.insert(props.end(), baseProps.begin(), baseProps.end()); 
    }

    return props;
}

/*llvm::Optional<std::string> ScElabModuleBuilder::getSvaProperty(
                                    const ModuleMIFView& modView)
{
    const std::string& typeName = modView.getType().getAsString();
    //std::cout << "getSvaProperty typeName " << typeName << std::endl;
    
    if (typeName.find("sc_core::sct_property_method") != std::string::npos) {
        // Get property string from base class @propStr
        for (const ObjectView& field : modView.getFields()) {
            if (field.getFieldName() && 
                !field.getFieldName()->compare("propStr")) 
            {
                if (auto strRec = field.string()) {
                    return strRec.getValue();
                }
                SCT_TOOL_ASSERT(false, "Unsupported std::string implementation");
            }
        }
        // No required field found
        SCT_INTERNAL_ERROR_NOLOC("Incorrect sct_property_method");
    }

    return llvm::None;
}*/

/// Get string value from const char[]
// llvm::Optional<std::string> ScElabModuleBuilder::getVerilogMemName(
//                                    const ModuleMIFView& modView)
//{
//    using namespace std;
//    
//    for (const ObjectView& field : modView.getFields()) {
//        
//        if (!field.getFieldName()->compare("__SC_TOOL_MEMORY_NAME__")) {
//            
//            if (auto arrayOpt = field.array()) {
//                ArrayView array = arrayOpt.getValue();
//                char* verName = new char [array.size()];
//                
//                for (size_t i = 0; i < array.size(); i++) {
//                    verName[i] = *(array.at(i).primitive()->value()->int64Val());
//                }
//                
//                std::string verNameS = verName;
//                delete [] (verName);
//                return llvm::Optional<std::string>(verNameS);
//            }
//        }
//    }
//
//    return llvm::None;
//}

/// Getting value from static constexpr char
//llvm::Optional<std::string> ScElabModuleBuilder::getVerilogIntrinsic(
//                                    clang::CXXRecordDecl *recordDecl)
//{
//    for (clang::Decl *decl: recordDecl->decls()) {
//        if (clang::VarDecl *varDecl = llvm::dyn_cast<clang::VarDecl>(decl)) {
//            if (varDecl->isStaticDataMember()) {
//
//                if (varDecl->getName() == "__SC_TOOL_VERILOG_MOD__") {
//                    assert(varDecl->hasInit());
//                    assert(llvm::isa<clang::StringLiteral>(varDecl->getInit()));
//                    auto *verilogCode =
//                        dyn_cast<clang::StringLiteral>(varDecl->getInit());
//                    return verilogCode->getString().str();
//                }
//
//            }
//        }
//    }
//
//    return llvm::None;
//}



// -----------------------------------------------------------------------------
// -----------------------------------------------------------------------------

} // end anonymous  namespace



namespace sc_elab
{

void buildVerilogModules(ElabDatabase *elabDB, 
                         const std::unordered_map<size_t, size_t>& movedObjs)
{
    ScElabModuleBuilder builder(elabDB, movedObjs);
    builder.run();
}

}
