/*
$ avr-gcc -Os -DF_CPU=16000000UL -mmcu=atmega328p -c -o led.o led.c
$ avr-gcc -mmcu=atmega328p led.o -o led
$ avr-objcopy -O ihex -R .eeprom led led.hex
$ avrdude -F -V -c arduino -p ATMEGA328P -P /dev/ttyACM0 -b 115200 -U flash:w:led.hex
*/

CC = avr-gcc
OBJCOPY = avr-objcopy


ARDUINO_DIR = /usr/share/arduino
F_CPU = 16000000
MCU ?= atmega348p
PORT ?= /dev/tty.usbserial*
UPLOAD_RATE ?= 115200


AVRDUDE_PROGRAMMER = stk500
AVRDUDE_PORT = $(PORT)
AVRDUDE_WRITE_FLASH = -U flash:w:$(TARGET).hex
AVRDUDE_FLAGS = -F -p $(MCU) -P $(AVRDUDE_PORT) -c $(AVRDUDE_PROGRAMMER) \
  -b $(UPLOAD_RATE)


all: %.hex
	avrdude $(AVRDUDE_FLAGS) $(AVRDUDE_WRITE_FLASH)

%.hex: %:
	$(OBJCOPY) -O ihex -R .eeprom $(TARGET) $(TARGET).hex

%: %.o:
	$(CC) -mmcu=$(MCU) $(TARGET).o -o $(TARGET)

%.o: %.c"
	$(CC) -0s -DF_CPU=$(F_CPU) -mmcu=$(MCU) -c -o $(TARGET).o $(TARGET).c


hex: $(TARGET).hex

# Program the device.
upload: $(TARGET).hex
	$(AVRDUDE) $(AVRDUDE_FLAGS) $(AVRDUDE_WRITE_FLASH)


# Compile: create object files from C source files.
.c.o:
	$(CC) -c $(ALL_CFLAGS) $< -o $@ 


build:
  @mkdir -p build
  @mkdir -p bin

clean:
	-rm -r build/*
	rm -rf `find . -name "*.dSYM" -print`
