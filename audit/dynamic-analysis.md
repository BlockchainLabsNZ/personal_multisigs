# Zippie Personal Multisigs Dynamic Testing

Prepared by:

- Alex Tikonoff, [alex@blockchainlabs.nz](alex@blockchainlabs.nz)
- Matt Lough, [matt@blockchainlabs.nz](matt@blockchainlabs.nz)

Report:

- February 12, 2019 – date of delivery
- February 12, 2019 – last report update

<br><!-- ********************************************* -->

## Setup and running tests

1. Installation<br>Download repo this repo, branch **audit**, run terminal, cd to the project, run: `yarn install`

2. Running tests<br>Run in terminal: "yarn test"

3. Running test coverage report<br>Run in terminal: `yarn run coverage`





<br>

## Testing results

```
Compiling ./contracts/Migrations.sol...
Compiling ./contracts/Test/BasicERC20Mock.sol...
Compiling ./contracts/Test/BasicERC20MockOwner.sol...
Compiling ./contracts/Test/TestFunctions.sol...
Compiling ./contracts/Zippie/IZippieCardNonces.sol...
Compiling ./contracts/Zippie/ZippieCard.sol...
Compiling ./contracts/Zippie/ZippieCardNonces.sol...
Compiling ./contracts/Zippie/ZippieMultisig.sol...
Compiling ./contracts/Zippie/ZippieUtils.sol...
Compiling ./contracts/Zippie/ZippieWallet.sol...
Compiling ./contracts/Zippie/ZippieWalletBasic.sol...
Compiling openzeppelin-solidity/contracts/math/SafeMath.sol...
Compiling openzeppelin-solidity/contracts/token/ERC20/ERC20.sol...
Compiling openzeppelin-solidity/contracts/token/ERC20/ERC20Detailed.sol...
Compiling openzeppelin-solidity/contracts/token/ERC20/IERC20.sol...


  Contract: Test Zippie Multisig Balance or Allowance Too Low
    ✓ should not allow a blank check to be cashed from a 1 of 1 multisig (with 2FA) if multisig lacks allowance to cover amount (1744ms)
    ✓ should not allow a blank check to be cashed from a 1 of 1 multisig (with 2FA) if multisig lacks balance to cover amount (822ms)

  Contract: Test Zippie Multisig Check Cashing Functionality
    ✓ should allow a blank check to be cashed once from a 1 of 1 multisig, and fail the second time (889ms)
    ✓ should allow a blank check to be cashed from a 2 of 2 multisig (684ms)

  Contract: Test Zippie Multisig Check Cashing With Cards Functionality
    ✓ should allow a blank check to be cashed once from a 1 of 1 multisig with 2FA, and fail the second time (950ms)
    ✓ should allow a blank check to be cashed when using two cards (720ms)
    ✓ should set limit to 5 ether (850ms)
    ✓ should allow to decrease limit without card signatures
    ✓ should not allow to increase limit without card signatures
    ✓ should allow to increase limit with card signatures
    ✓ should allow a blank check to be cashed once from a 1 of 1 multisig with 2FA, without checking 2FA because under account limit (1124ms)
    ✓ should prevent a blank check to be cashed once from a 1 of 1 multisig with 2FA, when amount is over account limit but card signatures is incorrect (899ms)
    ✓ should prevent a blank check to be cashed once from a 1 of 1 multisig with 2FA, when amount is over account limit but card signatures is missing (683ms)
    ✓ should allow a blank check to be cashed once from a 1 of 1 multisig with 2FA, although amount is over account limit (1023ms)

  Contract: Test Zippie Multisig Check Cashing With Cards Error Cases
    ✓ should fail a blank check transfer (from a 1 of 1 multisig with 2FA) if nonce is signed by incorrect card (627ms)
    ✓ should fail a blank check transfer (from a 1 of 1 multisig with 2FA) if incorrect card (463ms)
    ✓ should fail a blank check transfer (from a 2 of 2 multisig with 2FA) if nonce is signed by incorrect card (643ms)
    ✓ should fail a blank check transfer (from a 2 of 2 multisig with 2FA) if incorrect card (371ms)
    ✓ should fail a blank check transfer (1 signer, 1 card) if card nonce is being reused (1829ms)
    ✓ should fail a blank check transfer (1 signer, 2 cards) if card nonce is reused (1165ms)
    ✓ should fail a blank check transfer (1 signer, 2 cards) if duplicated card is used (638ms)

  Contract: Test Zippie Multisig Check Cashing Error Cases
    ✓ should fail a blank check transfer (from a 1 of 1 multisig) if incorrect signer (1057ms)
    ✓ should fail a blank check transfer (from a 1 of 1 multisig) if data is signed by incorrect signer (674ms)
    ✓ should fail a blank check transfer (from a 2 of 2 multisig) if 1 incorrect signer (442ms)
    ✓ should fail a blank check transfer (from a 2 of 2 multisig) if data is signed by incorrect signer (543ms)
    ✓ should fail a blank check transfer (from a 2 of 2 multisig) if signers are the same (600ms)
    ✓ should fail a blank check transfer when the verificationKey is wrong (820ms)

  Contract: Zippie Multisig Gas Simulator
GENERAL FUNCTION, 1 : 1 multisig (blank check)

Gas usage when first using the multisig (blank check)
---------------------------------------
131072 gas was used.
Gas usage on subsequent use of the multisig (blank check)
---------------------------------------
114688 gas was used.
    ✓ should run a 1of1 multisig (blank check) through the general function (672ms)
GENERAL FUNCTION, 2 : 2 multisig (blank check)

Gas usage when first using the multisig (blank check)
---------------------------------------
131072 gas was used.
Gas usage on subsequent use of the multisig (blank check)
---------------------------------------
147456 gas was used.
    ✓ should run a 2of2 multisig (blank check) through the general function (779ms)


  29 passing (35s)

--------------------------|----------|----------|----------|----------|----------------|
File                      |  % Stmts | % Branch |  % Funcs |  % Lines |Uncovered Lines |
--------------------------|----------|----------|----------|----------|----------------|
 Test/                    |       75 |      100 |       75 |       75 |                |
  BasicERC20Mock.sol      |      100 |      100 |      100 |      100 |                |
  BasicERC20MockOwner.sol |      100 |      100 |      100 |      100 |                |
  TestFunctions.sol       |    66.67 |      100 |    66.67 |    66.67 |          13,17 |
 Zippie/                  |    68.53 |    45.45 |    72.22 |    68.97 |                |
  IZippieCardNonces.sol   |      100 |      100 |      100 |      100 |                |
  ZippieCard.sol          |      100 |    61.54 |      100 |      100 |                |
  ZippieCardNonces.sol    |       80 |       75 |       50 |       80 |             28 |
  ZippieMultisig.sol      |      100 |    64.29 |      100 |      100 |                |
  ZippieUtils.sol         |      100 |       75 |      100 |      100 |                |
  ZippieWallet.sol        |    78.33 |       50 |    83.33 |    78.33 |... 132,144,148 |
  ZippieWalletBasic.sol   |        0 |        0 |        0 |        0 |... 261,265,269 |
--------------------------|----------|----------|----------|----------|----------------|
All files                 |    68.87 |    45.45 |    73.08 |    69.28 |                |
--------------------------|----------|----------|----------|----------|----------------|

```


<br><!-- ********************************************* -->

## What is not covered

#### ZippieWalletBasic.sol
- No tests at all

#### ZippieCardNonces.sol 
- [isNonceUsed()](https://github.com/BlockchainLabsNZ/zippie-multisig-2/blob/3943cc4f77a5b6b3c71c0c7a1c9162f0ea140b97/contracts/Zippie/ZippieCardNonces.sol#L20)

#### ZippieWallet.sol

- [redeemCheck()](https://github.com/BlockchainLabsNZ/zippie-multisig-2/blob/3943cc4f77a5b6b3c71c0c7a1c9162f0ea140b97/contracts/Zippie/ZippieWallet.sol#L49)

### Conclusion

- Not all lines of code are covered by tests.
- Not all possible branches (logic) are covered by tests.

We can not say if all possible scenarios are covered because there are no scenarios described.
We recommended to describe all scenarios and cover all code completely, up to 100%, including branches (logic/possible scenarios). 



<br><!-- ********************************************* -->

## Tests analysis

We did not evaluate the contracts logic covered by tests because of complete lack test cases descriptions.
All findings are related to the code of the tests itself.

### Common code

- Params correctness by Solidity modifiers or `require()` functions
	- [x] `multisigAndERC20Contract` should be length of 2
	- [ ] `multisigAndERC20Contract[0]` is a multisig wallet address
	- [ ] `multisigAndERC20Contract[1]` is an ERC20 contract address
	- [x] `m` (number of signatures required) should be greater than 0
	- [x] `m` should be less (OR NOT EQUAL?) than 255
	- [x] `m` should be less than the number of `allSignersPossible`
	- [x] `nonce` was not used already
	- [ ] `amount` should be greater than 0
	- [ ] `recipient` address is not 0x0
- Sanity check in the smart contract code
	- [x] `nonce` is unique
	- [x] `allSignersPossible` contains the same records – the code is fault tolerant through `usedAddresses[]`
	- [x] Signature (/r/v/s) arrays contains the same records – the code is fault tolerant through `usedAddresses[]`
	- [ ] Transfer is allowed – no checks to save on gas as a design decision


### Function specific code

- **checkAndTransferFrom()**
	- [x] lengths of signature arrays (/r/v/s) should be equal to `m` + 1

- **checkAndTransferFrom_senderSigner()**
	- [x] lengths of signature arrays (/r/v/s) should be equal to `m`

- **checkAndTransferFrom_1of1()**
	- [x] No `m` param (it is known and equal to 1)
	- [x] lengths of signature arrays should be equal to 2
	- [x] length of `allSignersPossible` should be equal to 1

- **checkAndTransferFrom_2of2()**
	- [x] No `m` param (it is known and equal to 2) -- WRONG COMMENT about `m` = 1
	- [x] lengths of signature arrays should be equal to 3
	- [x] length of `allSignersPossible` should be equal to 2

- **checkAndTransferFrom_BlankCheck()**
	- [x] no `nonce` param
	- [x] address named `verificationKey` is approved by `allSignersPossible` to sign transfer for `amount`
	- [x] lengths of signature arrays should be equal to `m` + 2
	- [x] `verificationKey` used before can not be used again

- **checkIfAddressInArray(address[] validAddresses, address checkAddress)**
	- [x] should return *true* if `validAddresses` contains `checkAddress`
	- [x] should return *false* otherwise

- **verifyMultisigKeyAllowsAddresses(address[] signers, uint8 m, address multisigAddress, uint8 v, bytes32 r, bytes32 s)**
	- [x] should return *true* if the `multisigAddress` is the address used to sign (with keccak256) list of `signers` and amount `m` of required signatures
	- [x] should return *false* otherwise



<br><!-- ********************************************* -->


