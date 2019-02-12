# Functional testing

Prepared by:

- Alex Tikonoff, [alex@blockchainlabs.nz](alex@blockchainlabs.nz)

Report:

- February 12, 2019 – date of delivery
- February 12, 2019 – last report update


<br><!-- ********************************************* -->

## Deployment

Tests are conducted on the Ropsten test network. The following contract has been flattened, deployed, and verified on Etherscan.

### Contracts
- [ZippieCardNonce.sol](https://ropsten.etherscan.io/tx/0x97b5546d240333764bb1fcb33823f5e991cef9f9cee8f0f3e97ed3ba16e1298c) 
- [ZippieCard](https://ropsten.etherscan.io/tx/0xe17b6f548015a4c21583dffb8d9b24c5c628f4e5fc86093d28fd28eb658ec5be)
- [ZippieMultisig](https://ropsten.etherscan.io/tx/0x256670d113700e2ddbc398edbfdaa6f88432d92fe42ddd3f2d4305fc3f18b507)
- [ZippieWallet](https://ropsten.etherscan.io/tx/0x5d73c091e79b03b8ca849017b07845bb9061672a31d48ddbb30ed2b98d8a19d8)

### Accounts

* Owner: [0x7123fc4fcfcc0fdba49817736d67d6cfdb43f5b6](https://ropsten.etherscan.io/address/0x7123fc4fcfcc0fdba49817736d67d6cfdb43f5b6)



<br><!-- ********************************************* -->

## Expected behaviour tests

Only public functions were tested.

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

- params:
	- `address[] memory addresses`
	- `address[] memory signers`
	- `uint8[] memory m`
	- `uint8[] memory v`
	- `bytes32[] memory r`, 
	- `bytes32[] memory s`
	- `uint256 amount`
	- `bytes32[] memory cardNonces`

-  asdf
	-  [ ] asdf
