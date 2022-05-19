# Canokey FunctionFS

FunctionFS is a Linux kernel feature that allows you to run a program in userspace and expose the whole device as a USB device.

For example, you can turn your RPi (RPi4/Pi Zero have UDC) into a CanoKey, or you can use `usbip-vudc` to expose a CanoKey at tcp port 3240, then other machine can connect to it via USB/IP (similar to canokey-usbip).

This is only for testing purpose and there is no warranty on security.

## Compile

```bash
mkdir build; cd build
cmake ..
make -j`nproc`
```

## Run

First you need to ensure you have a UDC, either virtual (usbip-vudc) or real (dwc2). You can modprobe them and check that `/sys/class/udc` is not empty.

Then you need to setup ConfigFS, there are two ways

1. Use `ffs.sh` to manually setup all via configfs
2. Use [gt](https://github.com/linux-usb-gadgets/gt), see `ffs.scheme`. You can use [this blog](https://www.collabora.com/news-and-blog/blog/2019/02/18/modern-usb-gadget-on-linux-and-how-to-integrate-it-with-systemd-part-1/) as tutorial.

Then mount the file system (you can use path other than `/srv/canokey`)

```bash
mount -t functionfs canokey /srv/canokey
```

Now you can see ep0 in `/srv/canokey`, then you should run `canokey-ffs` inside FunctionFS like this

```bash
cd /srv/canokey
/path/to/your/canokey-ffs
```

## Known limitation

WebUSB does not work as WebUSB needs USB 2.1 (BOS descriptor) but ConfigFS does not support it.
