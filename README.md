# Taichi Examples on AMD GPUs


This repo contains select Taichi examples from the [Taichi documentation](https://docs.taichi-lang.org/) under "Get Started" and the [Taichi Github](https://github.com/taichi-dev/taichi/tree/master/python/taichi/examples). 
These examples are configured to execute on AMD GPUs (MI2xx and earlier) in the docker image built with the Dockerfile that is provided. 
There are three categories of examples found in this repo: small examples, Taichi demo examples, and Taichi benchmark examples.

Follow the instrcutions in ROCm Taichi Installation guide to build or pull a docker image and run the examples.

**In Docker container, Run Taichi demo examples:**
```
./run_demos.sh
```

**Run Taichi benchmark examples:**
```
./run_algorithm_graph_examples.sh
```
