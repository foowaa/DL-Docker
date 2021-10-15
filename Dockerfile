FROM pytorch/pytorch:1.9.0-cuda10.2-cudnn7-devel
RUN apt update && apt install -y build-essential neovim ffmpeg cmake wget silversearcher-ag git zsh curl zip unzip jq libturbojpeg  ninja-build libglib2.0-0 libsm6 libxrender-dev libxext6\
    # Clean up
    && apt-get autoremove -y \
    && apt-get clean -y \
    && rm -rf /var/lib/apt/lists/* 
RUN wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | zsh || true
RUN pip install matplotlib sklearn opencv-python imageio Pillow scikit-image scipy graphviz easydict pytorch-lightning ipython torchinfo click \
    tensorboardX jieba pandas statsmodels lightgbm arrow einops fvcore pyyaml seaborn onnx tensorrt pycuda pydub moviepy natsort pudb pytz sympy \
    PySnooper loguru merry tenacity environs pypinyin attrs cattrs lmdb torchaudio torchtext sh dill h5py networkx[default] librosa hickle cupy-cuda102 \
    pytorchvideo msgpack pyarrow thefuzz torchmetrics onnxruntime onnxruntime-gpu kornia Augmentor tormentor lightning-flash lightning-transformers lightning-bolts \
    download  decord==0.4.1 av
RUN pip install mmcv-full==1.3.14 -f https://download.openmmlab.com/mmcv/dist/cu102/torch1.9.0/index.html
RUN wget https://github.com/zyedidia/micro/releases/download/v2.0.10/micro-2.0.10-amd64.deb && dpkg -i micro-2.0.10-amd64.deb && rm micro-2.0.10-amd64.deb \
    && wget https://github.com/sharkdp/fd/releases/download/v8.2.1/fd_8.2.1_amd64.deb && dpkg -i fd_8.2.1_amd64.deb && rm fd_8.2.1_amd64.deb \
    && git clone https://github.com/sharkdp/dbg-macro && ln -s $(readlink -f dbg-macro/dbg.h) /usr/include/dbg.h
# Install MMAction2
RUN git clone https://github.com/open-mmlab/mmaction2.git /mmaction2
WORKDIR /mmaction2
RUN mkdir -p /mmaction2/data
ENV FORCE_CUDA="1"
RUN pip install cython --no-cache-dir
RUN pip install --no-cache-dir -e .

WORKDIR /me
ENTRYPOINT [ "/bin/zsh" ]
CMD ["-l"]
