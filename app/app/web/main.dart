import 'dart:js' as js;
import 'dart:typed_data' as typed;
import 'dart:convert' as conv;

// webdev serve --hostname=0.0.0.0
js.JsObject Module = js.context['Module'];
var HEAP8 = Module['HEAP8'];
//HEAP8.buffer

js.JsFunction _print_hello =  Module.callMethod('cwrap',['print_hello','',[]]);

void printHello() {
  _print_hello.apply([]);
}

js.JsFunction _sum_int =  Module.callMethod('cwrap',['sum_int','number',['number', 'number']]);
int sumInt(int a, int b) {
  return _sum_int.apply([a, b]);
}

js.JsFunction _sum_double =  Module.callMethod('cwrap',['sum_double','number',['number', 'number']]);
double sumDouble(double a, double b) {
  return _sum_double.apply([a, b]);
}

js.JsFunction _new_buffer =  Module.callMethod('cwrap',['new_buffer','number',['number']]);
int newBuffer(int length) {
  return _new_buffer.apply([length]);
}

js.JsFunction _init_buffer =  Module.callMethod('cwrap',['init_buffer','number',['number','number']]);
int initBuffer(int buffer, int length) {
  return _init_buffer.apply([buffer, length]);
}

js.JsFunction _destroy_buffer =  Module.callMethod('cwrap',['destroy_buffer','void',['number']]);
int destroyBuffer(int buffer) {
  return _destroy_buffer.apply([buffer]);
}

js.JsFunction _to_uint8list= js.context['to_uint8list'];// from util.js
typed.Uint8List toUint8List(int buffer, int length) {
  return _to_uint8list.apply([buffer, length]);
}

// ---
// object
// ---
js.JsFunction _new_product =  Module.callMethod('cwrap',['new_product','number',[]]);
int newProduct() {
  return _new_product.apply([]);
}

js.JsFunction _init_product =  Module.callMethod('cwrap',['init_product','number',['number','number','number','number']]);
int initProduct(int context, int name, int nameLength, int price) {
  return _init_product.apply([context, name, nameLength, price]);
}

js.JsFunction _destroy_product =  Module.callMethod('cwrap',['destroy_product','void',['number']]);
int destroyProduct(int context) {
  return _destroy_product.apply([context]);
}

js.JsFunction _prodcut_get_name =  Module.callMethod('cwrap',['product_get_name','number',['number']]);
int productGetName(int context) {
  return _prodcut_get_name.apply([context]);
}

js.JsFunction _prodcut_get_price =  Module.callMethod('cwrap',['product_get_price','number',['number']]);
int productGetPrice(int context) {
  return _prodcut_get_price.apply([context]);
}

void main() {  
  // hello
  printHello(); // Hello!!
  // int
  print('${sumInt(10, 100)}'); // 110
  // double
  print('${sumDouble(10.1, 100.2)}'); // 110.3
  //
  // new pointer
  var buffer = newBuffer(20);
  
  for(var i=0;i<20;i++){
    print('${HEAP8[i+buffer]}'); // random value or 0
  }
  // pointer -> pointer
  buffer = initBuffer(buffer, 20);
  
  for(var i=0;i<20;i++){
    print('${HEAP8[i+buffer]}'); // random value or 0
  }
  // pointer -> uint8slist // 0, 1, 2, 3, 4, ....19
  
  typed.Uint8List bufferAsUint8List = toUint8List(buffer, 20);
  for(var i=0;i<bufferAsUint8List.length;i++){
    print(bufferAsUint8List[i]);
  }
  // set value into buffer 
  bufferAsUint8List[0] = 110;
  print('${HEAP8[buffer]}'); // 110

  print("${HEAP8.runtimeType}");//
  typed.Uint8List bufferAsUint8List2 = (HEAP8 as typed.Int8List).buffer.asUint8List(buffer, 20);
  for(var i=0;i<bufferAsUint8List2.length;i++){
    print(bufferAsUint8List2[i]);
  }

  // product
  var name = newBuffer(20);
  typed.Uint8List nameAsUint8List =   (HEAP8 as typed.Int8List).buffer.asUint8List(name, 20);
  nameAsUint8List.setAll(0, conv.ascii.encode("dart book"));
  var context = newProduct();
  initProduct(context, name, 9, 300);
  print("price:${productGetPrice(context)}");
  var nameAsString = (HEAP8 as typed.Int8List).buffer.asUint8List(productGetName(context), 9);
  print("name:${conv.utf8.decode(nameAsString,allowMalformed: true)}");
  destroyProduct(context);

}
