FROM dlang2/ldc-ubuntu as builder
WORKDIR /src
COPY dub.sdl dub.selections.json /src/
RUN mkdir /src/source && echo 'void main(){}' > /src/source/app.d && dub && rm -rf /src/source
COPY source /src/source
RUN dub build -v --root /src -c release

FROM busybox
COPY --from=builder /src/hashes /hashes
RUN chmod +x /hashes
WORKDIR /src
EXPOSE 8080
ENTRYPOINT [ "/hashes" ]
