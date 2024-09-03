FROM alpine:3.17

RUN apk update && \
	apk upgrade && \
	apk add nginx && \
	apk add openssl && \
	apk add dumb-init

RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
	-keyout /etc/nginx/cert.key -out /etc/nginx/cert.crt \
	-subj "/C=KR/ST=Seoul/L=Seoul/O=42Seoul/CN=euiclee"

COPY conf/nginx.conf /etc/nginx/nginx.conf

EXPOSE 443

ENTRYPOINT [ "/usr/bin/dumb-init", "--", "nginx", "-g", "daemon off;" ]