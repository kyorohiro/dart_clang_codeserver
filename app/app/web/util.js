to_uint8list = function(index, len) {
    var v =  new Uint8Array(Module.HEAP8.buffer, index, len);
    return v;
}