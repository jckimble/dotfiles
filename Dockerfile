FROM base/archlinux:latest
MAINTAINER James Kimble <jckimble@pm.me>

RUN pacman -Syu --noconfirm vim git tmux go docker docker-compose openssh sudo

RUN useradd -ms /bin/bash jckimble
ADD . /home/jckimble/dotfiles/
RUN cd /home/jckimble/dotfiles && ./run.sh
RUN echo "jckimble ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
RUN sed -i 's/#en_US.UTF-8/en_US.UTF-8/' /etc/locale.gen && locale-gen
RUN ln -sf /usr/share/zoneinfo/America/Chicago /etc/localtime
RUN chown -R jckimble:users /home/jckimble
USER jckimble
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US.UTF-8
ENV LC_ALL en_US.UTF-8
ENV TERM screen-256color
WORKDIR /home/jckimble
VOLUME ["/run/user/1000/gnupg/S.gpg-agent","/run/user/1000/gnupg/S.gpg-agent.ssh","/run/docker.sock"]
CMD ["/usr/bin/tmux"]
