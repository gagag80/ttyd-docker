FROM ubuntu:latest

# 安装必要的依赖
RUN apt-get update && apt-get install -y \
    git \
    cmake \
    gcc \
    make \
    libssl-dev \
    zlib1g-dev \
    libuv1-dev \
    libjson-c-dev \
    libwebsockets-dev \
    vim \
    curl && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# 编译安装 ttyd
RUN git clone https://github.com/tsl0922/ttyd.git /ttyd && \
    cd /ttyd && \
    mkdir build && \
    cd build && \
    cmake .. && \
    make && \
    make install && \
    cd / && \
    rm -rf /ttyd

# 设置工作目录
WORKDIR /root

# 暴露端口
EXPOSE 7681

# 设置默认端口
ENV PORT=7681

# 启动命令 - 显式指定 interface 为 0.0.0.0
CMD ["sh", "-c", "ttyd --interface 0.0.0.0 -p ${PORT} bash"]
