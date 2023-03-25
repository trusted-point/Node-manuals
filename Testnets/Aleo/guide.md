
если не хочется тратить время, сгенереровать кошелек https://aleo.tools/ и перейти к пункту восстановления кошелька + отправить твитт, а после заняться установкой (переписать порядок выполнения)
<img width="1781" alt="image" src="https://user-images.githubusercontent.com/83868103/227736022-1adcf1fd-4cca-4419-a823-8f859518d41e.png">




```python
RECOVER
```
```
echo Enter your Private Key:: && read PK && \
echo Enter your View Key: && read VK && \
echo Enter your Address: && read ADDRESS

PK=<YOUR_PRIVATE_KEY>
VK=<YOUR_VIEW_KEY>
ADDRESS=<YOUR_ADDRESS>
```
```
echo $PK && \
echo $VK && \
echo $ADDRESS
```

```python
TWITT GENERATE
```
```
echo "https://twitter.com/intent/tweet?text=@AleoFaucet%20send%2010%20credits%20to%20$ADDRESS"
# Paste the resulting link into your browser and send a tweet
```

## SERVER PREPARATION
```python
UPDATE AND INSTALL PACKAGES
```
```bash
apt update
apt install make clang pkg-config libssl-dev build-essential gcc xz-utils git curl vim tmux ntp jq llvm ufw -y
```

```python
SNARKOS INSTALL
```
```
cd $HOME
git clone https://github.com/AleoHQ/snarkOS.git --depth 1
cd snarkOS
bash ./build_ubuntu.sh
source $HOME/.bashrc
source $HOME/.cargo/env
```
```python
LEO INSTALL
```
```
cd $HOME
git clone https://github.com/AleoHQ/leo.git
cd leo
cargo install --path .
```

## DEPLOY
```
NAME=<ANY_NAME>
```
```
cd $HOME && mkdir leo_deploy && cd leo_deploy
leo new $NAME
```

```python
# CREATE NEW WALLET
```
```
# snarkos account new > wallet.txt && \
# PK=$(grep "Private Key" wallet.txt | awk '{print $3}') && \
# VK=$(grep "View Key" wallet.txt | awk '{print $3}') && \
# ADDRESS=$(grep "Address" wallet.txt | awk '{print $2}') && \
# cd $HOME && \
# echo "Private Key: $PK" && \
# echo "View Key: $VK" && \
# echo "Address: $ADDRESS" 
```
сохранить вывод

```python
TWITT GENERATE
```
```
echo "https://twitter.com/intent/tweet?text=@AleoFaucet%20send%2010%20credits%20to%20$ADDRESS"
# Paste the resulting link into your browser and send a tweet
```

<img width="554" alt="image" src="https://user-images.githubusercontent.com/83868103/227732721-b1132f6e-85de-4cf4-9d96-a388add3f423.png">
<img width="811" alt="image" src="https://user-images.githubusercontent.com/83868103/227732737-e03fbbc5-4296-4980-9d3d-14b2229b0f19.png">


```python
SEARCH
```
```
echo Paste the link: && read QUOTE_LINK && \
CIPHERTEXT=$(curl -s $QUOTE_LINK | jq -r '.execution.transitions[0].outputs[0].value')
```


```
RECORD=$(snarkos developer decrypt --ciphertext $CIPHERTEXT --view-key $VK)
```


```python
DEPLOY
```

```
snarkos developer deploy "$NAME.aleo" \
--private-key "$PK" \
--query "https://vm.aleo.org/api" \
--path "$HOME/leo_deploy/$NAME/build/" \
--broadcast "https://vm.aleo.org/api/testnet3/transaction/broadcast" \
--fee 600000 \
--record "$RECORD"
```

