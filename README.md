# Docker container for PyTorch training

## Info
* This project can be used for building docker container and training models using PyTorch within the container
* The base docker container used in this project can be found [here](https://github.com/anibali/docker-pytorch)

## Building the container
* Add any additional python or system dependencies to the [Dockerfile](Dockerfile)
* Use the following command to build the container
```
docker build -t my_pytorch .
```

## Resolving Error
* If the error is the following `docker: Error response from daemon: could not select device driver "" with capabilities: [[gpu]].`,
then follow the instructions to install additional `nvidia-container-toolkit`
* The instructions can be found in the following [nvidia-container-toolkit instructions website](https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/latest/install-guide.html)
  1.  Configure the repo, run the following command
    ```
      curl -fsSL https://nvidia.github.io/libnvidia-container/gpgkey | sudo gpg --dearmor -o /usr/share/keyrings/nvidia-container-toolkit-keyring.gpg \
  && curl -s -L https://nvidia.github.io/libnvidia-container/stable/deb/nvidia-container-toolkit.list | \
    sed 's#deb https://#deb [signed-by=/usr/share/keyrings/nvidia-container-toolkit-keyring.gpg] https://#g' | \
    sudo tee /etc/apt/sources.list.d/nvidia-container-toolkit.list
    ```
  2. Update the packages list from the repo, run the following command
    ```
    sudo apt-get update
    ```
  3. Install the nvidia-container-toolkit, run the following command
    ```
    sudo apt-get install -y nvidia-container-toolkit
    ```
  4. Configure the runtime container, run the following command
    ```
    sudo nvidia-ctk runtime configure --runtime=docker
    ```
  5. Restart the docker daemon
    ```
    sudo systemctl restart docker
    ```

## Running training with PyTorch
* Copy the directory containing the dataset files into the project directory so that it can be directly mounted onto the docker container
* This happens with the option `--volume`
* The following example command shows how to run the training
```
docker run --rm -it --init   --gpus=all   --ipc=host   --user="$(id -u):$(id -g)"   --volume="$PWD:/app"   my_pytorch python3 modeling/train.py --dir_dataset /app/version2/
```
* In the above example `my_pytorch` is the name of the docker container, `version2` is the directory containing the dataset files
