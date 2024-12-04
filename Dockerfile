# 使用 Ubuntu 作为基础镜像
FROM ubuntu:latest

# 设置环境变量以避免交互式安装
ENV DEBIAN_FRONTEND=noninteractive

# 安装必要依赖
RUN apt-get update && apt-get install -y \
    git \
    cmake \
    gcc \
    make \
    libssl-dev \
    zlib1g-dev \
    libuv1-dev \
    libjson-c-dev \
    libwebsockets-dev && \
    apt-get clean

# 克隆 ttyd 仓库并构建
RUN git clone https://github.com/tsl0922/ttyd.git /ttyd && \
    cd /ttyd && \
    mkdir build && \
    cd build && \
    cmake .. && \
    make && \
    make install

# 暴露端口（仅供参考，Railway 会动态分配端口）
EXPOSE 8080

# 设置 ENTRYPOINT，直接使用 ttyd 并传递参数
ENTRYPOINT ["ttyd", "--port"]

# 使用 CMD 传递默认的环境变量和命令
CMD ["$PORT", "bash"]
