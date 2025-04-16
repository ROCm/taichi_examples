#!/bin/bash

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
python3 benchmark.py

