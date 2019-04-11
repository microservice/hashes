FROM dlang2/ldc-ubuntu:1.14.0 as builder
WORKDIR /src
COPY dub.sdl dub.selections.json /src/
# do a first build without sources to fetch and build all dependencies
RUN dub build -b release || true
COPY source /src/source
RUN dub build -b release

FROM scratch
COPY --from=builder /src/hashes /hashes
ENTRYPOINT [ "/hashes" ]
