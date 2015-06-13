# robot-hand
Arduino control code for a metal hand.

## Setup on linux

### Dependencies
Install the following with a package manager or install the binaries.
- avr-gcc
- avr-libc
- avrdude

### Configure
Export the following variables if they differ from the defaults.
- `ARDUINO_DIR`, location where arduino is installed, defaults to `/usr/share/arduino`
- `PORT`, the usb device where arduino is plugged into, defaults to `/dev/ttyACM0`

Set the following variables based on what arduino device is being written to.
These can be found somewhere in `/usr/share/arduino/hardware/arduino/avr/boards.txt` The default is for the arduino Uno:
```
F_CPU, MCU, UPLOAD_RATE
```

### Compile
After exporting the vars in the configure section run:
```
make TARGET={target} && make upload TARGET={target}
```
where {target} is the target c file to compile. For example:
```
make TARGET=blinker && make upload TARGET=blinker
```

The `TARGET` variable can also be exported.

## Setup on Windows
I haven't figured this out yet.

