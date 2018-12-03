FROM busybox

ADD hashes /hashes
RUN chmod +x /hashes
WORKDIR /src
EXPOSE 8080
ENTRYPOINT [ "/hashes" ]
