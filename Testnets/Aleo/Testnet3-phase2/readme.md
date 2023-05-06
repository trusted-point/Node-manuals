[<img src='https://user-images.githubusercontent.com/80550154/227746770-2d6fa944-cfee-45c4-ab54-9b8853581251.png' alt='banner' width= '99.9%'>]()
#
[<img src='https://user-images.githubusercontent.com/83868103/227937841-6e05b933-9534-49f1-808a-efe087a4f7cd.png' alt='Twitter'  width='16.5%'>](https://twitter.com/intent/user?screen_name=TestnetPride&intent=follow)[<img src='https://user-images.githubusercontent.com/83868103/227935592-ea64badd-ceb4-4945-8dfc-f25c787fb29d.png' alt='TELEGRAM'  width='16.5%'>](https://t.me/TestnetPride)[<img src='https://user-images.githubusercontent.com/83868103/227936236-325bebfd-b287-4206-a964-dcbe67fe7ca8.png' alt='WEBSITE'  width='16.5%'>](http://testnet-pride.com/)[<img src='https://user-images.githubusercontent.com/83868103/227936479-a48e814b-3ec1-4dcb-bd44-96b02d8f55da.png' alt='MAIL'  width='16.5%'>](mailto:official@testnet-pride.com)[<img src='https://user-images.githubusercontent.com/83868103/227932993-b1e3a588-2b91-4915-854a-fa47da3b2cdb.png' alt='LINKEDIN'  width='16.5%'>](https://www.linkedin.com/company/testnet-pride/)[<img src='https://user-images.githubusercontent.com/83868103/227948915-65731f97-c406-4d2c-996c-e5440ff67584.png' alt='GITHUB'  width='16.5%'>](https://github.com/testnet-pride)
___
#### 1. Create a new Aleo wallet
* If you already have a wallet, you can use it and skip the wallet creation step ✅
* To create a new wallet, go to the [website](https://aleo.tools/) and click the "Generate" button. Save the output in a safe place 🔒 
##### After saving the keys, use them to add variables to your server using the commands below
[![Typing SVG](https://readme-typing-svg.herokuapp.com?font=Fira+Code&pause=5000&color=F73515&center=true&width=1000&lines=%E2%9B%94%EF%B8%8F+DO+NOT+GIVE+THIS+DATA+TO+ANYONE+%E2%9B%94%EF%B8%8F)](https://github.com/testnet-pride)
<img width="1781" alt="image" src="https://user-images.githubusercontent.com/83868103/227736022-1adcf1fd-4cca-4419-a823-8f859518d41e.png">
___


#### 2. Request tokens for your wallet
##### To request tokens, you will need to send an SMS to the number +1-867-888-5688 with your wallet address in the following format: 
**`Send 50 credits to aleo1hcgx79gqerlj4ad2y2w2ysn3pc38nav69vd2r5lc3hjycfy6xcpse0cag0`**
#
[<img align="left" src='https://user-images.githubusercontent.com/83868103/236622866-d2304783-0ad8-40fc-af63-318675a49ef6.png' alt='PHONE'  width='30%'>]() 


#### 3. Download required packages and create a tmux session
```bash
sudo apt update && \
sudo apt install make clang pkg-config libssl-dev build-essential gcc xz-utils git curl vim tmux ntp jq llvm ufw -y && \
tmux new -s deploy
```
##### *P.S. Creating a tmux session is required to build a binary, which takes some time. So you won't need to add variables and build a binary again if the ssh connection to your server lost. Just reconnect to the tmux session.*
___
#### 4. Add your wallet and private key as a variable. 

```bash
echo Enter your Private Key: && read PK && \
echo Enter your View Key: && read VK && \
echo Enter your Address: && read ADDRESS
```
#### 5. Make sure the data is correct. If not, you can do step 4 again.
```bash
echo Private Key: $PK && \
echo View Key: $VK && \
echo Address: $ADDRESS
```
#
[<img align="right" src='https://user-images.githubusercontent.com/83868103/236626924-c6544d20-c426-44c7-af36-152dfbd01ddd.png' alt='PHONE'  width='35%'>]() 



##### After receiving a message from the bot about the successful replenishment of your wallet, you need to go to the faucet [website](https://faucet.aleo.org) and make sure that the transaction has been executed. 
##### Use the **Transaction ID** as the answer when using the following command.

```bash
echo Enter your Transaction ID: && read TI
```
```bash
CIPHERTEXT=$(curl -s https://vm.aleo.org/api/testnet3/transaction/$TI | jq -r '.execution.transitions[0].outputs[0].value')
```

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
NAME=helloworld_"${ADDRESS:4:6}"
mkdir $HOME/leo_deploy
cd $HOME/leo_deploy
leo new $NAME
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
--fee 4000000 \
--record "$RECORD"
```
##### After executing the command, you should see a similar result.
<img width="1403" alt="image" src="https://user-images.githubusercontent.com/83868103/236632069-fee2482e-7e71-41b7-9bbb-42487cdb5ede.png">

##### Use the received transaction hash to search for your contract on the [explore](https://explorer.hamp.app)
##### After your contract is displayed in the explorer, you can proceed to the next step.

#### 8. Execute a contract
##### Use the transaction hash as the answer for the following command.
```bash
echo Enter your Deploy hash: && read DH
```
```bash
CIPHERTEXT=$(curl -s https://vm.aleo.org/api/testnet3/transaction/$DH | jq -r '.fee.transition.outputs[].value')
```
```bash
RECORD=$(snarkos developer decrypt --ciphertext $CIPHERTEXT --view-key $VK)
```
```bash
snarkos developer execute "$NAME.aleo" "hello" "1u32" "2u32" \
--private-key $PK \
--query "https://vm.aleo.org/api" \
--broadcast "https://vm.aleo.org/api/testnet3/transaction/broadcast" \
--fee 1000000 
--record "$RECORD"
```
##### After execution, you should see the following output 
<img width="1408" alt="image" src="https://user-images.githubusercontent.com/83868103/236633923-9c04521d-c5ef-43b8-8f58-d235a1f1f6df.png">

##### Use the received transaction hash to search for your contract execute on the [explore](https://explorer.hamp.app)

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
[<img src='https://user-images.githubusercontent.com/83868103/227937841-6e05b933-9534-49f1-808a-efe087a4f7cd.png' alt='Twitter'  width='16.5%'>](https://twitter.com/intent/user?screen_name=TestnetPride&intent=follow)[<img src='https://user-images.githubusercontent.com/83868103/227935592-ea64badd-ceb4-4945-8dfc-f25c787fb29d.png' alt='TELEGRAM'  width='16.5%'>](https://t.me/TestnetPride)[<img src='https://user-images.githubusercontent.com/83868103/227936236-325bebfd-b287-4206-a964-dcbe67fe7ca8.png' alt='WEBSITE'  width='16.5%'>](http://testnet-pride.com/)[<img src='https://user-images.githubusercontent.com/83868103/227936479-a48e814b-3ec1-4dcb-bd44-96b02d8f55da.png' alt='MAIL'  width='16.5%'>](mailto:official@testnet-pride.com)[<img src='https://user-images.githubusercontent.com/83868103/227932993-b1e3a588-2b91-4915-854a-fa47da3b2cdb.png' alt='LINKEDIN'  width='16.5%'>](https://www.linkedin.com/company/testnet-pride/)[<img src='https://user-images.githubusercontent.com/83868103/227948915-65731f97-c406-4d2c-996c-e5440ff67584.png' alt='GITHUB'  width='16.5%'>](https://github.com/testnet-pride)
___
