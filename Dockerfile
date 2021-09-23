FROM pytorch/pytorch:1.9.0-cuda10.2-cudnn7-devel
RUN apt update && apt install -y vim ffmpeg cmake
RUN pip install matplotlib sklearn opencv-python imageio Pillow scikit-image scipy graphviz easydict pytorch-lightning ipython torchinfo
WORKDIR /me
