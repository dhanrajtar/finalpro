FROM ubuntu:latest
ENV TZ=UTC
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y tzdata && \
    rm -rf /var/lib/apt/lists/*
RUN apt-get update && apt-get install -y sudo
COPY my-script.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/my-script.sh
RUN /usr/local/bin/my-script.sh
RUN rm -f /etc/nginx/sites-available/default
COPY default /etc/nginx/sites-available/
RUN sudo chmod -R 777 /var/www/html
COPY info.php /var/www/html/
EXPOSE 80
CMD service php8.1-fpm start && nginx -g "daemon off;"
