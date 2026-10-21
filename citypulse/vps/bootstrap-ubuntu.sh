#!/usr/bin/env bash
# Prepare a fresh Ubuntu 24.04 VPS for CityPulse Global.
# Does not deploy the application or open database ports.
set -euo pipefail
if [[ ${EUID} -ne 0 ]]; then echo "Run as root: sudo bash citypulse/vps/bootstrap-ubuntu.sh" >&2; exit 1; fi
. /etc/os-release
if [[ "${ID}" != "ubuntu" || "${VERSION_ID}" != "24.04" ]]; then
  echo "Requires Ubuntu 24.04 LTS; detected ${PRETTY_NAME:-unknown}" >&2; exit 1
fi
export DEBIAN_FRONTEND=noninteractive
apt-get update
apt-get install -y ca-certificates curl gnupg ufw git openssl
install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
chmod a+r /etc/apt/keyrings/docker.asc
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu ${VERSION_CODENAME} stable" > /etc/apt/sources.list.d/docker.list
apt-get update
apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
systemctl enable --now docker
# Preserve SSH access. Do not automatically enable a firewall before confirming SSH port.
install -d -m 0750 /opt/citypulse
docker compose version
echo "Docker installed. Next: configure SSH/firewall, secrets, TLS, backups and staging deployment."
