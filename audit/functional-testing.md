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

Tests are conducted on the Ropsten test network. The following contract has been flattened, deployed, and verified on Etherscan.

### Contracts
- [ZippieCardNonce.sol](https://ropsten.etherscan.io/tx/0x97b5546d240333764bb1fcb33823f5e991cef9f9cee8f0f3e97ed3ba16e1298c) 
- [ZippieCard](https://ropsten.etherscan.io/tx/0xe17b6f548015a4c21583dffb8d9b24c5c628f4e5fc86093d28fd28eb658ec5be)
- [ZippieMultisig](https://ropsten.etherscan.io/tx/0x256670d113700e2ddbc398edbfdaa6f88432d92fe42ddd3f2d4305fc3f18b507)
- [ZippieWallet](https://ropsten.etherscan.io/tx/0x5d73c091e79b03b8ca849017b07845bb9061672a31d48ddbb30ed2b98d8a19d8)
- [BLABS Coin](https://ropsten.etherscan.io/address/0x11465b1cd69161b4fe80697e10278228853fc33b) – for testing purpose

### Accounts

* Owner: [0x7123fc4fcfcc0fdba49817736d67d6cfdb43f5b6](https://ropsten.etherscan.io/address/0x7123fc4fcfcc0fdba49817736d67d6cfdb43f5b6)

- "Multisig" account (one of the signers) 
	- address:0x9A7dd0851b69999D62724b1C38A88988D0Fb955D
	- PK: DEEF97D22F51189B1E669A09602F1CAA0C4B4F6102690727289948E2FD0BF9EB

- "Signature Author" account (person who initiate the transfer, sender)
	- address: 0x7123fc4FCFcC0Fdba49817736D67D6CFdb43f5b6
	- private key: EFDFFF42377B32FEC40EF4B9A44077D3BC1F1E7B845E70C51AFD104041852A1E


<br><!-- ********************************************* -->

## Expected behaviour tests


### ZippieCardNonce.sol

##### useNonce(`address signer`, `bytes32 nonce`, `uint8 v`, `bytes32 r`, `bytes32 s`)

-  Anyone with valid signature
	-  [ ] valid signature should be stored
	-  [ ] usedNonce should be rejected
-  Invalid signature
	-  [ ] should be rejected

##### isNonceUsed(`address signer`, `bytes32 nonce`)

-  Existing (stored) signer
	-  [ ] should return false if the nonce exist (was stored)
	-  [ ] should return true if the nonce does not exist (was not stored)
-  Non-existing signer
	-  [ ] should return false in all scenarios

### ZippieWallet.sol

##### redeemCheck( ...*params*... ) public returns (bool)

- [ ] Should transfer if all conditions are satisfied


##### redeemBlankCheck( ...*params*... ) public returns (bool)

- [ ] Should transfer if all conditions are satisfied

## Conclusion


We do not expect any security issues with Multisig contract itself.

