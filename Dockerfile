FROM alpine:edge
RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.tuna.tsinghua.edu.cn/g' /etc/apk/repositories
RUN apk add -X https://mirrors.tuna.tsinghua.edu.cn/alpine/edge/main -u alpine-keys --allow-untrusted
RUN apk update && apk add build-base
COPY nsenter.c ./
RUN cc -Wall -static nsenter.c -o /usr/bin/nsenter

FROM scratch
COPY --from=0 /usr/bin/nsenter /usr/bin/nsenter
ENTRYPOINT ["/usr/bin/nsenter"]
