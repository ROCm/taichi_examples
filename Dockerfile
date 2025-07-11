FROM rocm/dev-ubuntu-22.04:6.3.2 

ARG LLVM_VERSION=15
ARG GPU_TARGETS=gfx90a

ENV DEBIAN_FRONTEND=noninteractive
ENV TAICHI_SRC=/app/taichi
ENV LLVM_DIR=/usr/lib/llvm-${LLVM_VERSION}
ENV PATH=${LLVM_DIR}/bin:$PATH
ENV TAICHI_CMAKE_ARGS="-DTI_WITH_VULKAN=OFF -DTI_WITH_OPENGL=OFF -DTI_BUILD_TESTS=ON -DTI_BUILD_EXAMPLES=OFF -DCMAKE_PREFIX_PATH=${LLVM_DIR}/lib/cmake -DCMAKE_CXX_COMPILER=${LLVM_DIR}/bin/clang++ -DTI_WITH_AMDGPU=ON -DTI_WITH_CUDA=OFF -DTI_AMDGPU_ARCHS=${GPU_TARGETS}"

RUN apt-get update && apt-get install -y --no-install-recommends \
    git wget \
    freeglut3-dev libglfw3-dev libglm-dev libglu1-mesa-dev \
    libjpeg-dev liblz4-dev libpng-dev libssl-dev \
    libwayland-dev libx11-xcb-dev libxcb-dri3-dev libxcb-ewmh-dev \
    libxcb-keysyms1-dev libxcb-randr0-dev libxcursor-dev libxi-dev \
    libxinerama-dev libxrandr-dev libzstd-dev \
    python3-pip cmake pybind11-dev ca-certificates \
    llvm-${LLVM_VERSION} clang-${LLVM_VERSION} lld-${LLVM_VERSION} \
 && apt-get clean && rm -rf /var/lib/apt/lists/*


WORKDIR /app

RUN git clone --recursive -b amd-integration https://github.com/ROCm/taichi.git \
    && cd taichi \
    && ./build.py \
    && python3 -m pip install /app/taichi/dist/taichi*.whl pillow \
    && pip3 install --no-cache-dir torch --index-url https://download.pytorch.org/whl/nightly/rocm6.3/

COPY run_demos.sh .
COPY run_algorithm_graph_examples.sh .
COPY examples/ examples/

