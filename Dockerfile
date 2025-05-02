FROM ubuntu:latest

WORKDIR /root

COPY . ./dotfiles

RUN apt update

RUN chmod +x ./dotfiles/install.sh
CMD ["bash", "-c", "cd dotfiles && ./install.sh"]
