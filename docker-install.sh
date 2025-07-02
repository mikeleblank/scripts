#!/bin/bash
# install_docker.sh
# Instalador Docker // Docker Compose Ubuntu CT
# -----------------------------------------

echo -e "\n🔍 Actualizando el sistema..."
sleep 1
sudo apt-get update && sudo apt-get upgrade -y

echo -e "\n📦 Instalando dependencias necesarias (ca-certificates, curl)..."
sleep 1
sudo apt-get install -y ca-certificates curl

echo -e "\n📁 Creando directorio para llaves GPG..."
sleep 1
sudo install -m 0755 -d /etc/apt/keyrings

echo -e "\n🔑 Descargando y agregando la llave oficial de Docker..."
sleep 1
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

echo -e "\n📝 Agregando repositorio oficial de Docker al sources.list..."
sleep 1
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

echo -e "\n🔄 Actualizando índice de paquetes con el nuevo repositorio..."
sleep 1
sudo apt-get update

echo -e "\n🐳 Instalando Docker Engine, CLI, containerd, buildx y docker-compose..."
sleep 1
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin docker-compose

echo -e "\n✅ Docker ha sido instalado correctamente."

echo -e "\n⚙️ Habilitando e iniciando el servicio Docker..."
sudo systemctl enable docker
sudo systemctl start docker

echo -e "\n🚀 Verificando instalación..."
docker --version
docker compose version

echo -e "\n🎉 Todo listo para usar Docker en tu CT Proxmox 🚀"
