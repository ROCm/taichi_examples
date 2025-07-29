#!/bin/bash

cd examples
python3 stable_fluid_graph.py

cd algorithms
python3 laplace.py
python3 poisson_disk_sampling.py

