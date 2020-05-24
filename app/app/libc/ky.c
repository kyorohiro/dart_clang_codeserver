#include <stdio.h>
#include <stdlib.h>
#include <string.h>
// [Linux]
// find . -name "*.o" | xargs rm
// gcc -Wall -Werror -fpic -I. -c ky.c -o ky.o 
// gcc -shared -o libky.so ky.o

// [Wasm]
// find . -name "*.o" | xargs rm
// find . -name "*.wasm" | xargs rm
// emcc ky.c -o ky.o 
// emcc ky.o -o libky.js -s EXTRA_EXPORTED_RUNTIME_METHODS='["ccall", "cwrap"]' -s EXPORTED_FUNCTIONS="['_print_hello','_sum_int','_sum_double','_new_buffer','_init_buffer','_destroy_buffer','_new_product','_destroy_product','_init_product','_product_get_name','_product_get_price','_product_get_name_length']"
// cp libky.js ../web/libky.js 
// cp libky.wasm ../web/libky.wasm


void print_hello() {
    printf("Hello!!\n");
}

int sum_int(int a, int b){
    return a + b;
}

double sum_double(double a, double b) {
    return a + b;
}

char* new_buffer(int size) {
    char* ret = malloc(sizeof(char)*size);
    return ret;
}

char* init_buffer(char* buffer, int size) {
    for(int i=0;i<size;i++) {
        buffer[i] = i;
    }
    return buffer;
}

void destroy_buffer(char* p) {
  free(p);
}


//
// object
//
typedef struct {
    char* name;
    int name_length;
    int price;
} Product;

Product* new_product(const char* name, int name_length, int price) {
    Product* context = malloc(sizeof(Product));
    return context;
}

void destroy_product(Product* context) {
    free(context);
}

Product* init_product(Product* context, const char* name, const int name_length, int price) {
    // copy text
    context->name = malloc(sizeof(char)*(name_length+1));
    // +1 is safe guard
    context->name_length = (name_length + 1);
    snprintf(context->name, context->name_length, "%s", name);
    context->price = price;
    return context;
}

char* product_get_name(Product* context) {
    return context->name;
}

int product_get_price(Product* context) {
    return context->price;
}

int product_get_name_length(Product* context) {
    return context->name_length;
}

