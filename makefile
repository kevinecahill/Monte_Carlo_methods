# Compiler & Flags
CC      := gcc
CFLAGS  := -Wall -Wextra -O2
TARGET  := z2
SRC     := z2.c
OBJ     := $(SRC:.c=.o)

# Default target: builds the executable
all: $(TARGET)

# Link the object file to build executable 'z2'
$(TARGET): $(OBJ)
	$(CC) $(CFLAGS) -o $@ $^

# Compile source file into object file
%.o: %.c
	$(CC) $(CFLAGS) -c $< -o $@

# Run the compiled executable
run: $(TARGET)
	./$(TARGET)

# Clean up build artifacts
clean:
	rm -f $(TARGET) $(OBJ)

.PHONY: all run clean