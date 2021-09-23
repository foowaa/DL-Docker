FROM pytorch/pytorch:1.9.0-cuda10.2-cudnn7-devel
RUN apt install -y neovim, build-essential, ffmpeg
RUN pip install matplotlib, sklearn, opencv-python, imageio, Pillow, scikit-image, scipy, graphviz, easydict, gym, tensorboardX, pytorch-lightning
WORKDIR /me
