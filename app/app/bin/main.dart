import 'dart:ffi' as ffi;
import 'dart:typed_data' as typed;
import 'dart:convert' as conv;
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
      .lookup<ffi.NativeFunction<DestroyBufferFunc>>('destroy_buffer')
      .asFunction<DestroyBuffer>();

void destroyBuffer(ffi.Pointer<ffi.Uint8> buffer) {
  _destroy_buffer(buffer);
}

// ---
// object
// ---

// Product* new_product()
typedef NewProductFunc = ffi.Pointer<ffi.Uint8> Function();
typedef NewProduct = ffi.Pointer<ffi.Uint8> Function();
NewProduct _new_prodhct = dylib
      .lookup<ffi.NativeFunction<NewProductFunc>>('new_product')
      .asFunction<NewProduct>();

ffi.Pointer<ffi.Uint8> newProduct() {
  return _new_prodhct();
}

// void destroy_product(Product*)
typedef DestroyProductFunc = ffi.Void Function(ffi.Pointer<ffi.Uint8> context);
typedef DestroyProduct = void Function(ffi.Pointer<ffi.Uint8> context);
DestroyProduct _destroy_product = dylib
      .lookup<ffi.NativeFunction<DestroyProductFunc>>('destroy_product')
      .asFunction<DestroyProduct>();

void destroyProduct(ffi.Pointer<ffi.Uint8> context) {
  _destroy_product(context);
}

// Product* init_product(Product*, char* name, int price)
typedef InitProductFunc = ffi.Pointer<ffi.Uint8> Function(ffi.Pointer<ffi.Uint8> context, ffi.Pointer<ffi.Uint8> name, ffi.Int32, ffi.Int32 price);
typedef InitProduct = ffi.Pointer<ffi.Uint8> Function(ffi.Pointer<ffi.Uint8> context, ffi.Pointer<ffi.Uint8> name, int nameLength, int price);
InitProduct _init_product = dylib
      .lookup<ffi.NativeFunction<InitProductFunc>>('init_product')
      .asFunction<InitProduct>();

ffi.Pointer<ffi.Uint8> initProduct(ffi.Pointer<ffi.Uint8> context, ffi.Pointer<ffi.Uint8> name, int nameLength, int price) {
  return _init_product(context, name, nameLength, price);
}

// int product_get_price(Product*)
typedef ProductGetPriceFunc = ffi.Int32 Function(ffi.Pointer<ffi.Uint8> context);
typedef ProductGetPrice = int Function(ffi.Pointer<ffi.Uint8> context);
ProductGetPrice _product_get_price = dylib
      .lookup<ffi.NativeFunction<ProductGetPriceFunc>>('product_get_price')
      .asFunction<ProductGetPrice>();

int productGetPrice(ffi.Pointer<ffi.Uint8> context) {
  return _product_get_price(context);
}

// char* product_get_name(Product*)
typedef ProductGetNameFunc = ffi.Pointer<ffi.Uint8> Function(ffi.Pointer<ffi.Uint8> context);
typedef ProductGetName = ffi.Pointer<ffi.Uint8> Function(ffi.Pointer<ffi.Uint8> context);
ProductGetName _product_get_name = dylib
      .lookup<ffi.NativeFunction<ProductGetNameFunc>>('product_get_name')
      .asFunction<ProductGetName>();

ffi.Pointer<ffi.Uint8> productGetName(ffi.Pointer<ffi.Uint8> context) {
  return _product_get_name(context);
}

// int product_get_name_length(Product*)
typedef ProductGetNameLengthFunc = ffi.Int32 Function(ffi.Pointer<ffi.Uint8> context);
typedef ProductGetNameLength = int Function(ffi.Pointer<ffi.Uint8> context);
ProductGetNameLength _product_get_name_length = dylib
      .lookup<ffi.NativeFunction<ProductGetNameLengthFunc>>('product_get_name_length')
      .asFunction<ProductGetNameLength>();

int productGetNameLength(ffi.Pointer<ffi.Uint8> context) {
  return _product_get_name_length(context);
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

  // product
  var name = newBuffer(20);
  typed.Uint8List nameAsUint8List =  name.asTypedList(9);
  nameAsUint8List.setAll(0,conv.ascii.encode("dart book"));
  var context = newProduct();
  initProduct(context, name, 9, 300);
  print("price:${productGetPrice(context)}");
  print("name:${conv.utf8.decode(productGetName(context).asTypedList(productGetNameLength(context)),allowMalformed: true)}");
  destroyProduct(context);
  
}



