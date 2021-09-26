FROM pytorch/pytorch:1.9.0-cuda10.2-cudnn7-devel
RUN apt update && apt install -y neovim ffmpeg cmake wget silversearcher-ag git zsh\
    # Clean up
    && apt-get autoremove -y \
    && apt-get clean -y \
    && rm -rf /var/lib/apt/lists/*
RUN wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | zsh || true
RUN pip install matplotlib sklearn opencv-python imageio Pillow scikit-image scipy graphviz easydict pytorch-lightning ipython torchinfo click tensorboard
WORKDIR /me
ENTRYPOINT [ "/bin/zsh" ]
CMD ["-l"]
