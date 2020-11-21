FROM archlinux/archlinux

RUN pacman -Syu && \
    pacman -S --noconfirm base-devel cmake git && \
    pacman -Scc --noconfirm

COPY g_wheel /etc/sudoers.d/
RUN chmod 440 /etc/sudoers.d/g_wheel && \
    useradd -m -g users -G wheel,systemd-journal arch && \
    passwd -d arch

ENV PATH="/usr/local/x-tools7h/arm-unknown-linux-gnueabihf/bin:$PATH"
COPY makepkg-armv7h.conf /etc/makepkg.conf
COPY pacman-armv7h.conf /etc/pacman-armv7h.conf
COPY pacman-armv7h.sh /usr/local/bin/pacman-armv7h
RUN chmod +x /usr/local/bin/pacman-armv7h && \
    mkdir -p /usr/local/x-tools7h/ && \
    chmod -R u+w /usr/local/x-tools7h/

VOLUME /mnt
VOLUME /usr/local/x-tools7h
WORKDIR /mnt
USER arch
CMD ["makepkg", "-f"]
