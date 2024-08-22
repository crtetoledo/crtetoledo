#!/bin/bash

# Atualiza a lista de pacotes
sudo apt-get update

# Verifica se o Google Chrome está instalado
if dpkg -l | grep google-chrome-stable; then
    # Obtém a versão instalada
    installed_version=$(google-chrome --version | awk '{print $3}')
    
    # Obtém a versão disponível no repositório
    available_version=$(apt-cache policy google-chrome-stable | grep Candidate | awk '{print $2}')
    
    echo "Versão instalada: $installed_version"
    echo "Versão disponível: $available_version"
    
    # Compara as versões
    if dpkg --compare-versions "$installed_version" "lt" "$available_version"; then
        echo "Atualizando o Google Chrome para a versão mais recente..."
        sudo apt-get install --only-upgrade -y google-chrome-stable
    else
        echo "O Google Chrome já está na versão mais recente."
    fi
else
    echo "Google Chrome não está instalado. Instalando agora..."
    # Instala o Google Chrome se não estiver instalado
    sudo apt-get install -y wget apt-transport-https ca-certificates
    wget -q -O - https://dl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
    sudo sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list'
    sudo apt-get update
    sudo apt-get install -y google-chrome-stable
fi
