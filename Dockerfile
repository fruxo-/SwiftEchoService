FROM swift:5.5-amazonlinux2 as builder
WORKDIR /root
RUN git clone https://github.com/fruxo-/SwiftEchoService.git
WORKDIR /root/SwiftEchoService
RUN swift build -c release --product SwiftEchoServer

FROM swift:5.5-amazonlinux2 as runner
WORKDIR /root
RUN mkdir SwiftEchoService
COPY --from=builder /root/SwiftEchoService ./SwiftEchoService
EXPOSE 8888
WORKDIR /root/SwiftEchoService/.build/release/
ENTRYPOINT ./SwiftEchoServer -i 0.0.0.0 -p 8888 > /var/log/echo.svc.log
