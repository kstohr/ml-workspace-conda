# ML - Workspace

## Overview

This is a machine learning workspace configured to deploy on GCP AI Notebooks as a custom container. It includes a number of additional packages not included in the standard images for machine learning including visualization packages (seaborn, plotly), ml packages (tslearn), packages needed to access cloud storage (boto3, google-cloud-storage, etc.) and utility packages (pytest).

A full list of the additional packages is listed in the [Dockerfile](./Dockerfile).
To add or remove custom packages, simply update the Dockerfile.

In addition, by updating the base image, you can configure the container to run with any of the GCP [Deep Learning Containers](https://cloud.google.com/ai-platform/deep-learning-containers/docs/choosing-container#choose_a_container_image_type)

Note: This repo contains tutorials and a .git file. When you spin up an AI Notebook, these files do not initially appear. If you fork this repo, you will need to authenticate with your remote git repo first. Once you authenticate, the files will appear on AI Notebook. Yeah, weird.

## Installation:

### Installing Locally

#### 1. Installing from Docker image.

This workspace is based on the following pre-built docker image: [Deep Learning Containers](https://cloud.google.com/ai-platform/deep-learning-containers/docs/choosing-container#choose_a_container_image_type)

Because the base image includes a number of large packages used for machine learning, building the image the first time may take a few minutes.

Image size: 7.37GB

To build the docker container and launch a Jupyter notebook server:

```
cd <path_to_working_directory>
docker build -t ml-workspace:latest ./
docker run -d --rm -p 8080:8080 -v $(PWD):/home/jupyter ml-workspace:latest
```
The jupyter instance should now available at https://localhost:8080/lab?

Flags:
- `--rm` - insures the container is removed once it is shutdown.
- `-p`  - manages port forwarding between the docker container and the host and can be configured for your local environment
- `-d` - runs the container in detached mode
- `-v` - CRITICAL - mounts the local directory and allows your work to be saved locally even after the container is stopped.

You can also run Jupyter Lab from within the container:

```
docker exec -it ml-workspace bash
jupyter lab --ip=0.0.0.0 --port=8080 --allow-root`
```

#### 2. Installing with `pip install`

Alternately, you can install via the standard pip installation method from the requirements.txt file.

See: https://packaging.python.org/guides/installing-using-pip-and-virtual-environments/

```
pip install -r requirements.txt

```

### Installing from GCP Container Registry

Finally, this image is available on Google Cloud Platform container registry, here:

`gcr.io/ml-workspace-99a/ml-workspace`

This container is currently private and only accessible to developers with 99 antennas developers.

To install the custom container into AI Notebooks from the container registry, first enable Google Cloud Platform Container Registry in your GCP project. See: https://cloud.google.com/ai-platform/notebooks/docs/custom-container

```
# Tag container
docker tag ml-workspace:latest gcr.io/ml-workspace-99a/ml-workspace
# Push container to container registry
docker push gcr.io/ml-workspace-99a/ml-workspace
```

### Known Issues
- This container does not include ssh server, but ssh is sometimes needed to authenticate to external resources (i.e. Github via ssh). To install an ssh server run: `apt update && apt install  openssh-server`

To do:
- Upload to Docker Hub (public)
- Add tensorflow tutorial
- Add Bayesian inference
- Add tslearn