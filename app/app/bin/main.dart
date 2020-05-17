import 'dart:ffi' as ffi;
import 'dart:typed_data' as typed;
// dart ./bin/main.dart

ffi.DynamicLibrary dylib = ffi.DynamicLibrary.open('/app/libc/libky.so');

// void print_hello()
typedef PrintHelloFunc = ffi.Pointer<ffi.Void> Function();
typedef PrintHello = ffi.Pointer<ffi.Void> Function();

PrintHello _print_hello = dylib
    .lookup<ffi.NativeFunction<PrintHelloFunc>>('print_hello')
    .asFunction();

void printHello() {
  _print_hello();
}

// int sum_int(a,b)
typedef SumIntFunc = ffi.Int32 Function(ffi.Int32 a, ffi.Int32 b);
typedef SumInt = int Function(int a, int b);
SumInt _sum_int = dylib
      .lookup<ffi.NativeFunction<SumIntFunc>>('sum_int')
      .asFunction<SumInt>();
int sumInt(int a, int b) {
  return _sum_int(a, b);
}

// int sum_double(a,b)
typedef SumDoubleFunc = ffi.Double Function(ffi.Double a, ffi.Double b);
typedef SumDouble = double Function(double a, double b);
SumDouble _sum_double = dylib
      .lookup<ffi.NativeFunction<SumDoubleFunc>>('sum_double')
      .asFunction<SumDouble>();

double sumDouble(double a, double b) {
  return _sum_double(a, b);
}

// char* new_buffer(int size)
typedef NewBufferFunc = ffi.Pointer<ffi.Uint8> Function(ffi.Int32 size);
typedef NewBuffer = ffi.Pointer<ffi.Uint8> Function(int size);
NewBuffer _new_buffer = dylib
      .lookup<ffi.NativeFunction<NewBufferFunc>>('new_buffer')
      .asFunction<NewBuffer>();

ffi.Pointer<ffi.Uint8> newBuffer(int length) {
  return _new_buffer(length);
}

// char* init_buffer(char*, int size)
typedef InitBufferFunc = ffi.Pointer<ffi.Uint8> Function(ffi.Pointer<ffi.Uint8> buffer, ffi.Int32 size);
typedef InitBuffer = ffi.Pointer<ffi.Uint8> Function(ffi.Pointer<ffi.Uint8> buffer, int size);
InitBuffer _init_buffer = dylib
      .lookup<ffi.NativeFunction<InitBufferFunc>>('init_buffer')
      .asFunction<InitBuffer>();

ffi.Pointer<ffi.Uint8> initBuffer(ffi.Pointer<ffi.Uint8> buffer, int length) {
  return _init_buffer(buffer, length);
}

// void destroy_buffer(char* p)
typedef DestroyBufferFunc = ffi.Void Function(ffi.Pointer<ffi.Uint8> buffer);
typedef DestroyBuffer = void Function(ffi.Pointer<ffi.Uint8> buffer);
DestroyBuffer _destroy_buffer = dylib
      .lookup<ffi.NativeFunction<DestroyBufferFunc>>('init_buffer')
      .asFunction<DestroyBuffer>();

void destroyBuffer(ffi.Pointer<ffi.Uint8> buffer) {
  _destroy_buffer(buffer);
}


void main(List<String> args) {
  // hello
  printHello(); // Hello!!
  // int
  print('${sumInt(10, 100)}'); // 110
  // double
  print('${sumDouble(10.1, 100.2)}'); // 110.3
  // pointer and buffer
  var buffer = newBuffer(20);
  // new pointer
  for(var i=0;i<20;i++){
    print(buffer.elementAt(i).value); // random value or 0
  }
  // pointer -> pointer
  buffer = initBuffer(buffer, 20);
  for(var i=0;i<20;i++){
    print(buffer.elementAt(i).value); // 0, 1, 2, 3, 4, ....19
  }
  // pointer -> uint8slist // 0, 1, 2, 3, 4, ....19
  typed.Uint8List bufferAsUint8List =  buffer.asTypedList(20);
  for(var i=0;i<bufferAsUint8List.length;i++){
    print(bufferAsUint8List[i]);
  }
  // set value into buffer 
  bufferAsUint8List[0] = 110;
  print(buffer.elementAt(0).value); // 110
}



