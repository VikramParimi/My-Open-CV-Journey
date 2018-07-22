FROM ubuntu:16.04
LABEL Maintainer="Vikram Chowdary Parimi (Full-Stack Developer)" 

#STEP1: Update the apt-get  package manager and upgrade any pre-installed packages
RUN apt-get update && apt-get upgrade -y
RUN apt-get install -y \
    build-essential cmake pkg-config \
    wget \
    git \
    unzip \
    python2.7 python2.7-dev \
    python3.5 python3.5-dev python3-pip python3.5-venv \
    libjpeg8-dev libtiff5-dev libjasper-dev libpng12-dev \
    libgtk-3-dev \
    libavcodec-dev libavformat-dev libswscale-dev libv4l-dev \ 
    libxvidcore-dev libx264-dev \
    libatlas-base-dev gfortran \ 
    libboost-all-dev

#STEP8: Install pip, virtualenv  and virtualenvwrapper
RUN wget https://bootstrap.pypa.io/get-pip.py
RUN python get-pip.py
RUN pip install virtualenv virtualenvwrapper
RUN rm -rf ~/.cache/pip

#Appending following lines to ~/.bashrc file
RUN echo "# virtualenv and virtualenvwrapper" >> $HOME/.bashrc && \
    echo "export WORKON_HOME=$HOME/.virtualenvs" >> $HOME/.bashrc && \
    echo "source \"/usr/local/bin/virtualenvwrapper.sh\"" >> $HOME/.bashrc

#Set ENV Variable
ENV WORKON_HOME=/root/.virtualenvs
#Reload the .bashrc file
RUN /bin/bash -c "source /usr/local/bin/virtualenvwrapper.sh && \
    cd $HOME && \
    echo \"inside $WORKON_HOME\" && \
    mkvirtualenv gurus -p python3 && \ 
    pip install numpy && \
    pip install scipy matplotlib && \
    pip install scikit-learn && \
    pip install -U scikit-image && \
    pip install mahotas imutils Pillow commentjson && \
    apt-get install tcl-dev tk-dev -y && \ 
    workon gurus && \ 
    pip uninstall matplotlib -y && \ 
    git clone https://github.com/matplotlib/matplotlib.git && \
    cd matplotlib && \ 
    python setup.py install"

# Download OpenCV and unpack it  
RUN /bin/bash -c "cd $HOME && \
    wget -O opencv.zip https://github.com/opencv/opencv/archive/3.3.1.zip && \
    wget -O opencv_contrib.zip https://github.com/opencv/opencv_contrib/archive/3.3.1.zip && \ 
    unzip opencv.zip && \ 
    unzip opencv_contrib.zip && \ 
    cd opencv-3.3.1"

RUN /bin/bash -c "source /usr/local/bin/virtualenvwrapper.sh && \
    cd $HOME/opencv-3.3.1 && \
    mkdir build && \ 
    cd build && \ 
    workon gurus && \
    cmake -D CMAKE_BUILD_TYPE=RELEASE \
    -D CMAKE_INSTALL_PREFIX=/usr/local \
    -D WITH_CUDA=OFF \
    -D INSTALL_PYTHON_EXAMPLES=ON \
    -D OPENCV_EXTRA_MODULES_PATH=~/opencv_contrib-3.3.1/modules \
    -D BUILD_EXAMPLES=ON .. &&\
             make -j4 && \ 
             make install && \ 
             ldconfig && \
    cd ~/.virtualenvs/gurus/lib/python3.5/site-packages/ && \ 
    ln -s /usr/local/lib/python3.5/site-packages/cv2.cpython-35m-x86_64-linux-gnu.so cv2.so"

RUN cd ~ \
    wget https://gurus.pyimagesearch.com/wp-content/uploads/2015/03/pyimagesearch_gurus_logo.png
    
WORKDIR /bin/bash -c $HOME