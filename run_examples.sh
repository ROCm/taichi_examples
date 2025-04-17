#!/bin/bash

pip3 install --pre torch torchvision torchaudio --index-url https://download.pytorch.org/whl/nightly/rocm6.3/

cd /app/taichi
python3 setup.py develop

cd /app/examples
python3 lcs.py
python3 count_primes.py  
python3 fractal.py  
python3 lcs.py  
python3 physical_simulation.py

cd /app/examples/demo_taichi
python3 demo_taichi.py

cd /app/examples/tile
python3 demo_taichi.py

cd /app/examples/rwkv
python3 benchmark.py kernel_v3
python3 benchmark.py kernel_v2
python3 benchmark.py kernel_v1
python3 benchmark.py kernel_v0

