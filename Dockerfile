FROM wordpress:latest

# Install vim
RUN apt-get update && \
    apt-get install -y vim

# Copy php.ini into image
COPY php.ini /usr/local/etc/php/