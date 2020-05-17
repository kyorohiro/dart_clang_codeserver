import 'dart:js' as js;
import 'dart:typed_data' as typed;

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
}
