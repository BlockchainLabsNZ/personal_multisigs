# Zippie Multisig

Prepared by:

- Alex Tikonoff, [alex@blockchainlabs.nz](alex@blockchainlabs.nz)
- Matt Lough, [matt.lough@blockchainlabs.nz](matt.lough@blockchainlabs.nz)
- Klaus Hott, [klaus@blockchainlabs.nz](klaus@blockchainlabs.nz)

Report:

- February 19, 2019 – date of delivery
- February 21, 2019 – last report update

<br><!-- ******************************************************** -->

## Preamble

This audit report was undertaken for the **[Zippie](https://zippie.org/)**, by its request, and has subsequently been shared publicly without any express or implied warranty.

Solidity contracts were sourced from the public Github repo [Zippie Personal Multisig](https://github.com/zippiehq/personal_multisigs) and the most recent commit we have audited is this [336c47d11977efaea9b0a83b12ec22ba3844ab38](https://github.com/BlockchainLabsNZ/zippie-multisig-2/commit/336c47d11977efaea9b0a83b12ec22ba3844ab38).

We would encourage all community members and token holders to make their own assessment of the contracts.

<br><!-- ******************************************************** -->

## Scope

The following contracts were subject for static, dynamic and functional analyses:

#### Smart contracts

- Libraries
  - [openzeppelin-solidity/contracts/token/ERC20/IERC20.sol](https://github.com/OpenZeppelin/openzeppelin-solidity)
- Zippie card
  - [IZippieCardNonces.sol](https://github.com/BlockchainLabsNZ/zippie-multisig-2/blob/master/contracts/Zippie/IZippieCardNonces.sol)
  - [ZippieCardNonces.sol](https://github.com/BlockchainLabsNZ/zippie-multisig-2/blob/master/contracts/Zippie/ZippieCardNonces.sol)
  - [ZippieCard.sol](https://github.com/BlockchainLabsNZ/zippie-multisig-2/blob/master/contracts/Zippie/ZippieCard.sol)
- Wallet Contracts
  - [ZippieWallet.sol](https://github.com/BlockchainLabsNZ/zippie-multisig-2/blob/master/contracts/Zippie/ZippieWallet.sol)
  - [ZippieBasicWallet.sol](https://github.com/BlockchainLabsNZ/zippie-multisig-2/blob/master/contracts/Zippie/ZippieWalletBasic.sol)
- Multisig Contract
  - [ZippieMultisig.sol](https://github.com/BlockchainLabsNZ/zippie-multisig-2/blob/master/contracts/Zippie/ZippieMultisig.sol)
- Other contracts
  - [Tests](https://github.com/BlockchainLabsNZ/zippie-multisig-2/tree/master/contracts/Test)
  - [Migrations.sols](https://github.com/BlockchainLabsNZ/zippie-multisig-2/blob/master/contracts/Migrations.sol)

#### Tests

- [Smart contracts with tests](https://github.com/BlockchainLabsNZ/zippie-multisig-2/tree/master/contracts/Test/)
- [Javascript tests](https://github.com/BlockchainLabsNZ/zippie-multisig-2/tree/master/test)

### Out of scope

- Process of signing transactions by external actors
- Tokens, token contracts, vault, all other code except Multisig itself

<br><!-- ******************************************************** -->

## Reports

The outputs of our thorough analysis are detailed further in the below reports.

- [Static analysis](static-analysis.md)
- [Dynamic analysis](dynamic-analysis.md) (white box)
- [Functional Testing](functional-testing.md) (black box)

<br><!-- ******************************************************** -->

## Issues found

### Severity Description

<table>
<tr>
  <td>Minor</td>
  <td>A defect that does not have a material impact on the contract execution and is likely to be subjective.</td>
</tr>
<tr>
  <td>Moderate</td>
  <td>A defect that could impact the desired outcome of the contract execution in a specific scenario.</td>
</tr>
<tr>
  <td>Major</td>
  <td> A defect that impacts the desired outcome of the contract execution or introduces a weakness that may be exploited.</td>
</tr>
<tr>
  <td>Critical</td>
  <td>A defect that presents a significant security vulnerability or failure of the contract across a range of scenarios.</td>
</tr>
</table>

### Minor

- **The verify Signature functions are too complex** – `Best practice`, `Testability`, `Enhancement`<br>
  Each function contains code for the functionalities:

  1. recover card addresses
  2. checking for duplicates
  3. saving new nonces

  which is too much for one function.<br>
  verifyCardSignatures: [26^149](https://github.com/BlockchainLabsNZ/zippie-multisig-2/blob/336c47d11977efaea9b0a83b12ec22ba3844ab38/contracts/Zippie/ZippieCard.sol#L26-L149), verifyMultisigSignerSignatures: [91^199](https://github.com/BlockchainLabsNZ/zippie-multisig-2/blob/336c47d11977efaea9b0a83b12ec22ba3844ab38/contracts/Zippie/ZippieMultisig.sol#L91-L199)

- **redeemCheck() and redeemBlankCheck() are almost the same** – `Best practice`, `Enhancement`<br>
  Similar code could be abstracted (DRY principle).
  See /contracts/Zippie/ZippieWallet.sol, lines: [49](https://github.com/BlockchainLabsNZ/zippie-multisig-2/blob/336c47d11977efaea9b0a83b12ec22ba3844ab38/contracts/Zippie/ZippieWallet.sol#L49), [180](https://github.com/BlockchainLabsNZ/zippie-multisig-2/blob/336c47d11977efaea9b0a83b12ec22ba3844ab38/contracts/Zippie/ZippieWallet.sol#L180)

  - [x] This has been fixed in commit [bfe8ec37](https://github.com/zippiehq/personal_multisigs/commit/bfe8ec379987b9caf29f49cb1f0d75dfc3930c61).

- **There are empty test scenarios** – `Best practice`, `Testability`<br>
  See /test/Test_ZippieMultisig_CheckCashingWithCards.js, lines: [145](https://github.com/BlockchainLabsNZ/zippie-multisig-2/blob/a9f5a46ff3a3ec1415f9c1a6dabdc6dd7f78df49/test/Test_ZippieMultisig_CheckCashingWithCards.js#L145), [149](https://github.com/BlockchainLabsNZ/zippie-multisig-2/blob/a9f5a46ff3a3ec1415f9c1a6dabdc6dd7f78df49/test/Test_ZippieMultisig_CheckCashingWithCards.js#L149), [153](https://github.com/BlockchainLabsNZ/zippie-multisig-2/blob/a9f5a46ff3a3ec1415f9c1a6dabdc6dd7f78df49/test/Test_ZippieMultisig_CheckCashingWithCards.js#L153)

- **Variables re-declaration** – `Correctness`<br>
  Some variables are declared more than twice which is considered a bad practice.<br>
- Test_ZippieMultisig_CheckCashingWithCards.js: [161^184](https://github.com/BlockchainLabsNZ/zippie-multisig-2/blob/9b777cadc4ae346e0529a407d818b673aaaa3002/test/Test_ZippieMultisig_CheckCashingWithCards.js#L184), [203^223](https://github.com/BlockchainLabsNZ/zippie-multisig-2/blob/9b777cadc4ae346e0529a407d818b673aaaa3002/test/Test_ZippieMultisig_CheckCashingWithCards.js#L223), [243^263](https://github.com/BlockchainLabsNZ/zippie-multisig-2/blob/9b777cadc4ae346e0529a407d818b673aaaa3002/test/Test_ZippieMultisig_CheckCashingWithCards.js#L263), [282^305](https://github.com/BlockchainLabsNZ/zippie-multisig-2/blob/9b777cadc4ae346e0529a407d818b673aaaa3002/test/Test_ZippieMultisig_CheckCashingWithCards.js#L305)<br> - Test_ZippieMultisig_GasSimulation_BlankCheck.js: [36^79](https://github.com/BlockchainLabsNZ/zippie-multisig-2/blob/9b777cadc4ae346e0529a407d818b673aaaa3002/test/Test_ZippieMultisig_GasSimulation_BlankCheck.js#L79), [115^168](https://github.com/BlockchainLabsNZ/zippie-multisig-2/blob/9b777cadc4ae346e0529a407d818b673aaaa3002/test/Test_ZippieMultisig_GasSimulation_BlankCheck.js#L168),
  [56-58^66-68](https://github.com/BlockchainLabsNZ/zippie-multisig-2/blob/9b777cadc4ae346e0529a407d818b673aaaa3002/test/Test_ZippieMultisig_GasSimulation_BlankCheck.js#L56-68),
  [87-89^97-99](https://github.com/BlockchainLabsNZ/zippie-multisig-2/blob/9b777cadc4ae346e0529a407d818b673aaaa3002/test/Test_ZippieMultisig_GasSimulation_BlankCheck.js#L87-99),

### Moderate

- None found

### Major

- None found

### Critical

- None found

<br><!-- ******************************************************** -->

## Observations

- **Parameters hidden within an array**<br>
  The functions `redeemCheck()`, `redeemBlankCheck()`, and `setLimit()` expect an array of parameters. While there is clear documentation of each of the parameters within the array, it would be preferable to pass each individually as actual parameters. This use of arrays is likely due to solidity's constraint on max number of parameters per function (owing to a limitation of the [EVM stack](https://solidity.readthedocs.io/en/v0.5.0/introduction-to-smart-contracts.html?highlight=stack#storage-memory-and-the-stack)). We suggest a refactor in case this constraint is removed in future versions of solidity/EVM.

- **Only a subset of arrays is used**<br>
  The functions `verifyCardSignatures()` and `verifyMultisigSignerSignatures()` checks whether a _subset of an array of signatures_ have been created by a _subset of an array of valid signers_. Working with subsets and ignoring the rest of the array raises a flag, however we understand that building an array within the function would consume more gas, and the arrays contain more information than needed because of solidity's constraint on number of variables described in the observation above. In case this constraint changes in future versions of solidity/EVM, we suggest a refactor.

- **Code quality and consistency**<br>
  There are a number of very minor issues with code consistency and correctness, namely: <br> - Use of both double and single quotations marks in variables declaration and comparison operators; <br> - Unused variables; <br> - Strict comparison vs loose comparison operators (== vs ===); <br> - `var` declaration used instead of `let` and `const`; <br> - typos in comments.

The variety of such issues could form inappropriate and even dissatisfactory impression about the code and, therefore, the product itself. Consider cleaning it up (at least) with ESLINT.

<br><!-- ******************************************************** -->

## Conclusion

We are confident that these Smart Contracts do not exhibit any known security vulnerabilities. Overall the code of smart contracts are well written and shows care taken by the developers to follow best practices and a strong knowledge of Solidity. Major functions are covered by tests which should increase confidence in the security of these contracts, and their maintainability in the future.

<br><!-- ******************************************************** -->

---

### Disclaimer

Our team uses our current understanding of the best practises for Solidity and Smart Contracts. Development in Solidity and for Blockchain is an emerging area of software engineering which still has a lot of room to grow, hence our current understanding of best practice may not find all of the issues in this code and design.

We have not analysed any of the assembly code generated by the Solidity compiler. We have not verified the deployment process and configurations of the contracts. We have only analysed the code outlined in the scope. We have not verified any of the claims made by any of the organisations behind this code.

Security audits do not warrant bug-free code. We encourage all users interacting with smart contract code to continue to analyse and inform themselves of any risks before interacting with any smart contracts.
