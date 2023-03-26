[<img src='https://user-images.githubusercontent.com/80550154/227746770-2d6fa944-cfee-45c4-ab54-9b8853581251.png' alt='banner' width= '99.9%'>]()
___
#### 1. Create a new Aleo wallet
* If you already have a wallet, you can use its details and skip the wallet creation step ✅
* To create a new wallet, go to the [website](https://aleo.tools/) and click the "Generate" button. Save the data in a safe place 🔒 
##### After saving the data, use it to add variables to your server using the commands below
[![Typing SVG](https://readme-typing-svg.herokuapp.com?font=Fira+Code&pause=5000&color=F73515&center=true&width=1000&lines=%E2%9B%94%EF%B8%8F+DO+NOT+GIVE+THIS+DATA+TO+ANYONE+%E2%9B%94%EF%B8%8F)](https://git.io/typing-svg)
<img width="1781" alt="image" src="https://user-images.githubusercontent.com/83868103/227736022-1adcf1fd-4cca-4419-a823-8f859518d41e.png">
___
#### 2. Download required packages and create a tmux session
```bash
apt update && \
apt install make clang pkg-config libssl-dev build-essential gcc xz-utils git curl vim tmux ntp jq llvm ufw -y && \
tmux new -s deploy
```
##### *P.S. Creating a tmux session is required to build a binary, which takes some time. So you won't need to add variables and build a binary again if the you lost ssh connection to your server. Just reconnect to the tmux session.*
___
#### 3. Add your wallet and private key as a variable. 

```bash
echo Enter your Private Key: && read PK && \
echo Enter your View Key: && read VK && \
echo Enter your Address: && read ADDRESS
```
#### 4. Make sure the data is correct. If not, you can do step 3 again.
```bash
echo Private Key: $PK && \
echo View Key: $VK && \
echo Address: $ADDRESS
```
___
#### 5. Generate a tweet with your wallet to get tokens
``` bash
echo "https://twitter.com/intent/tweet?text=@AleoFaucet%20send%2010%20credits%20to%20$ADDRESS"
```
##### *P.S. You need to past the output of the command above into your browser and publish a tweet and wait for the response form a bot. It will take about 30-40 minutes. The bot will send you a link which you will need to use in the step 7.*

#### **Do not wait for the response. Feel free to do the next step (6) in the meantime**
<img width= 43% alt=image src=https://user-images.githubusercontent.com/80550154/227748074-45a0004b-e131-4f58-9469-0591797c025d.png> <img width="43%" alt="image" src=https://user-images.githubusercontent.com/80550154/227748072-161f0fe6-21db-412e-be3b-e8d5707ad64f.png>

___
#### 6. Install required software
```bash
cd $HOME
git clone https://github.com/AleoHQ/snarkOS.git --depth 1
cd snarkOS
bash ./build_ubuntu.sh
source $HOME/.bashrc
source $HOME/.cargo/env
```

```bash
cd $HOME
git clone https://github.com/AleoHQ/leo.git
cd leo
cargo install --path .
```
___
#### 7. Deploy a contract
```bash
echo Enter the Name of your contract "(any)": && read NAME
```
```bash
cd $HOME && mkdir leo_deploy && cd leo_deploy
leo new $NAME
```
##### *P.S In the command below past the link which you got from a bot on twitter at [the previous step](https://github.com/testnet-pride/Node-manuals/blob/main/Testnets/Aleo/guide.md#5-generate-a-tweet-with-your-wallet-to-get-tokens).*
```bash
echo Paste the link: && read QUOTE_LINK && \
CIPHERTEXT=$(curl -s $QUOTE_LINK | jq -r '.execution.transitions[0].outputs[0].value')
```

```bash
RECORD=$(snarkos developer decrypt --ciphertext $CIPHERTEXT --view-key $VK)
```
```bash
snarkos developer deploy "$NAME.aleo" \
--private-key "$PK" \
--query "https://vm.aleo.org/api" \
--path "$HOME/leo_deploy/$NAME/build/" \
--broadcast "https://vm.aleo.org/api/testnet3/transaction/broadcast" \
--fee 600000 \
--record "$RECORD"
```
#### That is it!
___
#### 8. Useful commands

##### Add a new tmux session
```
ctrl+b c
```
##### Show all sessions
```
ctrl+b w
```
##### Detach from tmux session
```
ctrl+b d
```
##### Return to a tmux session

```bash
tmux attach -t deploy
```
___
[<img src='https://user-images.githubusercontent.com/83868103/227769602-9a61b516-5586-4294-8ef5-aafe52ee5831.svg' alt='twitter'  width='4.5%'>](https://twitter.com/TestnetPride) [![Typing SVG](https://readme-typing-svg.demolab.com?font=Ubuntu&pause=10000&vCenter=true&repeat=true&width=155&height=30&lines=%E2%8E%9CTwitter)](https://twitter.com/TestnetPride) [<img src='https://user-images.githubusercontent.com/83868103/227769829-5761979b-3e99-442e-b1ea-54b869f77595.svg' alt='Telegram'  width='4%'>](https://t.me/TestnetPride) [![Typing SVG](https://readme-typing-svg.demolab.com?font=Ubuntu&pause=10000&vCenter=true&repeat=true&width=155&height=30&lines=%E2%8E%9CTelegram)](https://t.me/TestnetPride) [<img src='https://user-images.githubusercontent.com/83868103/227774752-c01fbe7a-3df9-4f44-8204-9770458a9f9e.png' alt='Website'  width='5%'>](http://testnet-pride.com/) [![Typing SVG](https://readme-typing-svg.demolab.com?font=Ubuntu&pause=10000&color=DAAB26&vCenter=true&repeat=true&width=185&height=30&lines=%E2%8E%9COfficial-web)](http://testnet-pride.com/) [<img src='https://user-images.githubusercontent.com/83868103/227773008-2446770f-c328-4b99-b50f-f2d2998ce917.png' alt='Mail'  width='5%'>](mailto:official@testnet-pride.com) [![Typing SVG](https://readme-typing-svg.demolab.com?font=Ubuntu&pause=10000&vCenter=true&repeat=true&width=280&height=35&lines=%E2%8E%9Cofficial@testnet-pride.com)](mailto:official@testnet-pride.com)
___
