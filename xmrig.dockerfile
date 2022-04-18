FROM ubuntu:22.04

# Setting up Timezone
ENV TZ=Asia/Kolkata
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && \
    echo $TZ > /etc/timezone

WORKDIR /app
USER root

# Install dependencies
RUN apt-get update 
RUN apt-get install -y \
    build-essential \
    git \
    curl \
    cmake \
    libuv1-dev \
    libssl-dev \
    libhwloc-dev

# Install xmrig
RUN git clone https://github.com/MoneroOcean/xmrig
RUN mkdir /app/xmrig/build
WORKDIR /app/xmrig/build
RUN cmake .. && \
    make

# Copy config.json file
COPY ./config.json /app/xmrig/build

CMD ["./xmrig"]



