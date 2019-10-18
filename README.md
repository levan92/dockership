# Build
- To build docker image:
`sudo nvidia-docker build -t "levan92/keras-torch-cv2" .`

# Usage
- To run docker image:
`sudo nvidia-docker run -it --volume="/home/dh/Workspace/:/home/Workspace" --volume='/media/dh/DATA4TB/Datasets:/home/data'   levan92/keras-torch-cv2`

- To run with USB webcam mapping:
`sudo nvidia-docker run -it --volume="/home/dh/Workspace/ptzaurus/:/home/ptzaurus" --privileged -v /dev/video0:/dev/video0  levan92/keras-torch-cv2`

- To run with display:
`sudo nvidia-docker run -it --volume="/home/dh/Workspace/:/home/Workspace" --volume='/media/dh/Data:/home/data' --net=host --ipc host --env="DISPLAY" --volume="$HOME/.Xauthority:/root/.Xauthority:rw"  levan92/keras-torch-cv2`

# Export
Make sure container is running
`sudo nvidia-docker run -it levan92/keras-torch-cv2`
Find the container ID
`sudo docker ps`
Export it!
`sudo docker export e1c8bc777856 > keras-torch-cv2.tar`

# Import
`sudo docker load < keras-torch-cv2.tar`



