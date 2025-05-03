FROM ubuntu:latest

RUN apt-get update && apt-get upgrade -y \
    && apt-get install -y sudo

WORKDIR /root

COPY . ./dotfiles

RUN chmod +x ./dotfiles/install.sh
# CMD ["bash", "-c", "cd dotfiles && ./install.sh"]
RUN bash -c "cd dotfiles && ./install.sh"

# Check if installation was successful
RUN which tmux
RUN which zsh
RUN which git
RUN which curl

CMD ["echo", "Setup process finished successfully!"]
