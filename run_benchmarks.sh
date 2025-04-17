#!/bin/bash

cd /app/examples/rwkv
python3 benchmark.py kernel_v3
python3 benchmark.py kernel_v2
python3 benchmark.py kernel_v1
python3 benchmark.py kernel_v0
cd /app

