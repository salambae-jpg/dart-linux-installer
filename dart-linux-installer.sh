#!/bin/bash

RED='\033[31m'
GREEN='\033[32m'
YELLOW='\033[33m'
BLUE='\033[34m'
MAGENTA='\033[35m'
CYAN='\033[36m'
RESET='\033[0m'

clear
echo "Memulai instalasi Dart pada Linux Ubuntu"
echo -e "${CYAN}https://github.com/salambae-jpg/dart-linux-installer${RESET}"
echo " "

echo -e "[1/5] Menginstal dependensi apt-transport-https..."
sudo apt-get update -y >/dev/null 2>&1
sudo apt-get install -y apt-transport-https curl >/dev/null 2>&1
echo -e "[ ${GREEN}OK${RESET} ] Menginstal dependensi apt-transport-https"

echo -e "[2/5] Menambahkan kunci GPG untuk Dart..."
curl -s https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo gpg --dearmor -o /usr/share/keyrings/dart.gpg -y >/dev/null 2>&1
echo -e "[ ${GREEN}OK${RESET} ] Menambahkan kunci GPG untuk Dart"

echo "[3/5] Menambahkan repository Dart ke sistem..."
echo "deb [signed-by=/usr/share/keyrings/dart.gpg] https://storage.googleapis.com/download.dartlang.org/linux/debian stable main" | sudo tee /etc/apt/sources.list.d/dart_stable.list >/dev/null 2>&1
echo -e "[ ${GREEN}OK${RESET} ] Menambahkan repository Dart ke sistem..."

echo "[4/5] Memperbarui daftar paket..."
sudo apt-get update -y >/dev/null 2>&1
echo -e "[ ${GREEN}OK${RESET} ] Memperbarui daftar paket..."

echo "[5/5] Menginstal Dart..."
sudo apt-get install -y dart >/dev/null 2>&1
echo -e "[ ${GREEN}OK${RESET} ] Menginstal Dart"

if ! grep -q "/usr/lib/dart/bin" ~/.bashrc; then
  echo "Menambahkan Dart ke PATH..."
  echo 'export PATH="$PATH:/usr/lib/dart/bin"' >> ~/.bashrc
  source ~/.bashrc >/dev/null 2>&1
fi

echo -e "${YELLOW}Verifikasi instalasi Dart...${RESET}"
 
if [ $? -eq 0 ]; then
  if dart --version >/dev/null 2>&1; then
    echo -e "${GREEN}Dart berhasil diinstal!${RESET}"
  else
    echo "Terjadi masalah selama instalasi Dart."
  fi
else
  echo "Terjadi masalah selama instalasi Dart."
fi