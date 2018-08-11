FROM archlinux/base

RUN pacman -Sy
RUN pacman -S --noconfirm archiso
RUN yes | pacman -Scc --noconfirm

VOLUME /work
VOLUME /out

ENTRYPOINT ["/usr/share/archiso/configs/baseline/build.sh"]
