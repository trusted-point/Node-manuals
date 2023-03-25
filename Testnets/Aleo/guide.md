
## SERVER PREPARATION
```bash
apt update
apt install make clang pkg-config libssl-dev build-essential gcc xz-utils git curl vim tmux ntp jq llvm ufw -y
```


```
cd $HOME
git clone https://github.com/AleoHQ/snarkOS.git --depth 1
cd snarkOS
bash ./build_ubuntu.sh
source $HOME/.bashrc
source $HOME/.cargo/env
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
CREATE NEW WALLET
```
```
snarkos account new > wallet.txt && \
PK=$(grep "Private Key" wallet.txt | awk '{print $3}') && \
VK=$(grep "View Key" wallet.txt | awk '{print $3}') && \
ADDRESS=$(grep "Address" wallet.txt | awk '{print $2}') && \
echo "Private Key: $PK" && \
echo "View Key: $VK" && \
echo "Address: $ADDRESS"
```

```python
RECOVER
```
```
PK=<YOUR_PRIVATE_KEY>
VK=<YOUR_VIEW_KEY>
ADDRESS=<YOUR_ADDRESS>
```

```python
TWITT GENERATE
```
```
echo "https://twitter.com/intent/tweet?text=@AleoFaucet%20send%2010%20credits%20to%20$ADDRESS"
# Paste the resulting link into your browser and send a tweet
```

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
echo Paste the Record:  && read REKORD && snarkos developer deploy "$NAME.aleo" \
--private-key "$PK" \
--query "https://vm.aleo.org/api" \
--path "$HOME/leo_deploy/$NAME/build/" \
--broadcast "https://vm.aleo.org/api/testnet3/transaction/broadcast" \
--fee 600000 \
--record "$RECORD"```

