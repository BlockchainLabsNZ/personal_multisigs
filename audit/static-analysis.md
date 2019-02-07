# Static analysis

of Zippie Personal Multisig Wallet contract

-

### Documentation

 - [?] Whitepaper, presentations, high level overview
 - [x] Business logic workflow is described
 - [ ] Communications/Dependencies Diagrams, Control/Data flow diagrams
 - [ ] Specifications and requirements
 - [X] Variables and constants are described
 - [x] Code is well documented, comments are helpful and reflect code logic
 - [x] Meaningful variables and functions names
 - [ ] No typos in documentation/comments (see below)
 	- [ZippieWallet, lines: 32, 127, 162, 258, 300, 385, 509](https://github.com/BlockchainLabsNZ/zippie-multisig-2/blob/master/contracts/Zippie/ZippieWallet.sol)
 	- [ZippieMultisig, lines: 9, 11, 58](https://github.com/BlockchainLabsNZ/zippie-multisig-2/blob/master/contracts/Zippie/ZippieMultisig.sol)
 	- [ZippieCardNonces, lines: 8, 16](https://github.com/BlockchainLabsNZ/zippie-multisig-2/blob/master/contracts/Zippie/ZippieCardNonces.sol)
 	- [ZippieCard, line 10](https://github.com/BlockchainLabsNZ/zippie-multisig-2/blob/master/contracts/Zippie/ZippieCard.sol)

### Logic

 - [x] No dependency on external actors (key/password management driven by humans, ...)
 - [x] No Front-end dependencies (distribution scripts, running nodes, bridges, ... )
 - [x] No upgradeable contracts
 - [x] No Oracles

 

### Code correctness

 - [x] Adherence to adopted standards such as ERC20
 - [x] Latest version of pragma
 - [x] Latest syntax (constructors, emit, ... )
 - [ ] Latest(ish) (of stable) version of 
	 - [x] Solidity compiler
	 - [ ] Frameworks – *[Open Zeppelin library v2.0.0](https://github.com/OpenZeppelin/openzeppelin-solidity/blob/v2.0.0) is used, which uses old-ish pragma version (0.4.24)*
	 - [x] Development/testing environment
 - [x] Common and well tested libraries and frameworks are used (e.g. Open Zeppelin)  
 - [x] Variable types declared explicitly (uint256 vs uint)
 - [x] Access modifiers declared explicitly
 - [x] Consistent naming convention (CamelCase/pascalCase, underscores, ...) 
 - [x] No magic numbers (variables defined with any "obvious" numbers without explanation) – [example](https://github.com/BlockchainLabsNZ/bluzelle-contracts/issues/3)
 - [x] Solidity variables are used (`1 year` vs `365*24*60*60`) – [list](https://solidity.readthedocs.io/en/v0.4.24/units-and-global-variables.html) (if any)
 - [x] Functions explicitly returns boolean if it was declared
 - [x] Fallbacks function logging events (or no fallback functions)
 - [x] No variables re-declared
 - [x] No reliance on nested callback functions or console logs (JS)




### Gas Optimization

 - [x] No variables defined when it's possible to avoid it – [example](https://github.com/BlockchainLabsNZ/wings-private-contracts/issues/2)
 - [x] Tight structs packing or there are no structs
 - [x] No string used in structs (which is more expensive than bytes32) – [example](https://github.com/BlockchainLabsNZ/mothership-sen/issues/3) or there are no structs
 - [x] No dead code found. All declared variables/modifiers/functions/events/files have been used



### Other Best Practices

 - [x] The pragma version declaration is on the top of the code
 - [ ] Solidity compiler has strict version (not a range) [example_1](https://github.com/BlockchainLabsNZ/wings-private-contracts/issues/10), [example_2](https://github.com/BlockchainLabsNZ/leverj-contracts/issues/5)
 - [x] Safemath is used (even in libraries) [example](https://github.com/BlockchainLabsNZ/leverj-contracts/issues/4)
 - [x] Require over revert/throw – [example](https://github.com/BlockchainLabsNZ/wings-private-contracts/issues/13)
 - [x] English comments only
 - [x] Single line if/for statements are wrapped with curly braces – [discussion](https://stackoverflow.com/questions/2125066/is-it-bad-practice-to-use-an-if-statement-without-brackets)
 - [x] Contracts are explicit about interface they implement (if any) – [example](https://github.com/BlockchainLabsNZ/poa-popa/issues/2)
 - [ ] No repeated code
 - [x] Names of public variables and functions help to differentiate them (to avoid misunderstanding on Etherscan) – [example](https://github.com/BlockchainLabsNZ/LINA-TokenERC20/issues/2)
 - [x] Token state changes emit log events (e.g transfer/mint/burn/change owner, etc)
 - [x] Contract fully implements the ERC20 standard. [Standard definition](https://theethereum.wiki/w/index.php/ERC20_Token_Standard)
 - [x] Token symbol consist of capital letters only (or No token symbols at all)
 - [x] No `.send` instructions (only `.transfer`, if any)
 - [x] There is an appropriate error handling or throwing errors; not just `return false` (if any)



### Testability

 - [ ] Test plan 
 - [ ] Functional tests are described
 - [ ] Test coverage across all functions and events
 - [ ] Test cases for both expected behaviour and failure modes
 - [ ] Settings and pre-defined values for easy testing of a range of parameters 
 - [x] No test scenarios calling other test scenarios 
 - [x] ES6 style (await/asyncs and other benefits)

  
### Known Security Weaknesses

	Should not be checked

 - [ ] Integer Overflow or Underflow [example](https://ethereumdev.io/safemath-protect-overflows/)
 - [ ] DoS with (unexpected)reverts [example](https://consensys.github.io/smart-contract-best-practices/known_attacks/#dos-with-unexpected-revert)
 - [ ] DoS with Block Gas Limit [example](https://consensys.github.io/smart-contract-best-practices/known_attacks/#dos-with-block-gas-limit)
 - [ ] Honey pots
 - [ ] proxyOverflow
 - [ ] Transaction-Ordering Dependence (TOD) / Front Running
 - [ ] Timestamp Dependence
 - [ ] Forcibly Sending Ether to a Contract
 - [ ] Race conditions 
	- [ ] Re-entrancy
	- [ ] Cross-function race condition 
	- [ ] Race conditions bad solutions 


<br><!-- ******************************** -->	
## Suggestions

### Common patterns
	
##### verify***Signature()
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

<br>
### ZippieWallet.sol

##### redeemBlankCheck()
- The code is similar to `redeemCheck` and could be reused (DRY)


<br>
### Unit tests
- create testing plan and test cases
- they are too complex, which is also a sign that functions should be decomposed
- there are empty test scenarios, it should be completed
	


<br><!-- ******************************** -->

___


Prepared by: 

- Alex Tikonoff, [alex@blockchainlabs.nz](alex@blockchainlabs.nz)

Report: 

- February 11, 2019 – date of delivery 
- February 11, 2019 – last report update

<br>


