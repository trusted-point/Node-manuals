[<img src='https://github.com/trusted-point/Node-manuals/assets/80550154/851e5b62-b3f1-42cd-8509-4129769e1b08' alt='banner' width= '99.9%'>]()
#
[<img src='https://user-images.githubusercontent.com/83868103/227937841-6e05b933-9534-49f1-808a-efe087a4f7cd.png' alt='Twitter'  width='16.5%'>](https://twitter.com/Trusted_Point)[<img src='https://user-images.githubusercontent.com/83868103/227935592-ea64badd-ceb4-4945-8dfc-f25c787fb29d.png' alt='TELEGRAM'  width='16.5%'>](https://t.me/TrustedPointCorp)[<img src='https://user-images.githubusercontent.com/83868103/227936236-325bebfd-b287-4206-a964-dcbe67fe7ca8.png' alt='WEBSITE'  width='16.5%'>](https://trusted-point.com/)[<img src='https://user-images.githubusercontent.com/83868103/227936479-a48e814b-3ec1-4dcb-bd44-96b02d8f55da.png' alt='MAIL'  width='16.5%'>](mailto:official@trusted-point.com)[<img src='https://user-images.githubusercontent.com/83868103/227932993-b1e3a588-2b91-4915-854a-fa47da3b2cdb.png' alt='LINKEDIN'  width='16.5%'>](https://www.linkedin.com/company/trustedpoint)[<img src='https://user-images.githubusercontent.com/83868103/227948915-65731f97-c406-4d2c-996c-e5440ff67584.png' alt='GITHUB'  width='16.5%'>](https://github.com/trusted-point/)
___

## About **Aleo**

* **[Aleo](https://aleo.org/)** introduces fully private applications on the web by leveraging decentralized systems and zero-knowledge cryptography, ensuring absolute privacy for user data.
  
* Aleo's architecture, designed as a blockchain that is private-by-default, open-source, and tailored for the web, addresses the shortcomings of existing blockchains and makes privacy the default standard.

* By empowering users to retain control over their data and enabling providers to offer new experiences without compromising privacy, Aleo reshapes the role of decentralized systems, promising truly personalized web experiences while safeguarding user privacy.

**<font size = 4>[Website](https://aleo.org/) | [GitHub](https://github.com/AleoHQ) | [Twitter](https://twitter.com/AleoHQ) | [Discord](https://discord.gg/aleo) | [Docs](https://developer.aleo.org/leo/) | [Whitepaper](https://eprint.iacr.org/2021/651.pdf) | [Blog](https://aleo.org/blog/)</font>**


## `Server requirements`

> Client Node requirements
```GO
OS: Ubuntu 20.04
Memory: 16 GB RAM
CPU: 16 cores
Disk: 64 GB SSD Storage
Bandwidth: 100 Mbps
```
## Firewall settings
| Port | Protocol | Purpose |
| --- | --- | --- |
| 4133 | TCP | SnarkOS peers |
| 3033 | TCP | SnarkOS REST API |
---
## 1. `Prepare your server`

### Update and install required packages
```bash
sudo apt update && sudo apt upgrade -y && \
sudo apt install build-essential curl clang gcc libssl-dev llvm make pkg-config tmux xz-utils
```
## 2. `Create a user`
```bash
sudo adduser snarkosadm --disabled-password
```
## 3. `Install Rust`
```bash
sudo -i -u snarkosadm
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
source ${HOME}/.cargo/env
```
## 4. `Make sure Rust has been installed`
```bash
cargo --version
rustc --version
```
## 5. `Clone snarkOS repository`
```bash
git clone https://github.com/AleoHQ/snarkOS.git
```
## 6. `Build snarkos bin`
```bash
cd $HOME/snarkOS
cargo build --release
mkdir $HOME/bin
cp -$HOME/snarkOS/target/release/snarkos $HOME/bin/
echo 'export PATH="$HOME/bin:$PATH"' >> ~/.bash_profile
source ~/.bash_profile
```
## 6. `Make sure the binary is working`
```bash
snarkos --help
```
## 7. `Create a service file`
```bash
sudo tee /etc/systemd/system/aleo-node.service > /dev/null <<EOF
[Unit]
Description=Aleo Node
After=network.target
Wants=network-online.target
StartLimitIntervalSec=500
StartLimitBurst=5

[Service]
User=$USER
Type=simple
ExecStart=$(which snarkos) start --nodisplay --logfile /dev/null --verbosity 4 --client
Restart=on-failure
LimitNOFILE=65535
WorkingDirectory=/home/snarkosadm
ExecStop=/bin/kill -s INT ${MAINPID}
RestartSec=5s
Restart=always

[Install]
WantedBy=multi-user.target
EOF
```

## 7. `Start the node`
```bash
sudo systemctl daemon-reload
sudo systemctl start aleo-node
```
## 7. `Check logs`
```bash
sudo journalctl -feu aleo-node -o cat
```
# In case of new snarkOS version update with the following commands:
## 1. Update repo
```bash
sudo -i -u snarkosadm
cd snarkOS
git pull
```
## 2. Build the binary
```bash
cargo build --release
cp $HOME/snarkosadm/snarkOS/target/release/snarkos /usr/local/bin/
```
## 3. Resatrt the node
```bash
sudo systemctl restart aleo-node
sudo systemctl status aleo-node
```
## 4. `Check logs`
```bash
sudo journalctl -feu aleo-node -o cat
```
# API Queries example
## 1. Query current valdiator set 
```bash
curl -s localhost:3033/testnet3/peers/all/metrics | jq -r '.[] | select(.[1] == "Validator") | .[0]' | sed 's/4133/5000/g'
```

## 2. Compare height between Aleo explorer and your node
```bash
echo -e "Aleo explorer: $(curl -s https://api.explorer.aleo.org/v1/testnet3/latest/height)\nYour node: $(curl -s localhost:3033/testnet3/latest/height)"
```

## More calls can be found [here](https://developer.aleo.org/testnet/public_endpoints/latest_height)

# Delete the node
```bash
sudo systemctl stop aleo-node && \
sudo systemctl disable aleo-node; \
sudo rm /etc/systemd/system/aleo-node.service; \
sudo systemctl daemon-reload && \
cd $HOME && \
rm -rf $HOME/snarkOS $HOME/storage; \
sudo rm $(which snarkos)
```
