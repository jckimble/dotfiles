FROM archlinux/base:latest
MAINTAINER James Kimble <jckimble@pm.me>

RUN pacman -Syu --noconfirm base base-devel vim git tmux go podman openssh sudo wget which && rm -rf /var/cache/pacman/pkg/* /var/lib/pacman/sync/*

ENV TINI_VERSION v0.19.0
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini /usr/bin/tini
RUN chmod +x /usr/bin/tini
ENTRYPOINT ["/usr/bin/tini", "--"]

RUN useradd -ms /bin/bash jckimble
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
RUN go get github.com/Jguer/yay && /home/jckimble/go/bin/yay -Syu --noconfirm yadm yay && sudo rm -rf /var/cache/pacman/pkg/* /var/lib/pacman/sync/* && find . ! -path . ! -path .. -prune -exec rm -rf -- {} +

RUN yadm clone https://gitlab.com/jckimble/dotfiles.git
RUN vim -E -u NONE +qall || true
VOLUME ["/home/jckimble/.gnupg/S.gpg-agent","/home/jckimble/.gnupg/S.gpg-agent.ssh"]
CMD ["/usr/bin/tmux"]
