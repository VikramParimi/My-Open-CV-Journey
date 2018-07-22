#OpenCV-DockerImage
Dockerfile to build an OpenCV docker image with ML frameworks.

### My-Open-CV-Journey
Starting my OpenCV Journey and committing myself to push regular updates

## Quick Start

The Docker image will be of 8GB so build your own using the DockerFile. Customize the packages as per your needs.

### Building the Docker Image

```bash
cd /pathToYoutDockerFileLocation
docker build -t dockerImageName:tag .
eg : docker build -t opencv:1.0
```
This will take a while to download all the packages and build OpenCV in the VirtualEnv. 

**After completion, you can test your OpenCv Installation**

*Start by creating the docker container*

```bash
docker --rm -ti --name opencvcontainer imageName:tag
eg : docker --rm -ti --name opencvcontainer opencv:1.0
```

*Test OpenCv*
```bash
workon gurus
python
>>> import cv2
```
If no error is shown, your OpenCv docker image has been sucessfully built with all necessary packages.



