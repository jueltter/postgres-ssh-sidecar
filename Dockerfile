FROM debian:12-slim

RUN apt-get update && apt-get install -y openssh-server postgresql-client && \
    mkdir /var/run/sshd && \
    rm -rf /var/lib/apt/lists/*

COPY .gitlab-ci/container/assemble/entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]

EXPOSE 22

CMD ["/usr/sbin/sshd", "-D"]