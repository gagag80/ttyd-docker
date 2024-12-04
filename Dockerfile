# 使用 Ubuntu 作为基础镜像
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
    libwebsockets-dev && \
    apt-get clean

# 克隆 ttyd 源代码并编译
RUN git clone https://github.com/tsl0922/ttyd.git /ttyd && \
    cd /ttyd && \
    mkdir build && \
    cd build && \
    cmake .. && \
    make && \
    make install

# 设置工作目录
WORKDIR /app

# 暴露端口（Railway 会动态分配端口）
EXPOSE 8080

# 使用环境变量 PORT，确保兼容 Railway 的动态端口分配
ENV PORT=8080

# 设置默认启动命令，启用可写模式并动态监听 Railway 分配的端口
CMD ["sh", "-c", "ttyd --writable -p ${PORT} bash"]
