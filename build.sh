#!/bin/bash
echo "Ubuntu 16.04 ISO Builder - em desenvolvimento"
set -e
if [[ $EUID -ne 0 ]]; then
  echo "Execute como root."
  exit 1
fi
# =========================
# Configurações principais
# =========================
RELEASE="xenial"
ARCH="amd64"
WORKDIR="$PWD/workdir"
CHROOT="$WORKDIR/chroot"
mkdir -p "$CHROOT"
DEPS=(debootstrap squashfs-tools xorriso)

for dep in "${DEPS[@]}"; do
  if ! command -v $dep &>/dev/null; then
    echo "Dependência ausente: $dep"
    exit 1
  fi
done

# =========================
# Menu
# =========================
echo "Escolha o ambiente gráfico:"
echo "1) XFCE4"
echo "2) i3wm"
echo "3) Openbox"
read -p "Opção: " WM
echo "Opção selecionada: $WM"
echo "Em desenvolvimento..."
