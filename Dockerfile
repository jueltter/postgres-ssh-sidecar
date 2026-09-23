FROM debian:12-slim

RUN apt-get update && apt-get install -y openssh-server postgresql-client && \
    mkdir /var/run/sshd && \
    rm -rf /var/lib/apt/lists/*

# Add user for SSH access
RUN useradd -m -s /bin/bash postgres-ssh

# Set password for the user using a secret
RUN --mount=type=secret,id=postgres_ssh_password \
    POSTGRES_SSH_PASSWORD=$(cat /run/secrets/postgres_ssh_password) \
    && echo 'postgres-ssh:${POSTGRES_SSH_PASSWORD}' | chpasswd

RUN mkdir /backups \
    && chown postgres-ssh:postgres-ssh /backups \
    && chmod 755 /backups

EXPOSE 22

CMD ["/usr/sbin/sshd", "-D"]