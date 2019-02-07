# Static analysis findings

by contracts:

## ZippieCard.sol

	Requires extra time to understand the logic & double check functions' gas spending

#### verifyCardSignature()
- Unneccessary requirements<Br>
Some of them could be checked by the app

- High function complexity<Br>
Function contains code for: 
	- recover card addresses,
	- checking for duplicates,
	- saving new nonces

	which is too much for one function. 

- Checking for duplicates could be done cheaper???<Br>
Use mappings instead of loops and calling ZippieUtils' `isAddressInArray()`

	

## ZippieMultisig.sol

	Requires extra time to understand the logic & double check functions' gas spending

The code is almost identical to `ZippieCard` contract. Same questions.

	
## ZippieWallet.sol

#### verifyCardSignature()
asdf asdfa 

#### verifyCardSignature()
asdf asdfa 

