#!/bin/bash

# Функции для логирования
log_info() {
  echo -e "\033[36mℹ️ [$1]\033[0m $2"
}

log_success() {
  echo -e "\033[32m✔ [$1]\033[0m $2"
}

log_error() {
  echo -e "\033[31m✖ [$1]\033[0m $2"
}

# Проверка установленных переменных окружения
if [ -z "$NAMADA_TAG" ] || [ -z "$PROTOBUF_TAG" ] || [ -z "$COMETBFT_TAG" ]; then
  log_error "$(date '+%Y-%m-%dT%H:%M:%S')" "One or more tags are not set. Exiting."
  exit 1
fi

# Функция для установки или обновления компонентов
install_or_update() {
  local name=$1
  local tag=$2
  local url=$3
  local install_fn=$4
  
  log_info "$(date '+%Y-%m-%dT%H:%M:%S')" "Checking installed version of $name..."
  current_version=$($name --version 2>/dev/null | awk '{print $NF}')
  
  if [ "$current_version" == "$tag" ]; then
    log_success "$(date '+%Y-%m-%dT%H:%M:%S')" "$name is already up-to-date ($tag)"
    return
  fi
  
  log_info "$(date '+%Y-%m-%dT%H:%M:%S')" "Downloading $name..."
  if ! curl -L -o "${name}.tar.gz" "$url"; then
    log_error "$(date '+%Y-%m-%dT%H:%M:%S')" "Failed to download $name"
    return
  fi
  
  log_info "$(date '+%Y-%m-%dT%H:%M:%S')" "Installing $name..."
  if ! $install_fn "${name}.tar.gz"; then
    log_error "$(date '+%Y-%m-%dT%H:%M:%S')" "Failed to install $name"
    return
  fi
  
  log_success "$(date '+%Y-%m-%dT%H:%M:%S')" "$name installed successfully ($tag)"
}

# Функции для установки конкретных компонентов
install_namada() {
  tar -xvf $1 -C /usr/local/bin/
}

install_protobuf() {
  unzip -o $1 -d /usr/local/
}

install_cometbft() {
  tar -xvf $1 -C /usr/local/bin/
}

# Установка или обновление компонентов
install_or_update "namada" "$NAMADA_TAG" "https://github.com/anoma/namada/releases/download/$NAMADA_TAG/namada-${NAMADA_TAG}-Linux-x86_64.tar.gz" install_namada

install_or_update "protoc" "$PROTOBUF_TAG" "https://github.com/protocolbuffers/protobuf/releases/download/$PROTOBUF_TAG/protoc-${PROTOBUF_TAG#v}-linux-x86_64.zip" install_protobuf

install_or_update "cometbft" "$COMETBFT_TAG" "https://github.com/cometbft/cometbft/releases/download/$COMETBFT_TAG/cometbft_${COMETBFT_TAG#v}_linux_amd64.tar.gz" install_cometbft

log_info "$(date '+%Y-%m-%dT%H:%M:%S')" "🎉 Installation or update completed!"
