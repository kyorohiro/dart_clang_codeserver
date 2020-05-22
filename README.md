C and Dart 's Code-Server
dart:ffi and dart:js 

# create env

```
$ docker-compose build
$ docker-compose up -d
```

--> http://0.0.0.0:8443/ 

* change 0.0.0.0 to your docker-machine's ip




# build 

on code-server's terminal 

```
$ bash
$ cd libc
$ sh build.sh
$ cd ..
$ dart test/buffer_test.dart
$ webdev serve --hostname=0.0.0.0 web 
..
..
```

