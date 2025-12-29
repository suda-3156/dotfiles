FROM ubuntu:24.04

RUN apt-get update && apt-get install -y sudo

WORKDIR /root
COPY . ./dotfiles
