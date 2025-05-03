FROM ubuntu:latest

RUN apt-get update && apt-get upgrade -y \
    && apt-get install -y sudo

WORKDIR /root

COPY . ./dotfiles

RUN chmod +x ./dotfiles/install.sh
CMD ["bash", "-c", "cd dotfiles && ./install.sh"]
