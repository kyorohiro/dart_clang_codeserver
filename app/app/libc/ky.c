#include <stdio.h>

// [Linux]
// find . -name "*.o" | xargs rm
// gcc -Wall -Werror -fpic -I. -c ky.c -o ky.o 
// gcc -shared -o libky.so ky.o

// [Wasm]
// find . -name "*.o" | xargs rm
// find . -name "*.wasm" | xargs rm
// emcc ky.c -o ky.o 
// emcc ky.o -o libky.js -s EXTRA_EXPORTED_RUNTIME_METHODS='["ccall", "cwrap"]' -s EXPORTED_FUNCTIONS="['_print_hello']"
// cp libky.js ../web/libky.js 
// cp libky.wasm ../web/libky.wasm
void print_hello() {
    printf("Hello!!\n");
}


