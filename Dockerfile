# 使用 Ubuntu 作为基础镜像
FROM ubuntu:latest

# 设置环境变量以避免交互式安装
ENV DEBIAN_FRONTEND=noninteractive

# 更新包管理器并安装必要依赖
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

# 暴露服务端口（仅文档化，实际端口由 $PORT 决定）
EXPOSE 7681

# 设置默认命令，强制依赖 $PORT 环境变量
CMD ["sh", "-c", "if [ -z \"$PORT\" ]; then echo 'Error: PORT environment variable not set!' && exit 1; fi && ttyd --port $PORT bash"]
