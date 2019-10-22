set disassembly-flavor intel

# C++ specific
catch throw
set print asm-demangle on

# from https://gcc.gnu.org/onlinedocs/libstdc++/manual/debug.html#debug.gdb
set print pretty on
set print object on
set print static-members on
set print vtbl on
set print demangle on
set demangle-style gnu-v3

# for reverse engineering: the stack should start at the same address as when
# simply calling the binary directly
# https://stackoverflow.com/questions/32771657/gdb-showing-different-address-than-in-code
set exec-wrapper env -u LINES -u COLUMNS
