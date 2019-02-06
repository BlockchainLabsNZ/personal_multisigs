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
  
  ```