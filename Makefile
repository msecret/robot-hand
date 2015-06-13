#$ avr-gcc -Os -DF_CPU=16000000UL -mmcu=atmega328p -c -o led.o led.c
#$ avr-gcc -mmcu=atmega328p led.o -o led
#$ avr-objcopy -O ihex -R .eeprom led led.hex
#$ avrdude -F -V -c arduino -p ATMEGA328P -P /dev/ttyACM0 -b 115200 -U flash:w:led.hex

CC = avr-gcc
OBJCOPY = avr-objcopy
TARGET = main

OBJDIR := build
#VPATH := src


ARDUINO_DIR = /usr/share/arduino
F_CPU = 16000000
MCU ?= atmega328p
PORT ?= /dev/ttyACM0
UPLOAD_RATE ?= 115200

AVRDUDE_PROGRAMMER = arduino
AVRDUDE_PORT = $(PORT)
AVRDUDE_WRITE_FLASH = -U flash:w:$^
AVRDUDE_FLAGS = -F -p $(MCU) -P $(AVRDUDE_PORT) -c $(AVRDUDE_PROGRAMMER) -b $(UPLOAD_RATE)


all: $(OBJDIR)/$(TARGET)
	$(OBJCOPY) -O ihex -R .eeprom $^ $@

upload: $(OBJDIR)/$(TARGET).hex
	avrdude $(AVRDUDE_FLAGS) $(AVRDUDE_WRITE_FLASH)

$(OBJDIR)/$(TARGET).hex: $(OBJDIR)/$(TARGET)
	$(OBJCOPY) -O ihex -R .eeprom $^ $@

$(OBJDIR)/$(TARGET): $(OBJDIR)/$(TARGET).o
	$(CC) -mmcu=$(MCU) $^ -o $@

$(OBJDIR)/$(TARGET).o: src/$(TARGET).c
	$(CC) -Os -DF_CPU=$(F_CPU) -mmcu=$(MCU) -c -o $@ $^

src/$(TARGET).c: | $(OBJDIR)

$(OBJDIR):
	mkdir -p $@

clean:
	-rm -r build/*
	rm -rf `find . -name "*.dSYM" -print`
