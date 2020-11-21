FROM archlinux/archlinux

RUN pacman -Syu && \
    pacman -S --noconfirm archiso && \
    pacman -Scc --noconfirm

VOLUME /work
VOLUME /out
VOLUME /var/cache/pacman/pkg

ENTRYPOINT ["mkarchiso", "-w", "/work", "-o", "/out"]
