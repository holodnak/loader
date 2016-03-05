# Makefile for loader

TARGET = loader.fds
TARGETS = boot.bin intvect.bin intvect2.bin init.bin menu.bin disklist.bin
SOURCES = $(patsubst %.bin,%.s,$(TARGETS))
OBJECTS = $(patsubst %.s,%.o,$(SOURCES))

AS = wla-6502
LD = wlalink

ASFLAGS = v
LDFLAGS = -d 

all: $(TARGET)

$(TARGET): $(OBJECTS) $(TARGETS) diskinfo.txt loading.nam menu.nam chr-lo.bin
	fdstool loader.fds

clean:
	rm -f $(OBJECTS) $(TARGETS) $(TARGET)

.SUFFIXES: .s .o .bin

.s.o:
	$(AS) -$(ASFLAGS)o $< $@

.o.bin:
	@echo "[objects]" > tmp.linkfile
	@echo "$<" >> tmp.linkfile
	$(LD) $(LDFLAGS) tmp.linkfile $@
	@rm -rf tmp.linkfile

.PHONY: all clean
