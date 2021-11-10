FROM pytorch/pytorch:1.9.0-cuda10.2-cudnn7-devel
RUN apt update && apt install -y build-essential neovim ffmpeg cmake wget silversearcher-ag git zsh curl zip unzip jq libturbojpeg  ninja-build libglib2.0-0 libsm6 \ 
    libxrender-dev libxext6 checkinstall pkg-config yasm gfortran libavcodec-dev libavfilter-dev libavformat-dev libavutil-dev \
    # Clean up
    && apt-get autoremove -y \
    && apt-get clean -y \
    && rm -rf /var/lib/apt/lists/* 
RUN pip install matplotlib sklearn opencv-python imageio Pillow scikit-image scipy graphviz easydict pytorch-lightning ipython torchinfo click \
    tensorboardX jieba pandas statsmodels lightgbm arrow einops fvcore pyyaml seaborn onnx tensorrt pycuda pydub moviepy natsort pudb pytz sympy \
    PySnooper loguru merry tenacity environs pypinyin attrs cattrs lmdb sh dill h5py networkx[default] librosa cupy-cuda102 \
    pytorchvideo msgpack pyarrow thefuzz onnxruntime onnxruntime-gpu kornia Augmentor tormentor lightning-flash lightning-transformers lightning-bolts \
    download decord av paddlepaddle-gpu paddlevideo torchnet tabulate torchdata torchaudio torchtext torchmetrics darts

RUN wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | zsh || true

WORKDIR /me
RUN wget http://tamacom.com/global/global-6.6.2.tar.gz 
RUN tar xzvf global-6.6.2.tar.gz 
RUN cd global-6.6.2 
RUN ./configure --disable-gtagscscope
RUN make 
RUN make install

#install denseflow
# WORKDIR ~
# COPY install_denseflow.sh .
# RUN chmod +x install_denseflow.sh
# RUN ./install_denseflow.sh


#install decord for GPU
# WORKDIR /me
# RUN git clone --recursive https://github.com/dmlc/decord && cd decord && mkdir build && cd build 
# RUN cmake .. -DUSE_CUDA=ON -DCMAKE_BUILD_TYPE=Release
# RUN make
# RUN cd ../python && python setup.py install --user


WORKDIR /me
RUN wget https://github.com/zyedidia/micro/releases/download/v2.0.10/micro-2.0.10-amd64.deb && dpkg -i micro-2.0.10-amd64.deb && rm micro-2.0.10-amd64.deb \
    && wget https://github.com/sharkdp/fd/releases/download/v8.2.1/fd_8.2.1_amd64.deb && dpkg -i fd_8.2.1_amd64.deb && rm fd_8.2.1_amd64.deb \
    && git clone https://github.com/sharkdp/dbg-macro && ln -s $(readlink -f dbg-macro/dbg.h) /usr/include/dbg.h

RUN pip uninstall torchtext -y && pip install torchtext

WORKDIR /me
ENTRYPOINT [ "/bin/zsh" ]
CMD ["-l"]
