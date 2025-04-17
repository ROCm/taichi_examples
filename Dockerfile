FROM rocm/dev-ubuntu-22.04:6.3.2 

RUN sudo apt-get update && sudo apt install -y \
     git \
     vim \
     wget \
    freeglut3-dev \
    libglfw3-dev \
    libglm-dev \
    libglu1-mesa-dev \
    libjpeg-dev \
    liblz4-dev \
    libpng-dev \
    libssl-dev \
    libwayland-dev \
    libx11-xcb-dev \
    libxcb-dri3-dev \
    libxcb-ewmh-dev \
    libxcb-keysyms1-dev \
    libxcb-randr0-dev \
    libxcursor-dev \
    libxi-dev \
    libxinerama-dev \
    libxrandr-dev \
    libzstd-dev


RUN cd /tmp && wget https://github.com/Kitware/CMake/releases/download/v3.31.6/cmake-3.31.6-linux-x86_64.sh \
    && chmod +x cmake-3.31.6-linux-x86_64.sh \
    &&  mkdir /opt/cmake-3.31.6 \
    && ./cmake-3.31.6-linux-x86_64.sh --prefix=/opt/cmake-3.31.6 --skip-license \
    && rm cmake-3.31.6-linux-x86_64.sh

ENV PATH=$PATH:/opt/cmake-3.31.6/bin

RUN mkdir llvm-15.0.0 \
    && git clone https://github.com/llvm/llvm-project.git \
    && cd llvm-project \
    && git checkout tags/llvmorg-15.0.0 \
    && cmake -S llvm -B build_15.0.0 -G "Unix Makefiles" -DLLVM_ENABLE_PROJECTS="clang;lld" -DLLVM_ENABLE_RTTI:BOOL=ON -DBUILD_SHARED_LIBS:BOOL=OFF -DCMAKE_BUILD_TYPE=Release -DLLVM_TARGETS_TO_BUILD="X86;AMDGPU" -DLLVM_ENABLE_ASSERTIONS=ON -DLLVM_ENABLE_TERMINFO=OFF -DLLVM_INCLUDE_BENCHMARKS=OFF -DCMAKE_INSTALL_PREFIX=/opt/llvm-15.0.0 \
    && cd build_15.0.0 \
    && make -j `nproc` \
    && make install \
    && cd /tmp && rm -rf llvm-project


WORKDIR /app

ENV PATH=$PATH:/opt/llvm-15.0.0/bin
ENV  TAICHI_CMAKE_ARGS="-DTI_WITH_VULKAN=OFF -DTI_WITH_OPENGL=OFF -DTI_BUILD_TESTS=ON -DTI_BUILD_EXAMPLES=OFF -DCMAKE_PREFIX_PATH=/opt/llvm-15.0.0/lib/cmake -DCMAKE_CXX_COMPILER=/opt/llvm-15.0.0/bin/clang++ -DTI_WITH_AMDGPU=ON -DTI_WITH_CUDA:BOOL=OFF"

RUN git clone --recursive https://github.com/taichi-dev/taichi 

COPY build_taichi.sh .
COPY run_small_examples.sh .
COPY run_demos.sh .
COPY run_benchmarks.sh .
COPY run_docker_cmd.sh .
COPY examples/ examples/
COPY examples/tile/imgs/orig.png examples/tile/imgs/orig.png

CMD ["./run_docker_cmd.sh"]
