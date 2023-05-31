[<img src='https://user-images.githubusercontent.com/80550154/227746770-2d6fa944-cfee-45c4-ab54-9b8853581251.png' alt='banner' width= '99.9%'>]()
#
[<img src='https://user-images.githubusercontent.com/83868103/227937841-6e05b933-9534-49f1-808a-efe087a4f7cd.png' alt='Twitter'  width='16.5%'>](https://twitter.com/intent/user?screen_name=TestnetPride&intent=follow)[<img src='https://user-images.githubusercontent.com/83868103/227935592-ea64badd-ceb4-4945-8dfc-f25c787fb29d.png' alt='TELEGRAM'  width='16.5%'>](https://t.me/TestnetPride)[<img src='https://user-images.githubusercontent.com/83868103/227936236-325bebfd-b287-4206-a964-dcbe67fe7ca8.png' alt='WEBSITE'  width='16.5%'>](http://testnet-pride.com/)[<img src='https://user-images.githubusercontent.com/83868103/227936479-a48e814b-3ec1-4dcb-bd44-96b02d8f55da.png' alt='MAIL'  width='16.5%'>](mailto:official@testnet-pride.com)[<img src='https://user-images.githubusercontent.com/83868103/227932993-b1e3a588-2b91-4915-854a-fa47da3b2cdb.png' alt='LINKEDIN'  width='16.5%'>](https://www.linkedin.com/company/testnet-pride/)[<img src='https://user-images.githubusercontent.com/83868103/227948915-65731f97-c406-4d2c-996c-e5440ff67584.png' alt='GITHUB'  width='16.5%'>](https://github.com/testnet-pride)
___
#### 1. Utwórz nowy portfel Aleo
* Jeśli już masz portfel, możesz go użyć i pominąć krok tworzenia portfela ✅
* Aby utworzyć nowy portfel, przejdź na [stronę internetową](https://aleo.tools/) i kliknij przycisk "Generuj". Zapisz wygenerowane dane w bezpiecznym miejscu 🔒 
##### Po zapisaniu kluczy użyj ich do dodania zmiennych do serwera za pomocą poniższych poleceń
[![Typing SVG](https://readme-typing-svg.herokuapp.com?font=Fira+Code&pause=5000&color=F73515&center=true&width=1000&lines=%E2%9B%94%EF%B8%8F+NIE+PRZEKAZUJ+TYCH+DANYCH+NIKOMU+%E2%9B%94%EF%B8%8F)](https://github.com/testnet-pride)
<img width="1781" alt="image" src="https://user-images.githubusercontent.com/83868103/227736022-1adcf1fd-4cca-4419-a823-8f859518d41e.png">
___


#### 2. Wniosek o tokeny dla Twojego portfela
##### Aby poprosić o tokeny, musisz wysłać wiadomość SMS na numer +1-867-888-5688 zawierającą adres Twojego portfela w następującym formacie: 
**`Wyślij 50 kredytów na adres aleo1hcgx79gqerlj4ad2y2w2ysn3pc38nav69vd2r5lc3hjycfy6xcpse0cag0`**
#
[<img align="left" src='https://user-images.githubusercontent.com/83868103/236622866-d2304783-0ad8-40fc-af63-318675a49ef6.png' alt='PHONE'  width='30%'>]() 


#### 3. Pobierz wymagane paczki i utwórz sesję tmux
```bash
sudo apt update && \
sudo apt install make clang pkg-config libssl-dev build-essential gcc xz-utils git curl vim tmux ntp jq llvm ufw -y && \
tmux new -s deploy
```
##### *Utworzenie sesji tmux jest konieczne do zbudowania pliku binarnego, co zajmuje trochę czasu. Dzięki temu nie będziesz musiał ponownie dodawać zmiennych i budować pliku binarnego, jeśli połączenie SSH z Twoim serwerem zostanie przerwane. Wystarczy ponownie podłączyć się do sesji tmux.*
___
#### 4. Dodaj swój portfel i klucz prywatny jako zmienną. 

```bash
echo Wprowadź swój klucz prywatny: && read PK && \
echo Wprowadź swój klucz widoku: && read VK && \
echo Wprowadź swój adres: && read ADDRESS
```
#### 5. Upewnij się, że dane są poprawne. Jeśli nie, możesz powtórzyć krok 4.
```bash
echo Klucz prywatny: $PK && \
echo Klucz widoku: $VK && \
echo Adres: $ADDRESS
```
#
[<img align="right" src='https://user-images.githubusercontent.com/83868103/236626924-c6544d20-c426-44c7-af36-152dfbd01ddd.png' alt='PHONE'  width='35%'>]() 



##### Po otrzymaniu wiadomości od bota potwierdzającej doładowanie Twojego portfela, przejdź do [strony kranika](https://faucet.aleo.org) i upewnij się, że transakcja została wykonana. 
##### Użyj **ID transakcji** jako odpowiedzi przy użyciu następującego polecenia.

```bash
echo Wprowadź swoje ID transakcji: && read TI
```
```bash
CIPHERTEXT=$(curl -s https://vm.aleo.org/api/testnet3/transaction/$TI | jq -r '.execution.transitions[0].outputs[0].value')
```

___
#### 6. Zainstaluj wymagane oprogramowanie
```bash
cd $HOME
git clone https://github.com/AleoHQ/snarkOS.git --depth 1
cd snarkOS
bash ./
build_ubuntu.sh
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
#### 7. Wdrażaj kontrakt
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
##### Po wykonaniu polecenia powinieneś zobaczyć podobny wynik.
<img width="1403" alt="image" src="https://user-images.githubusercontent.com/83868103/236632069-fee2482e-7e71-41b7-9bbb-42487cdb5ede.png">

##### Użyj otrzymanego skrótu transakcji do wyszukania swojego kontraktu na [eksploratorze](https://explorer.hamp.app)
##### Po wyświetleniu kontraktu w eksploratorze możesz przejść do następnego kroku.

#### 8. Wykonaj kontrakt
##### Użyj skrótu transakcji jako odpowiedzi dla następnego polecenia.
```bash
echo Wprowadź swój skrót wdrożenia: && read DH
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
--fee 1000000 \
--record "$RECORD"
```
##### Po wykonaniu polecenia powinieneś zobaczyć następujący wynik
<img width="1408" alt="image" src="https://user-images.githubusercontent.com/83868103/236633923-9c04521d-c5ef-43b8-8f58-d235a1f1f6df.png">

##### Użyj otrzymanego skrótu transakcji do wyszukania wykonania kontraktu na [eksploratorze](https://explorer.hamp.app)

#### To wszystko!
___
#### 8. Przydatne polecenia

##### Dodaj nową sesję tmux
```
ctrl+b c
```
##### Pokaż wszystkie sesje
```
ctrl+b w
```
##### Odłącz się od sesji tmux
```
ctrl+b d
```
##### Powrót do sesji tmux

```bash
tmux attach -t deploy

___
[<img src='https://user-images.githubusercontent.com/83868103/227937841-6e05b933-9534-49f1-808a-efe087a4f7cd.png' alt='Twitter'  width='16.5%'>](https://twitter.com/intent/user?screen_name=TestnetPride&intent=follow)[<img src='https://user-images.githubusercontent.com/83868103/227935592-ea64badd-ceb4-4945-8dfc-f25c787fb29d.png' alt='TELEGRAM'  width='16.5%'>](https://t.me/TestnetPride)[<img src='https://user-images.githubusercontent.com/83868103/227936236-325bebfd-b287-4206-a964-dcbe67fe7ca8.png' alt='WEBSITE'  width='16.5%'>](http://testnet-pride.com/)[<img src='https://user-images.githubusercontent.com/83868103/227936479-a48e814b-3ec1-4dcb-bd44-96b02d8f55da.png' alt='MAIL'  width='16.5%'>](mailto:official@testnet-pride.com)[<img src='https://user-images.githubusercontent.com/83868103/227932993-b1e3a588-2b91-4915-854a-fa47da3b2cdb.png' alt='LINKEDIN'  width='16.5%'>](https://www.linkedin.com/company/testnet-pride/)[<img src='https://user-images.githubusercontent.com/83868103/227948915-65731f97-c406-4d2c-996c-e5440ff67584.png' alt='GITHUB'  width='16.5%'>](https://github.com/testnet-pride)
___
