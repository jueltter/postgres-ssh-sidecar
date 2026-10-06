#!/bin/sh
set -eu

POSTGRES_SSH_USER="${POSTGRES_SSH_USER:-postgres-ssh}"

if [ -z "${POSTGRES_SSH_PASSWORD:-}" ]; then
    echo "POSTGRES_SSH_PASSWORD must be set" >&2
    exit 1
fi

if ! id "$POSTGRES_SSH_USER" >/dev/null 2>&1; then
    useradd -m -s /bin/bash "$POSTGRES_SSH_USER"
fi

printf '%s:%s\n' "$POSTGRES_SSH_USER" "$POSTGRES_SSH_PASSWORD" | chpasswd

mkdir -p /backups
chown "$POSTGRES_SSH_USER:$POSTGRES_SSH_USER" /backups
chmod 755 /backups

echo "User $POSTGRES_SSH_USER configured successfully."

exec "$@"