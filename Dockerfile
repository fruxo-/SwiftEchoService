FROM swift:latest

WORKDIR /root
RUN git clone https://github.com/fruxo-/SwiftEchoService.git
WORKDIR SwiftEchoService
CMD swift build
CMD swift build --product SwiftEchoServer
EXPOSE 8888
ENTRYPOINT swift run SwiftEchoServer -i 0.0.0.0 -p 8888
