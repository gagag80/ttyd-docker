FROM alpine:latest

# 安装构建工具和 ttyd 依赖
RUN apk add --no-cache build-base cmake git libwebsockets libwebsockets-dev bash

# 克隆 ttyd 仓库并构建
RUN git clone https://github.com/tsl0922/ttyd.git /ttyd && \
    cd /ttyd && \
    mkdir build && \
    cd build && \
    cmake .. && \
    make && \
    make install

# 设置启动命令
CMD ["ttyd", "-p", "3000", "bash"]
