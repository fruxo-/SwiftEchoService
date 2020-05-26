FROM swift:latest

WORKDIR /root
RUN git clone https://github.com/fruxo-/SwiftEchoService.git
WORKDIR SwiftEchoService
RUN swift build --product SwiftEchoServer
EXPOSE 8888
WORKDIR /root/SwiftEchoService/.build/x86_64-unknown-linux-gnu/debug
ENTRYPOINT ./SwiftEchoServer -i 0.0.0.0 -p 8888 > /var/log/echo.svc.log
