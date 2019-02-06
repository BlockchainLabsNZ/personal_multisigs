# Static analysis

of Zippie Personal Multisig Wallet contract

-

Prepared by: 

- Alex Tikonoff, [alex@blockchainlabs.nz](alex@blockchainlabs.nz)

Report: 

- February 7, 2019 – date of delivery 
- February 7, 2019 – last report update

<br>

### Documentation

 - [ ] Whitepaper, presentations, high level overview
 - [x] Business logic workflow is described
 - [ ] Communications/Dependencies Diagrams, Control/Data flow diagrams
 - [ ] Specifications and requirements
 - [X] Variables and constants are described
 - [x] Code is well documented, comments are helpful and reflect code logic
 - [x] Meaningful variables and functions names
 - [ ] No typos in documentation/comments (see below)
 	- [ZippieWallet, lines: 32, 127, 162, 258, 300, 385, 509](https://github.com/BlockchainLabsNZ/zippie-multisig-2/blob/master/contracts/Zippie/ZippieWallet.sol)
 	- [ZippieMultisig, lines: 9, 11, 58](https://github.com/BlockchainLabsNZ/zippie-multisig-2/blob/master/contracts/Zippie/ZippieMultisig.sol)
 	- [ZippieCardNonces, line 8](https://github.com/BlockchainLabsNZ/zippie-multisig-2/blob/master/contracts/Zippie/ZippieCardNonces.sol)
 	- [ZippieCard, line 10](https://github.com/BlockchainLabsNZ/zippie-multisig-2/blob/master/contracts/Zippie/ZippieCard.sol)

### Logic

 - [ ] No dependency on external actors (key/password management driven by humans, ...)
 - [ ] No Front-end dependencies (distribution scripts, running nodes, bridges, ... )
 - [ ] No upgradeable contracts
 - [ ] No Oracles

 

### Code correctness

 - [ ] Adherence to adopted standards such as ERC20
 - [ ] Latest version of pragma
 - [ ] Latest syntax (constructors, emit, ... )
 - [ ] Common and well tested libraries and frameworks are used (e.g. Open Zeppelin)  
 - [ ] Variable types declared explicitly (uint256 vs uint)
 - [ ] Access modifiers declared explicitly
 - [ ] Consistent naming convention (CamelCase/pascalCase, underscores, ...) 
 - [ ] No magic numbers (variables defined with any "obvious" numbers without explanation) – [example](https://github.com/BlockchainLabsNZ/bluzelle-contracts/issues/3)
 - [ ] Solidity variables are used (`1 year` vs `365*24*60*60`) – [list](https://solidity.readthedocs.io/en/v0.4.24/units-and-global-variables.html) - *no such variables*
 - [ ] Milestones defined by timestamps, not by blocks - *no milestones*
 - [ ] Functions explicitly returns boolean if it was declared
 - [ ] Tight struct packing
 - [ ] Fallbacks function logging events - *no fallback function*
 - [ ] No variables re-declared
 - [ ] No reliance on nested callback functions or console logs (JS)
 - [ ] Latest(ish) (of stable) version of 
	 - [ ] Solidity compiler
	 - [ ] Frameworks
	 - [ ] Development/testing environment



### Gas Optimization

 - [ ] No string used in structs (which is more expensive than bytes32) – [example](https://github.com/BlockchainLabsNZ/mothership-sen/issues/3)
 - [ ] No variables assigned when it's possible to avoid without losing the meaning – [example](https://github.com/BlockchainLabsNZ/wings-private-contracts/issues/2) **– didn't check this yet**
 - [ ] No uint8/16/32/... used, only uint256 – [gas saving reason](https://ethereum.stackexchange.com/questions/3067/why-does-uint8-cost-more-gas-than-uint256)
 - [ ] No dead code found. All declared variables/modifiers/functions/events/files have been used



### Other Best Practices

 - [ ] The pragma version declaration is on the top of the code
 - [ ] Solidity compiler has strict version (not a range) [example_1](https://github.com/BlockchainLabsNZ/wings-private-contracts/issues/10), [example_2](https://github.com/BlockchainLabsNZ/leverj-contracts/issues/5)
 - [ ] Safemath is used (if  [example](https://github.com/BlockchainLabsNZ/leverj-contracts/issues/4)
 - [ ] Require over revert/throw – [example](https://github.com/BlockchainLabsNZ/wings-private-contracts/issues/13)
 - [ ] English comments only
 - [ ] Single line if/for statements are wrapped with curly braces – [discussion](https://stackoverflow.com/questions/2125066/is-it-bad-practice-to-use-an-if-statement-without-brackets)
 - [ ] Contracts are explicit about interface they implement (if any) – [example](https://github.com/BlockchainLabsNZ/poa-popa/issues/2)
 - [ ] No repeated code
 - [ ] Names of public variables and functions help to differentiate them (to avoid misunderstanding on Etherscan) – [example](https://github.com/BlockchainLabsNZ/LINA-TokenERC20/issues/2)
 - [ ] Token state changes emit log events (e.g transfer/mint/burn/change owner, etc)
 - [ ] Contract fully implements the ERC20 standard. [Standard definition](https://theethereum.wiki/w/index.php/ERC20_Token_Standard)
 - [ ] Token symbol consist of capital letters only
 - [ ] No `.send` instructions (only `.transfer`, if any)
 - [ ] There is an appropriate error handling or throwing errors; not just `return false`



### Testability

 - [ ] Test plan 
 - [ ] Functional tests are described
 - [ ] Test coverage across all functions and events
 - [ ] Test cases for both expected behaviour and failure modes
 - [ ] Settings and pre-defined values for easy testing of a range of parameters 
 - [ ] No test scenarios calling other test scenarios 
 - [ ] ES6 style (await/asyncs and other benefits)

  
### Known Security Weaknesses

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

