set -eu

KEYS_SRC=/config/authorized_keys
SSH_DIR=/home/backupuser/.ssh
INCOMING=/home/backupuser/incoming

if [ -d "$KEYS_SRC" ]; then
  echo "ERROR: $KEYS_SRC berupa direktori. Di host jalankan ./scripts/setup-demo.sh lalu: docker compose up -d --force-recreate" >&2
  exit 1
fi
if [ ! -s "$KEYS_SRC" ]; then
  echo "ERROR: $KEYS_SRC tidak ada atau kosong. Di host jalankan ./scripts/setup-demo.sh" >&2
  exit 1
fi

ssh-keygen -A >/dev/null 2>&1
chown backupuser:backupuser /home/backupuser
install -d -m 700 -o backupuser -g backupuser "$SSH_DIR"
install -m 600 -o backupuser -g backupuser "$KEYS_SRC" "$SSH_DIR/authorized_keys"
mkdir -p "$INCOMING"
chown backupuser:backupuser "$INCOMING" 2>/dev/null \
  || echo "PERINGATAN: tidak bisa mengubah owner $INCOMING (cek ownership folder backup-remote di host)" >&2

exec /usr/sbin/sshd -D -e
