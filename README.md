C and Dart 's Code-Server
dart:ffi and dart:js 

# preperation

Get code-server-3.0.0-linux-x86_64.tar.gz from https://github.com/cdr/code-server/releases/download/3.0.0/code-server-3.0.0-linux-x86_64.tar.gz  And copy to app/build_resource/code-server-3.0.0-linux-x86_64.tar.gz


[ref]
https://github.com/cdr/code-server/releases


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

