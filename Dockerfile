FROM pytorch/pytorch:1.9.0-cuda10.2-cudnn7-devel
RUN apt update && apt install -y neovim ffmpeg cmake wget silversearcher-ag git zsh curl zip unzip\
    # Clean up
    && apt-get autoremove -y \
    && apt-get clean -y \
    && rm -rf /var/lib/apt/lists/* 
RUN wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | zsh || true
RUN pip install matplotlib sklearn opencv-python imageio Pillow scikit-image scipy graphviz easydict pytorch-lightning ipython torchinfo click \
    tensorboardX jieba pandas statsmodels lightgbm arrow einops fvcore pyyaml seaborn onnx tensorrt pycuda \
    https://github.com/sightmachine/SimpleCV/zipball/develop
RUN wget https://github.com/zyedidia/micro/releases/download/v2.0.10/micro-2.0.10-amd64.deb && dpkg -i micro-2.0.10-amd64.deb && rm micro-2.0.10-amd64.deb && \
    wget https://github.com/sharkdp/fd/releases/download/v8.2.1/fd_8.2.1_amd64.deb && dpkg -i fd_8.2.1_amd64.deb && rm fd_8.2.1_amd64.deb
WORKDIR /me
ENTRYPOINT [ "/bin/zsh" ]
CMD ["-l"]
