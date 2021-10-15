FROM pytorch/pytorch:1.9.0-cuda10.2-cudnn7-devel
RUN apt update && apt install -y software-properties-common && add-apt-repository "deb http://security.ubuntu.com/ubuntu xenial-security main"
RUN apt update  && apt install -y build-essential neovim ffmpeg cmake wget silversearcher-ag git zsh curl zip unzip jq libturbojpeg  ninja-build libglib2.0-0 libsm6 \ 
    libxrender-dev libxext6 checkinstall pkg-config yasm gfortran 
RUN apt install libjpeg8-dev 
RUN apt install libjasper-dev
RUN apt install libpng12-dev
RUN apt install libtiff5-dev
RUN apt install libtiff-dev
RUN apt install libavcodec-dev 
RUN apt install libavformat-dev  
RUN apt install libswscale-dev
RUN apt install libdc1394-22-dev
RUN apt install libxine2-dev
RUN apt install libv4l-dev
RUN apt install libgstreamer0.10-dev
RUN apt install libgstreamer-plugins-base0.10-dev
RUN apt install libgtk2.0-dev 
RUN apt install libtbb-dev 
RUN apt install libatlas-base-dev
RUN apt install libfaac-dev
RUN apt install libmp3lame-dev
RUN apt install libtheora-dev
RUN apt install libvorbis-dev
RUN apt install libxvidcore-dev
RUN apt install libopencore-amrnb-dev
RUN apt install libopencore-amrwb-dev
RUN apt install libavresample-dev
RUN apt install x264
RUN apt install v4l-utils
RUN apt install libboost-all-dev
    # Clean up
    # && apt-get autoremove -y \
    # && apt-get clean -y \
    # && rm -rf /var/lib/apt/lists/* 
RUN cd /usr/include/linux && ln -s -f ../libv4l1-videodev.h videodev.h
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

#install denseflow
WORKDIR /me
RUN git clone https://github.com/opencv/opencv.git && cd opencv && git checkout master && cd .. 
RUN git clone clone https://github.com/opencv/opencv_contrib.git && cd opencv_contrib && git checkout master && cd .. 
RUN cd opencv && mkdir build && cd build && cmake -D CMAKE_BUILD_TYPE=RELEASE -D CMAKE_INSTALL_PREFIX=/usr/local/OpenCV -D INSTALL_C_EXAMPLES=ON \
    -D WITH_TBB=ON -D WITH_V4L=ON -D WITH_OPENGL=ON  -D OPENCV_EXTRA_MODULES_PATH=../../opencv_contrib/modules -D BUILD_EXAMPLES=ON .. && make j4 && make install
RUN git clone https://github.com/open-mmlab/denseflow.git && cd denseflow && git checkout master && mkdir build && cd build \
    && cmake -DCMAKE_INSTALL_PREFIX=/usr/local/denseflow -DUSE_HDF5=no -DUSE_NVFLOW=no .. && make -j 4 && make install

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
