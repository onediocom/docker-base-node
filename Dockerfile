FROM ubuntu:14.04

ENV NODE_VERSION 0.10.35
ENV GIFSICLE_VERSION 1.87
ENV FFMPEG_VERSION 2.5.1

WORKDIR /tmp

RUN apt-get update && apt-get install -y build-essential wget xz-utils graphicsmagick webp

RUN wget -q "http://www.lcdf.org/gifsicle/gifsicle-$GIFSICLE_VERSION.tar.gz" && \
  tar -zxf "gifsicle-$GIFSICLE_VERSION.tar.gz" && cd gifsicle-$GIFSICLE_VERSION && \
  ./configure && make && make install

RUN wget -q "http://nodejs.org/dist/v$NODE_VERSION/node-v$NODE_VERSION-linux-x64.tar.gz" && \
  tar -zxf "node-v$NODE_VERSION-linux-x64.tar.gz" -C /usr/local --strip-components=1

RUN wget -q "http://johnvansickle.com/ffmpeg/releases/ffmpeg-$FFMPEG_VERSION-64bit-static.tar.xz" && \
  tar -xf ffmpeg-$FFMPEG_VERSION-64bit-static.tar.xz && cd ffmpeg-$FFMPEG_VERSION-64bit-static && \
  mv ffmpeg ffmpeg-10bit ffprobe qt-faststart /usr/local/bin/

RUN wget -q https://s3.amazonaws.com/Onedio/bin/phantomjs && mv phantomjs /usr/bin && chmod +x /usr/bin/phantomjs

RUN npm install -g npm && npm cache clear

RUN rm -rf /tmp/*

CMD ["/bin/bash"]
