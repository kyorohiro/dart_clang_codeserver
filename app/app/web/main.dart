import 'dart:js' as js;

// webdev serve --hostname=0.0.0.0
js.JsObject Module = js.context['Module'];
js.JsFunction _print_hello =  Module.callMethod('cwrap',['print_hello','',[]]);

void printHello() {
  _print_hello.apply([]);
}

void main() {  
  printHello();
}
