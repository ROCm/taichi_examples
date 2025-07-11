#!/bin/bash

cd /app/examples
python3 stable_fluid_graph.py

cd /app/examples/algorithms
python3 laplace.py
python3 poisson_disk_sampling.py

