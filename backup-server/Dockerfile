FROM alpine:3.20

# Akun backupuser: diberi password acak (bukan terkunci) karena sshd Alpine menolak
# login akun yang terkunci ("!") walau memakai public key. Login password tetap
# dimatikan lewat sshd_config di bawah, jadi password ini tidak bisa dipakai.
RUN apk add --no-cache openssh-server \
 && adduser -D -s /bin/sh backupuser \
 && echo "backupuser:$(cat /proc/sys/kernel/random/uuid)" | chpasswd \
 && mkdir -p /home/backupuser/.ssh /home/backupuser/incoming \
 && chown -R backupuser:backupuser /home/backupuser \
 && chmod 700 /home/backupuser/.ssh \
 && printf '%s\n' \
      'PasswordAuthentication no' \
      'KbdInteractiveAuthentication no' \
      'PubkeyAuthentication yes' \
      'PermitRootLogin no' \
      'AllowUsers backupuser' \
      'AllowTcpForwarding no' \
      'X11Forwarding no' \
    >> /etc/ssh/sshd_config

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
EXPOSE 22
ENTRYPOINT ["/entrypoint.sh"]
