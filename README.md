# ubuntu-xenial-iso-builder

# Ubuntu 16.04 Minimal ISO Builder

Script em Bash para automação da criação de uma ISO minimal do Ubuntu 16.04,
com opção de ambientes gráficos leves (XFCE4, i3wm, Openbox).

Projeto educacional focado em aprendizado de Linux e automação.
## Dependências

Para rodar o `build.sh`, instale as dependências:

```bash
sudo apt update
sudo apt install -y debootstrap squashfs-tools xorriso
