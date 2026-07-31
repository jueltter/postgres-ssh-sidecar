FROM debian:12-slim

RUN apt-get update && apt-get install -y openssh-server postgresql-client && \
    mkdir /var/run/sshd && \
    rm -rf /var/lib/apt/lists/*

# Add authorized key or password for SSH access
RUN useradd -m -s /bin/bash sdlc-bot && \
    echo 'sdlc-bot:Password1234#' | chpasswd

RUN mkdir /backups \
    && chown sdlc-bot:sdlc-bot /backups \
    && chmod 755 /backups

EXPOSE 22

CMD ["/usr/sbin/sshd", "-D"]