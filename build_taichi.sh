#!/bin/bash

pip3 install --pre torch torchvision torchaudio --index-url https://download.pytorch.org/whl/nightly/rocm6.3/

cd /app/taichi
python3 setup.py develop
cd /app

