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
DEPS=(debootstrap mksquashfs xorriso)


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

bootstrap_base() {
  echo "Iniciando debootstrap do Ubuntu $RELEASE..."
  debootstrap \
    --arch="$ARCH" \
    "$RELEASE" \
    "$CHROOT" \
    http://archive.ubuntu.com/ubuntu

  echo "Debootstrap concluído."
}
prepare_chroot() {
  echo "Preparando chroot..."
  mount --bind /dev "$CHROOT/dev"
  mount --bind /dev/pts "$CHROOT/dev/pts"
  mount -t proc proc "$CHROOT/proc"
  mount -t sysfs sys "$CHROOT/sys"
  cp /etc/resolv.conf "$CHROOT/etc/resolv.conf"
  echo "Chroot preparado."
}
prepare_chroot() {
  mount --bind /dev "$CHROOT/dev"
  mount --bind /dev/pts "$CHROOT/dev/pts"
  mount -t proc proc "$CHROOT/proc"
  mount -t sysfs sys "$CHROOT/sys"
  cp /etc/resolv.conf "$CHROOT/etc/resolv.conf"
}
enter_chroot() {
  echo "Entrando no chroot..."
  chroot "$CHROOT" /bin/bash
  echo "Saindo do chroot..."
}
install_desktop() {
    echo "Instalando interface gráfica..."
    
    # Atualiza apt e garante universe
    chroot "$CHROOT" /bin/bash -c "apt update && apt install -y software-properties-common"
    chroot "$CHROOT" /bin/bash -c "add-apt-repository universe -y && apt update"
    
    case "$WM" in
        1)
            echo "Instalando XFCE4..."
            chroot "$CHROOT" /bin/bash -c "apt install -y xfce4 lightdm"
            ;;
        2)
            echo "Instalando i3wm..."
            chroot "$CHROOT" /bin/bash -c "apt install -y i3 xorg lightdm"
            ;;
        3)
            echo "Instalando Openbox..."
            chroot "$CHROOT" /bin/bash -c "apt install -y openbox obconf xorg lightdm"
            ;;
        *)
            echo "Opção inválida. Nenhuma interface será instalada."
            ;;
    esac

    echo "Instalação concluída."
}
