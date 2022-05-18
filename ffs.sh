CONFIGFS_ROOT=/sys/kernel/config
cd "${CONFIGFS_ROOT}"/usb_gadget

# create gadget directory and enter it
mkdir canokey
cd canokey

# USB ids
echo 0x20A0 > idVendor
echo 0x42D4 > idProduct

# USB strings, optional
mkdir strings/0x409 # US English, others rarely seen
echo "canokeys.org" > strings/0x409/manufacturer
echo "CanoKey FunctionFS" > strings/0x409/product

# create the (only) configuration
mkdir configs/c.1 # dot and number mandatory

# create the (only) function
mkdir functions/ffs.canokey # .

# assign function to configuration
ln -s functions/ffs.canokey/ configs/c.1/

# bind the first UDC!
echo $(ls -1 /sys/class/udc/ | head -1) > UDC # ls /sys/class/udc to see available UDCs

