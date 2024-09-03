FROM alpine:3.17

WORKDIR /var/www/html

RUN apk update && \
    apk upgrade && \
    apk add curl bash mysql-client php81 php81-fpm php81-mysqli php81-xml php81-gd php81-intl php81-iconv php81-phar dumb-init

RUN curl -s -L https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar --output /usr/local/bin/wp && \
    chmod +x /usr/local/bin/wp && \
    curl https://raw.githubusercontent.com/vishnubob/wait-for-it/master/wait-for-it.sh > /usr/local/bin/wait-for-it.sh && \
    chmod +x /usr/local/bin/wait-for-it.sh

RUN addgroup -g 81 -S www-data;     exit 0
RUN adduser -u 81 -D -S -G www-data www-data

COPY conf/www.conf /etc/php81/php-fpm.d/www.conf
COPY tools/wordpress.sh /usr/local/bin/wordpress.sh

RUN chmod +x /usr/local/bin/wordpress.sh && \
    chown -R www-data:www-data /var/www/html && \
    chmod -R 755 /var/www/html

EXPOSE 9000

ENTRYPOINT ["/usr/bin/dumb-init", "--", "/usr/local/bin/wordpress.sh"]
