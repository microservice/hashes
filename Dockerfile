FROM dlang2/ldc-ubuntu as builder
WORKDIR /src
COPY dub.sdl dub.selections.json /src/
# do a first build without sources to fetch and build all dependencies
RUN dub build -c release
COPY source /src/source
RUN dub build -v --root /src -c release

FROM busybox
COPY --from=builder /src/hashes /hashes
RUN chmod +x /hashes
WORKDIR /src
EXPOSE 8080
ENTRYPOINT [ "/hashes" ]
