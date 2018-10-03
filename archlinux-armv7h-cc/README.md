# archlinux-armv7h-cc

To build the image run:

```
docker build -t asrock.fritz.box/archlinux-armv7h-cc
```

Firstly, prepare the development environment by starting the image:

```
docker run --rm -it \
  --name archlinux-armv7h-cc \
   -v ./mnt:/mnt \
   -v ./x-tools7h:/usr/local/x-tools7h \
   asrock.fritz.box/archlinux-armv7h-cc \
   bash
```

Once entered, install the cross compilation toolkit:

```
curl https://archlinuxarm.org/builder/xtools/x-tools7h.tar.xz -o /tmp/x-tools7h.tar.xz
tar xvf /tmp/x-tools7h.tar.xz -C /usr/local/
rm -v /tmp/x-tools7h.tar.xz
```

Install additional dependencies with the included `pacman-armv7h` script as needed. Exit the container afterwards.

Finally, place the source files containing the `PKGBUILD` in the mounted volume directory `/mnt` and run the image again with no explicit command specified.
