FROM archlinux

RUN pacman -S --noconfirm base-devel cmake git
RUN yes | pacman -Scc --noconfirm

ADD g_wheel /etc/sudoers.d/
RUN chmod 440 /etc/sudoers.d/g_wheel && \
    useradd -m -g users -G wheel,systemd-journal arch && \
    passwd -d arch

ENV PATH="/usr/local/x-tools7h/arm-unknown-linux-gnueabihf/bin:$PATH"
ADD makepkg-armv7h.conf /etc/makepkg.conf
ADD pacman-armv7h.sh /usr/local/bin/pacman-armv7h
RUN chmod +x /usr/local/bin/pacman-armv7h && \
    mkdir -p /usr/local/x-tools7h/arm-unknown-linux-gnueabihf/arm-unknown-linux-gnueabihf/sysroot/ && \
    chmod -R u+w /usr/local/x-tools7h/arm-unknown-linux-gnueabihf/arm-unknown-linux-gnueabihf/sysroot/

VOLUME /usr/local/x-tools7h/arm-unknown-linux-gnueabihf/arm-unknown-linux-gnueabihf/sysroot
USER arch
ENTRYPOINT ["/bin/bash"]
