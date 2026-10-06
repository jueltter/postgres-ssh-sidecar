FROM debian:12-slim

RUN apt-get update && apt-get install -y openssh-server postgresql-client && \
    mkdir /var/run/sshd && \
    rm -rf /var/lib/apt/lists/*

COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod 755 /usr/local/bin/entrypoint.sh

EXPOSE 22

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]