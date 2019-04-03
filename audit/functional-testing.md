# Functional testing

Prepared by:

- Alex Tikonoff, [alex@blockchainlabs.nz](alex@blockchainlabs.nz)

Report:

- February 15, 2019 – date of delivery
- February 15, 2019 – last report update


<br><!-- ********************************************* -->

## Scope

Only public functions of Multisig contracts are the scope of this audit.<br>
The other components of application are out of scope.

<br><!-- ********************************************* -->

## Deployment

Tests are conducted on the Ropsten test network. The following contracts have been flattened, deployed, and verified on Etherscan.

### Contracts
- [ZippieCardNonce.sol](https://ropsten.etherscan.io/tx/0x97b5546d240333764bb1fcb33823f5e991cef9f9cee8f0f3e97ed3ba16e1298c) 
- [ZippieCard](https://ropsten.etherscan.io/tx/0xe17b6f548015a4c21583dffb8d9b24c5c628f4e5fc86093d28fd28eb658ec5be)
- [ZippieMultisig](https://ropsten.etherscan.io/tx/0x256670d113700e2ddbc398edbfdaa6f88432d92fe42ddd3f2d4305fc3f18b507)
- [ZippieWallet](https://ropsten.etherscan.io/tx/0x5d73c091e79b03b8ca849017b07845bb9061672a31d48ddbb30ed2b98d8a19d8)
- [BLABS Coin](https://ropsten.etherscan.io/address/0x11465b1cd69161b4fe80697e10278228853fc33b) – for testing purpose

### Accounts

- "Multisig" account (one of the signers) 
	- address:0x9A7dd0851b69999D62724b1C38A88988D0Fb955D
	- Private Key: DEEF97D22F51189B1E669A09602F1CAA0C4B4F6102690727289948E2FD0BF9EB

- "Multisig 2" account (one of the signers) 
	- address: 0xd6498DF7Bc8b5DB4aC11FC284F2F5173abF61D67
	- Private Key: E73A51303B5330BEB14839019804B50992478F74E7163042ED65365DC606FAEB

- "Sender" account (also signer, person who initiate the transfer)
	- address: 0x7123fc4FCFcC0Fdba49817736D67D6CFdb43f5b6
	- private key: EFDFFF42377B32FEC40EF4B9A44077D3BC1F1E7B845E70C51AFD104041852A1E

- "Card nonces" (from the test's hardcoded values):
	- 0x40B4eC8EC80b485118816FF998Ce4E54c88aBD20

- [BLABS token](https://ropsten.etherscan.io/address/0x11465b1cd69161b4fe80697e10278228853fc33b) ([repo](https://github.com/BlockchainLabsNZ/blabs-coin))

		In order to get sign transactions, one should send tokens to Multisig 
		account and approve (ERC20 function) the ZippieWallet contract address for the future spending.


<br><!-- ********************************************* -->

## Expected behaviour tests



### ZippieWallet.sol

##### redeemBlankCheck( ...*params*... ) public returns (bool)

This test has a requirement of `one` signer, and `zero` required cards. We transferred tokens to "multisig" and `approve`d the ZippieWallet contract to `transferFrom` these tokens.

We used some of the javascript functions in `test/HelpFunctions.js` to sign the transactions using our own account which is where the `v`, `r`, `s` values come from.

To perform the test we called `redeemBlankCheck()` with the following params:

```
- `addresses`: [
	- "0x9A7dd0851b69999D62724b1C38A88988D0Fb955D",        (*Multisig*)
	- "0x11465b1cd69161b4fe80697e10278228853fc33b",        (*Blabs token*)
	- "0x0000000210198695da702d62b08B0444F2233F9C",        (*Recipient*)
	- "0xC1D7Bd24bf47D12a3a518984B296afC6d0d941aC" ]       (*Verification key (random account)*)
- `signers`:  
	- [ "0x7123fc4FCFcC0Fdba49817736D67D6CFdb43f5b6" ]     (*Sender/Signer*)
- `m`: [ 1, 1, 0, 0 ]					       (*1 possible signer, 1 required signer, 0 possible cards, 0 required cards*)
- `v`: [ 27, 28, 27 ]
- `r`: [ 
	- "0x6d30fc07f763a6228060c963d75260d9b66bdc17791a4656fa6a393dad08a7da", 
	- "0xeffb3c8826c3619f4fc96d69280b1f1816eb4aa3ecf744d9eea2f9dfd877ebc4",   
	- 0xdfaed6d5162a7147b867c300447dda654ab83308517bbe50c2608c1405bec6a0" ]
- `s`: [ 
	- "0x3f75ca4007b2229838db4a023f04b0e087faebf7356f4738bbe4946abb0327f1", 
	- "0x1c7c6427964509e375b8da3c386222860583f93edbee32db3de788795c3739f6", 
	- "0x2b1e7b64a170cd9a1b65cabd24f577f034a73a2f39ffa0ace04492766f23b790" ]
- `amount`: 1000000000000000000				       (*1 Token (18 decimals)*)
- cardNonces: []
```

###### Test results

- [x] Transfer should succeed if one signature is required and given (the sender himself, no cards, no other signatures) [0xc3dc9f](https://ropsten.etherscan.io/tx/0xc3dc9ff27e422a38371ef991959afb14bb05e14f0514e0113c273d3ca4106aa9)
- [x] Transfer failed if two signatures required and one given, no card nonces provided [0x72e5c8](https://ropsten.etherscan.io/tx/0x72e5c8f670ab5c4fe9ef47487e3ceeff7ccb84cacdbb9c8457f52107660c8e9e)
- [] Transfer succeed if two signatures required and one given (the sender himself + card nonces provided) [0x000000]()
- [] Transfer succeed if two signatures required and two given (the sender himself + one other signature) [0x000000]()


### ZippieCardNonce.sol

##### useNonce(`address signer`, `bytes32 nonce`, `uint8 v`, `bytes32 r`, `bytes32 s`)

-  Anyone with valid signature
	-  [ ] valid signature should be stored
	-  [ ] usedNonce should be rejected
-  Invalid signature
	-  [ ] should be rejected

##### isNonceUsed(`address signer`, `bytes32 nonce`)

-  Existing (stored) signer
	-  [ ] should return false if the nonce exists (was stored)
	-  [ ] should return true if the nonce does not exist (was not stored)
-  Non-existing signer
	-  [ ] should return false in all scenarios

	
<br><!-- ********************************************* -->
	
## Conclusion


We do not expect any security issues with Multisig contract itself.



