
import 'dart:ffi' as ffi;

typedef PrintHelloFunc = ffi.Pointer<ffi.Void> Function();
typedef PrintHello = ffi.Pointer<ffi.Void> Function();

ffi.DynamicLibrary dylib = ffi.DynamicLibrary.open('/app/libc/libky.so');
PrintHello _print_hello = dylib
    .lookup<ffi.NativeFunction<PrintHelloFunc>>('print_hello')
    .asFunction();

void printHello() {
  _print_hello();
}

main(List<String> args) {
  printHello();
}

