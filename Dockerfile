From ubuntu:20.04
ADD sources.list /etc/apt
ENV ICSC_HOME=/usr/local
ENV GCC_INSTALL_PREFIX=/usr

RUN apt-get -y update 
RUN apt-get -y install git wget cmake autoconf automake binutils flex bison gcc-12 g++-12 build-essential curl  libgmp-dev \
gdb python3 python3-pip 

RUN pip config set global.index-url https://pypi.tuna.tsinghua.edu.cn/simple
# RUN python3 -m pip install --upgrade pip && python3 -m pip install --user tf_nightly==2.3.0.dev20200528
RUN apt-get clean
RUN rm -rf /var/lib/apt/lists/*

RUN cd /usr/local/src  \
&& wget -N https://github.com/protocolbuffers/protobuf/archive/v3.13.0.tar.gz --no-check-certificate  \
&& tar -zxf v3.13.0.tar.gz -C /usr/local/src --skip-old-files \
&& cd /usr/local/src/protobuf-3.13.0 \
&&    mkdir build -p && cd build \
&&    cmake ../cmake/ -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=$ICSC_HOME -DBUILD_SHARED_LIBS=ON -Dprotobuf_BUILD_TESTS=OFF -DCMAKE_CXX_STANDARD=17 \
&&    make -j6 \
&&    make install

RUN cd /usr/local/src \
&& wget -N https://github.com/llvm/llvm-project/releases/download/llvmorg-12.0.1/clang-12.0.1.src.tar.xz --no-check-certificate  \
&& wget -N https://github.com/llvm/llvm-project/releases/download/llvmorg-12.0.1/llvm-12.0.1.src.tar.xz --no-check-certificate \
&& tar -xf clang-12.0.1.src.tar.xz --skip-old-files \
&& tar -xf llvm-12.0.1.src.tar.xz --skip-old-files \
&& ln -sf /usr/local/src/clang-12.0.1.src llvm-12.0.1.src/tools/clang

RUN cd /usr/local/src/llvm-12.0.1.src \
&& mkdir build -p  \
&& cd build \
&& cmake ../ -DLLVM_ENABLE_ASSERTIONS=ON -DLLVM_TARGETS_TO_BUILD="X86" -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=$ICSC_HOME -DGCC_INSTALL_PREFIX=$GCC_INSTALL_PREFIX -DCMAKE_CXX_STANDARD=17 \
&& make -j6 \
&& make install


RUN cd /usr/local/src \
&& git clone --recursive  https://github.com/intel/systemc-compiler \
&& mkdir -p systemc-compiler/build \
&& cd systemc-compiler/build  \
&&  cmake ../ -DLLVM_ENABLE_ASSERTIONS=ON -DLLVM_TARGETS_TO_BUILD="X86" -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=$ICSC_HOME -DGCC_INSTALL_PREFIX=$GCC_INSTALL_PREFIX -DCMAKE_CXX_STANDARD=17 \
&& make -j6 \
&& make install

RUN cd /usr/local/src \
&& wget -N https://ftp.gnu.org/gnu/gdb/gdb-11.2.tar.gz --no-check-certificate \
&& tar -xf gdb-11.2.tar.gz \
&& cd gdb-11.2 \
&&  ./configure --prefix="$ICSC_HOME" --with-python="$(which python3)" \
&& make -j6 \
&& make install

## RUN cd /usr/local/src \
## && wget -N --no-check-certificate https://github.com/accellera-official/systemc/archive/refs/tags/2.3.3.tar.gz 
## RUN tar -zxf 2.3.3.tar.gz \
## && mkdir -p systemc-2.3.3/_build \
## && cd systemc-2.3.3/_build \
## && CXXFLAGS="-std=c++17" ../configure --prefix=$ICSC_HOME \
## && make -j6 \
## && make install

RUN rm -fr /usr/local/bin/*.xz /usr/local/src/*.gz  
