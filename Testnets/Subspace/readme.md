**Subspace Network** позволяет разработчикам запускать приложения **Web3** в масштабах Интернета. Он предоставляет простой интерфейс для быстрого развертывания децентрализованных приложений с несколькими цепочками, которые автоматически масштабируются по мере необходимости. **Subspace** работает на основе нового экологически чистого **блокчейна 4-го поколения**, который обеспечивает масштабируемое хранение и вычисления в сети без ущерба для безопасности или децентрализации. Он легко интегрируется с существующими **блокчейнами**, протоколами второго уровня и децентрализованными приложениями, что позволяет ему служить базовым уровнем инфраструктуры для всей экосистемы **Web3**. **Subspace** позволит разработчикам открыть следующую волну внедрения криптографии, поддерживая **NFT, GameFi и Metaverse** в масштабах Интернета.

+ Проект предлагает не стандартную систему консенсуса, а именно **Proof-of-Archive-Storage (POAS).**

+ **Инвесторы:** Pantera Capital. Coinbase Ventures, Crypto.com, Alameda Research, ConsenSys Mesh.
#
⎜[**Discord**](https://discord.com/invite/K56A6xrdw9) ⎜ [**Twitter**](https://twitter.com/NetworkSubspace) ⎜ [**Website**](https://subspace.network) ⎜ [**Explorer**](https://polkadot.js.org/apps/?rpc=wss%3A%2F%2Feu-0.gemini-3c.subspace.network%2Fws#/explorer) ⎜ [**Telemetry**](https://telemetry.subspace.network/) ⎜
___

### `Server requirements:`
```python
CPU: 2 
RAM: 2GB 
SSD/NVME: 150GB
```
#
### `Server preparation:`
```bash
# Distribution update
sudo apt-get update && sudo apt-get upgrade -y 
```
```bash
# Installing required packages
sudo apt-get install wget jq ocl-icd-opencl-dev \
libopencl-clang-dev libgomp1 ocl-icd-libopencl1 -y
```
___
### `Node install:`
```bash
TAG=$(wget -qO- https://api.github.com/repos/subspace/subspace-cli/releases | jq '.[] | select(.prerelease==false) | select(.draft==false) | .html_url' | grep -Eo "v[0-9]*.[0-9]*.[0-9]*" | head -n 1) && \
wget https://github.com/subspace/subspace-cli/releases/download/$TAG/subspace-cli-ubuntu-x86_64-v3-$TAG -qO subspace && \
sudo chmod 777 subspace && \
sudo mv subspace /usr/local/bin/ && \
subspace -V
```

**Make sure the version matches the [release](https://github.com/subspace/subspace-cli/releases)** is ⎧<img src='https://user-images.githubusercontent.com/83868103/228858929-859e6479-e1e9-465f-9f92-73a6bc437207.png' alt='latest'  height=25 >⎫



