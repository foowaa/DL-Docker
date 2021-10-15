# ZZROOT is the root dir of all the installation
# you may put these lines into your .bashrc/.zshrc/etc.
echo -n 'export ZZROOT=$HOME/app' >> ~/.zshrc 
echo -n 'PATH=$ZZROOT/bin:$PATH' >> ~/.zshrc 
echo -n 'LD_LIBRARY_PATH=$ZZROOT/lib:$ZZROOT/lib64:$LD_LIBRARY_PATH' >> ~/.zshrc
echo -n 'OpenCV_DIR=$ZZROOT' >> ~/.zshrc
echo -n 'BOOST_ROOT=$ZZROOT' >> ~/.zshrc
source ~/.zshrc

# fetch install 
git clone https://github/innerlee/setup.git
chmod -R +x setup

cd setup

# opencv depends on ffmpeg for video decoding
# ffmpeg depends on nasm, yasm, libx264, libx265, libvpx
./zznasm.sh
./zzyasm.sh
./zzlibx264.sh
./zzlibx265.sh
./zzlibvpx.sh
# finally install ffmpeg
./zzffmpeg.sh

# install opencv 4.3.0
./zzopencv.sh


# install boost
./zzboost.sh



# finally, install denseflow
./zzdenseflow.sh
