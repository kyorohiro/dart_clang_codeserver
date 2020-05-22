FROM ubuntu:20.04
ENV DEBIAN_FRONTEND noninteractive

# install code-server
WORKDIR /works
RUN apt-get update
RUN apt-get install -y curl
RUN curl -sSOL https://github.com/cdr/code-server/releases/download/v3.3.1/code-server_3.3.1_amd64.deb
RUN dpkg -i code-server_3.3.1_amd64.deb

# install C
WORKDIR /works
RUN apt-get update
RUN apt-get install -y wget gnupg1
RUN apt-get install musl-dev -y
RUN apt-get install build-essential -y
RUN apt-get install cmake -y 
RUN apt-get install python3 -y
RUN apt-get install python3-pip -y
RUN ln -s `which pip3` /usr/bin/pip 
RUN ln -s `which python3` /usr/bin/python 

# install WebAssembly
WORKDIR /works/wasm
RUN apt-get install -y git
RUN git clone https://github.com/emscripten-core/emsdk.git

WORKDIR /works/wasm/emsdk
RUN ./emsdk install latest
RUN ./emsdk activate latest
#RUN source /works/wasm/emsdk/emsdk_env.sh --build=Release
ENV PATH=${PATH}:/works/wasm/emsdk:/works/wasm/emsdk/node/12.9.1_64bit/bin:/works/wasm/emsdk/upstream/emscripten
RUN apt install -y nodejs npm


# install Dart
RUN apt-get update
RUN apt-get install -y wget gnupg1
RUN apt-get install apt-transport-https
RUN sh -c 'wget -qO- https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add -'
RUN sh -c 'wget -qO- https://storage.googleapis.com/download.dartlang.org/linux/debian/dart_stable.list > /etc/apt/sources.list.d/dart_stable.list'
RUN apt-get update
RUN apt-get -y install dart

ENV PATH=${PATH}:/lib/dart/bin
ENV PATH="${PATH}:/root/.pub-cache/bin"

# install vscode plugin
RUN code-server --install-extension Dart-Code.dart-code
RUN code-server --install-extension ms-vscode.cpptools

CMD ["code-server", "--auth","none", "--host","0.0.0.0","--port","8443", "/app"]
