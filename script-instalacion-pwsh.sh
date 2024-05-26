#!/bin/sh

# nos descargamos el paquete .deb con Pwsh del repositorio oficial de GitHub,lo instalamos y
# nos deshacemos del paquete comprimidoo
wget "https://github.com/PowerShell/PowerShell/releases/download/v7.4.2/powershell_7.4.2-1.deb_amd64.deb"

# instalar Pwsh a partir del paquete, esto genera problemas de dependencias
dpkg --install powershell_7.4.2-1.deb_amd64.deb

# arreglar los problemas de dependencias
apt install --fix-broken -y

rm powershell_7.4.2-1.deb_amd64.deb
