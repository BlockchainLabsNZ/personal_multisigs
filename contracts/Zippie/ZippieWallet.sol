pragma solidity ^0.5.0;

import "./ZippieMultisig.sol";
import "./ZippieCard.sol";
import "./ZippieUtils.sol";

import "openzeppelin-solidity/contracts/token/ERC20/IERC20.sol";

/**
  * @title Zippie Multisig Wallet (with 2FA smart card)
  * @notice Transfer ERC20 tokens using multiple signatures
  * @dev Zippie smart cards can be used for 2FA
 */
contract ZippieWallet is ZippieMultisig, ZippieCard {

    mapping (address => uint256) public accountLimits;

    constructor(address zippieCardNonces) ZippieCard(zippieCardNonces) public {}
    
    /** @notice Redeems a check after verifying required signers/cards 
      * (recipient is specified when check is created) 
      * @dev Transfer ERC20 tokens when verified that 
      * enough signers has signed keccak256(recipient, amount, verification key)
      * card signatures are not required if amount doesn't exceeded the current limit
      * @param addresses required addresses
      * [0] multisig account to withdraw ERC20 tokens from
      * [1] ERC20 contract to use
      * [2] recipient of the ERC20 tokens
      * [3] verification key (nonce)
      * @param signers all possible signers and cards
      * [0..i] signer addresses
      * [i+1..j] card adresses
      * @param m the amount of signatures required for this multisig account
      * [0] possible number of signers
      * [1] required number of signers
      * [2] possible number of cards
      * [3] reqiuired number of cards
      * @param v v values of all signatures
      * [0] multisig account signature
      * [1] verification key signature
      * [2..i] signer signatures of check hash
      * [i+1..j] card signatures of random card nonces
      * @param r r values of all signatures (structured as v)
      * @param s s values of all signatures (structured as v)
      * @param amount amount to transfer
      * @param cardNonces random nonce values generated by cards at every read
      * @return true if transfer successful 
      */
    function redeemCheck(
        address[] memory addresses, 
        address[] memory signers, 
        uint8[] memory m, 
        uint8[] memory v, 
        bytes32[] memory r, 
        bytes32[] memory s, 
        uint256 amount, 
        bytes32[] memory cardNonces
    ) 
        public 
        returns (bool)
    {
        require(
            addresses.length == 4, 
            "Incorrect number of addresses"
        );
        require(
            amount > 0, 
            "Amount must be greater than 0"
        );

        // sanity check of signature parameters 
        bool limitExceeded = isLimitExceeded(amount, addresses[0]);
        checkSignatureParameters(
            m, 
            signers.length, 
            v.length, 
            r.length, 
            s.length, 
            cardNonces.length, 
            limitExceeded
        );
        
        // verify that account signature is valid
        verifyMultisigAccountSignature(
            signers, 
            m, 
            addresses[0], 
            v[0], 
            r[0], 
            s[0]
        );

        // verify that account nonce is valid (for replay protection)
        // (verification key signing recipient address)
        bytes32 recipientHash = ZippieUtils.toEthSignedMessageHash(
            keccak256(abi.encodePacked(addresses[2]))
        );
        verifyMultisigNonce(
            addresses[0], 
            addresses[3], 
            recipientHash, 
            v[1], 
            r[1], 
            s[1]
        );

        // get the check hash (amount, recipient, nonce) 
        // and verify that required number of signers signed it 
        // (recipient is specified when check is created)
        // prepend with function name "redeemCheck"
        // so a hash for another function with same parameter 
        // layout don't get the same hash
        bytes32 checkHash = ZippieUtils.toEthSignedMessageHash(
            keccak256(abi.encodePacked("redeemCheck", amount, addresses[2], addresses[3]))
        );
        verifyMultisigSignerSignatures(
            checkHash, 
            [0, m[0]], 
            signers, 
            [2, m[1]], 
            v, 
            r, 
            s
        );

        // if limit is exceeded (2FA)
        // verify that requied number of 
        // card signatures has been provided 
        if (limitExceeded) {
            // verify that card nonces are valid 
            // and has not been used already
            verifyCardSignatures(
                cardNonces, 
                [m[0], m[2]], 
                signers, 
                [2+m[1], m[3]], 
                v, 
                r, 
                s
            );
        }

        // transfer tokens from multisig account to recipient address
        require(
            IERC20(addresses[1]).transferFrom(addresses[0], addresses[2], amount), 
            "Transfer failed"
        );
        return true;
    }

    /** @notice Redeems a blank check after verifying required signers/cards 
      * (recipient is specified when check is claimed) 
      * @dev Transfer ERC20 tokens when verified that 
      * enough signers has signed keccak256(amount, verification key)
      * card signatures are not required if amount doesn't exceeded the current limit
      * @param addresses required addresses
      * [0] multisig account to withdraw ERC20 tokens from
      * [1] ERC20 contract to use
      * [2] recipient of the ERC20 tokens
      * [3] verification key (nonce)
      * @param signers all possible signers and cards
      * [0..i] signer adresses
      * [i+1..j] card addresses
      * @param m the amount of signatures required for this multisig account
      * [0] possible number of signers
      * [1] required number of signers
      * [2] possible number of cards
      * [3] reqiuired number of cards
      * @param v v values of all signatures
      * [0] multisig account signature
      * [1] verification key signature
      * [2..i] signer signatures of check hash
      * [i+1..j] card signatures of random card nonces
      * @param r r values of all signatures (structured as v)
      * @param s s values of all signatures (structured as v)
      * @param amount amount to transfer
      * @param cardNonces random nonce values generated by cards at every read
      * @return true if transfer successful 
      */
    function redeemBlankCheck(
        address[] memory addresses, 
        address[] memory signers, 
        uint8[] memory m, 
        uint8[] memory v, 
        bytes32[] memory r, 
        bytes32[] memory s, 
        uint256 amount, 
        bytes32[] memory cardNonces
    ) 
        public 
        returns (bool)
    {
        require(
            addresses.length == 4, 
            "Incorrect number of addresses"
        ); 
        require(
            amount > 0, 
            "Amount must be greater than 0"
        );
       
        // sanity check of signature parameters 
        bool limitExceeded = isLimitExceeded(amount, addresses[0]);
        checkSignatureParameters(
            m, 
            signers.length, 
            v.length, 
            r.length, 
            s.length, 
            cardNonces.length, 
            limitExceeded
        );
        
        // verify that account signature is valid
        verifyMultisigAccountSignature(
            signers, 
            m, 
            addresses[0], 
            v[0], 
            r[0], 
            s[0]
        );

        // verify that account nonce is valid (for replay protection)
        // (verification key signing recipient address)
        bytes32 recipientHash = ZippieUtils.toEthSignedMessageHash(
            keccak256(abi.encodePacked(addresses[2]))
        );
        verifyMultisigNonce(
            addresses[0], 
            addresses[3], 
            recipientHash, 
            v[1], 
            r[1], 
            s[1]
        );

        // get the check hash (amount, nonce) 
        // and verify that required number of signers signed it 
        // (recipient is specified when check is claimed)
        // prepend with function name "redeemBlankCheck"
        // so a hash for another function with same parameter 
        // layout don't get the same hash
        bytes32 blankCheckHash = ZippieUtils.toEthSignedMessageHash(
            keccak256(abi.encodePacked("redeemBlankCheck", amount, addresses[3]))
        );
        verifyMultisigSignerSignatures(
            blankCheckHash, 
            [0, m[0]], 
            signers, 
            [2, m[1]], 
            v, 
            r, 
            s
        );

        // if limit is exceeded (2FA)
        // verify that requied number of 
        // card signatures has been provided 
        if (limitExceeded) {
            // verify that card nonces are valid 
            // and has not been used already
            verifyCardSignatures(
                cardNonces, 
                [m[0], m[2]], 
                signers, 
                [2+m[1], m[3]], 
                v, 
                r, 
                s
            );
        }

        // transfer tokens from multisig account to recipient address
        require(
            IERC20(addresses[1]).transferFrom(addresses[0], addresses[2], amount), 
            "Transfer failed"
        );
        return true;
    }

    /** @notice Set new card (2FA) limit for account
      * card signatures are not required 
      * if amount doesn't exceeded 
      * the current limit when creating checks
      * @dev Change limit when verified that 
      * enough signers has signed keccak256(amount, verification key)
      * card signatures are not required if limit is decreased
      * only if increased
      * @param addresses required addresses
      * [0] multisig account to withdraw ERC20 tokens from
      * [1] verification key (nonce)
      * @param signers all possible signers and cards
      * [0..i] signer addresses
      * [i+1..j] card addresses
      * @param m the amount of signatures required for this multisig account
      * [0] possible number of signers
      * [1] required number of signers
      * [2] possible number of cards
      * [3] reqiuired number of cards
      * @param v v values of all signatures
      * [0] multisig account signature
      * [1] verification key signature
      * [2..i] signer signatures of check hash
      * [i+1..j] card signatures of random card nonces
      * @param r r values of all signatures (structured as v)
      * @param s s values of all signatures (structured as v)
      * @param amount new limit amount
      * @param cardNonces random values generated by cards at every read
      * @return true if new limit was set successful 
      */
    function setLimit(
        address[] memory addresses, 
        address[] memory signers, 
        uint8[] memory m, 
        uint8[] memory v, 
        bytes32[] memory r, 
        bytes32[] memory s, 
        uint256 amount, 
        bytes32[] memory cardNonces
    ) 
        public 
        returns (bool)
    {
        require(
            addresses.length == 2, 
            "Incorrect number of addresses"
        );
        
        // sanity check of signature parameters 
        bool limitExceeded = isLimitExceeded(amount, addresses[0]);
        checkSignatureParameters(
            m, 
            signers.length, 
            v.length, 
            r.length, 
            s.length, 
            cardNonces.length, 
            limitExceeded
        );
        
        // verify that account signature is valid
        verifyMultisigAccountSignature(
            signers, 
            m, 
            addresses[0], 
            v[0], 
            r[0], 
            s[0]
        );

        // verify that account nonce is valid (for replay protection)
        // (nonce signing this multisig account address)
        bytes32 recipientHash = ZippieUtils.toEthSignedMessageHash(
            keccak256(abi.encodePacked(addresses[0]))
        );
        verifyMultisigNonce(
            addresses[0], 
            addresses[1], 
            recipientHash, 
            v[1], 
            r[1], 
            s[1]
        );

        // get the limit hash (amount, nonce) 
        // and verify that required number of signers signed it
        // prepend with function name "setLimit"
        // so a hash for another function with same parameter 
        // layout don't get the same hash
        bytes32 limitHash = ZippieUtils.toEthSignedMessageHash(
            keccak256(abi.encodePacked("setLimit", amount, addresses[1]))
        );
        verifyMultisigSignerSignatures(
            limitHash, 
            [0, m[0]], 
            signers, 
            [2, m[1]], 
            v, 
            r, 
            s
        );

        // in order to increase the account limit (2FA)
        // verify that requied number of 
        // card signatures has been provided 
        if (limitExceeded) {
            // verify that card nonces are valid 
            // and has not been used already
            verifyCardSignatures(
                cardNonces, 
                [m[0], m[2]], 
                signers, 
                [2+m[1], m[3]], 
                v, 
                r, 
                s
            );
        }

        // set the new limit fot this account
        accountLimits[addresses[0]] = amount;
        return true;
    }

    /** 
      * @dev sanity check of signature related parameters
      */
    function checkSignatureParameters(
        uint8[] memory m, 
        uint256 nrOfSigners, 
        uint256 nrOfVs, 
        uint256 nrOfRs, 
        uint256 nrOfSs, 
        uint256 nrOfCardNonces, 
        bool amountLimitExceeded
    ) 
        private 
        pure
        returns (bool)
    {
        require(
            m.length == 4, 
            "Invalid m[]"
        ); 
        require(
            m[1] <= m[0],
            "Required number of signers cannot be higher than number of possible signers"
        );
        require(
            m[3] <= m[2], 
            "Required number of cards cannot be higher than number of possible cards"
        );
        require(
            m[0] > 0, 
            "Required number of signers cannot be 0"
        );           
        require(
            m[1] > 0, 
            "Possible number of signers cannot be 0"
        );  
        require(
            m[0] != 0xFF, 
            "Required number of signers cannot be MAX UINT8"
        ); 
        require(
            m[1] != 0xFF, 
            "Possible number of signers cannot be MAX UINT8"
        ); 
        require(
            m[2] != 0xFF, 
            "Required number of cards cannot be MAX UINT8"
        ); 
        require(
            m[3] != 0xFF, 
            "Possible number of cards cannot be MAX UINT8"
        ); 
        
        // Card signatures must be appended to signers list
        if (amountLimitExceeded) {
            require(
                nrOfSigners == m[0] + m[2], 
                "Incorrect number of signers"
            ); 
            require(
                nrOfVs == 2 + m[1] + m[3], 
                "Incorrect number of signatures (v)"
            ); 
            require(
                nrOfRs == 2 + m[1] + m[3], 
                "Incorrect number of signatures (r)"
            ); 
            require(
                nrOfSs == 2 + m[1] + m[3], 
                "Incorrect number of signatures (s)"
            ); 
            require(
                nrOfCardNonces == m[3], 
                "Incorrect number of card nonces"
            ); 
        } else {
            // Accept either card signatures appended or missing 
            // (even if not required since amount is below limit)
            require(
                nrOfSigners == m[0] || nrOfSigners == m[0] + m[2], 
                "Incorrect number of signers"
            ); 
            require(
                nrOfVs == 2 + m[1] || nrOfVs == 2 + m[1] + m[3], 
                "Incorrect number of signatures (v)"
            ); 
            require(
                nrOfRs == 2 + m[1] || nrOfRs == 2 + m[1] + m[3], 
                "Incorrect number of signatures (r)"
            ); 
            require(
                nrOfSs == 2 + m[1] || nrOfSs == 2 + m[1] + m[3], 
                "Incorrect number of signatures (s)"
            ); 
            require(
                nrOfCardNonces == 0 || nrOfCardNonces == m[3], 
                "Incorrect number of card nonces"
            ); 
        }
        return true;
    }

    /** 
      * @dev checks if an amont is above the current limit
      */
    function isLimitExceeded(
        uint256 amount, 
        address account
    ) 
        private 
        view 
        returns(bool)
    {
        return amount > accountLimits[account];
    }
}