#!/bin/bash

# Логирование
log_info() {
  echo -e "\033[36mℹ️ [$1]\033[0m $2"
}

log_success() {
  echo -e "\033[32m✔ [$1]\033[0m $2"
}

log_error() {
  echo -e "\033[31m✖ [$1]\033[0m $2"
}

install_or_update() {
  local name=$1
  local version=$2
  local url=$3
  local filetype=$4
  local install_fn=$5

  # Проверка на наличие тега
  if [ -z "$version" ]; then
    log_error "$(date '+%Y-%m-%dT%H:%M:%S')" "$name tag is not set. Skipping installation."
    return
  fi

  # Проверка текущей установленной версии
  current_version=$($name --version 2>/dev/null)

  if [ "$current_version" == "$version" ]; then
    log_success "$(date '+%Y-%m-%dT%H:%M:%S')" "$name is up-to-date. Version: $version"
    return
  fi

  # Загрузка
  log_info "$(date '+%Y-%m-%dT%H:%M:%S')" "Downloading $name from $url..."
  curl -L -o "$name.$filetype" "$url"

  # Установка
  log_info "$(date '+%Y-%m-%dT%H:%M:%S')" "Installing $name..."
  $install_fn "$name.$filetype"

  # Проверка успешной установки
  new_version=$($name --version 2>/dev/null)
  if [ "$new_version" == "$version" ]; then
    log_success "$(date '+%Y-%m-%dT%H:%M:%S')" "$name installed successfully. Version: $version"
  else
    log_error "$(date '+%Y-%m-%dT%H:%M:%S')" "Failed to install $name."
  fi
}

# Функции установки для каждого компонента
install_namada_fn() {
  tar -xvf $1 && sudo mv namada-${NAMADA_TAG}-Linux-x86_64/* /usr/local/bin/ && rm -rf namada-${NAMADA_TAG}-Linux-x86_64 $1
}

install_protobuf_fn() {
  unzip -o $1 -d /usr/local/ && rm $1
}

install_cometbft_fn() {
  tar -xvf $1 && sudo mv cometbft /usr/local/bin/ && rm $1
}

# Установка компонентов
[ -n "$NAMADA_TAG" ] && \
  install_or_update "namada" "$NAMADA_TAG" "https://github.com/anoma/namada/releases/download/$NAMADA_TAG/namada-${NAMADA_TAG}-Linux-x86_64.tar.gz" "tar.gz" install_namada_fn

[ -n "$PROTOBUF_TAG" ] && \
  install_or_update "protoc" "$PROTOBUF_TAG" "https://github.com/protocolbuffers/protobuf/releases/download/$PROTOBUF_TAG/protoc-${PROTOBUF_TAG#v}-linux-x86_64.zip" "zip" install_protobuf_fn

[ -n "$COMETBFT_TAG" ] && \
  install_or_update "cometbft" "$COMETBFT_TAG" "https://github.com/cometbft/cometbft/releases/download/$COMETBFT_TAG/cometbft_${COMETBFT_TAG#v}_linux_amd64.tar.gz" "tar.gz" install_cometbft_fn

log_info "$(date '+%Y-%m-%dT%H:%M:%S')" "🎉 Installation or update completed! Check the log file for more details."
