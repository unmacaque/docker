# archlinux-armv7h-cc

To build the image run:

```
docker build -t asrock.fritz.box/archlinux-armv7h-cc
```

To start the image:

```
docker run -it \
  --name archlinux-armv7h-cc \
   -v ./mnt:/mnt \
   -v ./xtools-7h:/usr/local/x-tools7h \
   asrock.fritz.box/archlinux-armv7h-cc
```

Enter the container to install the cross compilation toolkit:

```
docker exec -it archlinux-armv7h-cc /bin/bash
curl https://archlinuxarm.org/builder/xtools/x-tools7h.tar.xz -o /tmp/x-tools7h.tar.xz
tar xvf /tmp/x-tools7h.tar.xz -C /usr/local/
rm -v /tmp/x-tools7h.tar.xz
```

Install dependencies with the included `pacman-armv7h` script as needed.

Finally, place the source files containing the `PKGBUILD` in the mounted volume directory `/mnt` and run this command to create a package for the foreign architecture:

```
docker exec archlinux-armv7h-cc -c "cd /mnt/ && makepkg"
```
