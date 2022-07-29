FROM archlinux:base
MAINTAINER James C Kimble <me@jckimble.com>

ARG BUILD_DATE=unknown
ENV BUILD_DATE=$BUILD_DATE

RUN pacman -Syu --noconfirm --noprogressbar --ignore linux --ignore linux-firmware base base-devel vim git zsh tmux openssh sudo wget which && rm -rf /var/cache/pacman/pkg/* /var/lib/pacman/sync/*

ENV TINI_VERSION v0.19.0
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini /usr/bin/tini
RUN chmod +x /usr/bin/tini
ENTRYPOINT ["/usr/bin/tini", "--"]

RUN useradd -ms /bin/zsh jckimble
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
RUN sudo pacman -Sy --noconfirm --noprogressbar && git clone https://aur.archlinux.org/yay.git \
  && cd yay \
  && makepkg -sri --needed --noconfirm --noprogressbar \
  && cd .. \
  && yay -Syu --noconfirm --noprogressbar --needed ngrok kr-bin yadm yay && sudo rm -rf /var/cache/pacman/pkg/* /var/lib/pacman/sync/* && find . ! -path . ! -path .. -prune -exec sudo rm -rf -- {} +

ARG BUILD_TIME=unknown
ENV BUILD_TIME=$BUILD_TIME
RUN yadm clone --bootstrap https://github.com/jckimble/dotfiles.git
RUN vim -T dumb -n -i NONE -E -S ~/.config/vimplug +PluginInstall +qall
VOLUME ["/home/jckimble/workspace"]
CMD ["/usr/bin/tmux"]
