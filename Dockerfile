FROM base/archlinux:latest
MAINTAINER James Kimble <jckimble@pm.me>

RUN pacman -Syu --noconfirm vim git tmux go docker docker-compose openssh sudo wget python-pywal
RUN wget -O /usr/local/bin/dsinit -q https://gitlab.com/jckimble/dockerssh/-/jobs/artifacts/master/raw/util/dsinit/dsinit?job=dsinit-build && chmod +x /usr/local/bin/dsinit

RUN useradd -ms /bin/bash jckimble
ADD . /home/jckimble/dotfiles/
RUN echo "jckimble ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
RUN sed -i 's/#en_US.UTF-8/en_US.UTF-8/' /etc/locale.gen && locale-gen
RUN ln -sf /usr/share/zoneinfo/America/Chicago /etc/localtime
RUN chown -R jckimble:users /home/jckimble
USER jckimble
ENV USER jckimble
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US.UTF-8
ENV LC_ALL en_US.UTF-8
ENV TERM screen-256color
WORKDIR /home/jckimble
RUN cd /home/jckimble && ./dotfiles/run.sh
RUN wal -q -i ~/.config/wallpapers/
VOLUME ["/home/jckimble/.gnupg/S.gpg-agent","/home/jckimble/.gnupg/S.gpg-agent.ssh","/run/docker.sock"]
ENTRYPOINT ["/usr/local/bin/dsinit"]
CMD ["/usr/bin/tmux"]
