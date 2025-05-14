# Taichi Examples on AMD GPUs


This repo contains select Taichi examples from the [Taichi documentation](https://docs.taichi-lang.org/) under "Get Started" and the [Taichi Github](https://github.com/taichi-dev/taichi/tree/master/python/taichi/examples). 
These examples are configured to execute on AMD GPUs (MI2xx and earlier) in the docker image built with the Dockerfile that is provided. 
There are three categories of examples found in this repo: small examples, Taichi demo examples, and Taichi benchmark examples.

Use the instructions below to build the docker image and run the examples.

**Build Docker image:**
```
docker build -t taichi_examples:latest .
```

**Run Docker container:**
```
docker run -it --privileged --network=host --device=/dev/kfd --device=/dev/dri --group-add video --cap-add=SYS_PTRACE --security-opt seccomp=unconfined --ipc=host --name taichi_examples taichi_examples:latest
```

**In Docker container, build taichi application:**
```
cd /app
./build_taichi.sh
```

**Run Taichi small examples:**
```
./run_small_examples.sh
```

**Run Taichi demo examples:**
```
./run_demos.sh
```

**Run Taichi benchmark examples:**
```
./run_algorithm_graph_examples.sh
```
