var TestFunctions = artifacts.require("./TestFunctions.sol");
var BasicERC20Mock = artifacts.require("./BasicERC20Mock.sol");
var ZippieWallet = artifacts.require("./ZippieWallet.sol");
var ZippieCardNonces = artifacts.require("./ZippieCardNonces.sol");

const {
	getMultisigSignature,
	getRecipientSignature,
	getSignature,
	getBlankCheckSignature,
	getNonceSignature,
	getSetLimitSignature,
	getDigestSignature,
	getSignatureFrom3,
	getEmptyDigestSignature,
	getHardcodedDigestSignature,
	getRSV,
	log,
 } = require('./HelpFunctions');
 
contract("Test Zippie Multisig Check Cashing Functionality", (accounts) => {

	var test;
	var basicToken;
	var zippieCardNonces;
	var zippieWallet;

	let signer = accounts[0] // multisig signer (1of1)
	let signer2 = accounts[2] // multisig signer (2of2)
	let recipient = accounts[2]
	let card = accounts[3]
	let verificationKey = accounts[4] // random verification key
	let multisig = accounts[5] // multisig wallet (sender, don't sign with this account since the private key should be forgotten at creation)
	const sponsor = accounts[6] // Zippie PMG server

	console.log("Multisig acc", accounts[5])
	
	beforeEach(() => {
		return TestFunctions.new().then(instance => {
				test = instance;
				return BasicERC20Mock.new(accounts[5]).then(instance => {
					basicToken = instance;
					return ZippieCardNonces.new().then(instance => {
						zippieCardNonces = instance
						return ZippieWallet.new(zippieCardNonces.address)}).then(instance => {
							 zippieWallet = instance;
							return basicToken.approve(instance.address, web3.utils.toWei("100", "ether"), {from: accounts[5]});
				});
			});
		});
	});

	it.only("should allow a blank check to be cashed once from a 1 of 1 multisig, and fail the second time", async () => {

		// multisig = '0x9A7dd0851b69999D62724b1C38A88988D0Fb955D'
		basicToken.address = '0x11465b1cd69161b4fe80697e10278228853fc33b'
		recipient = '0x0000000210198695da702d62b08B0444F2233F9C'
		signer = '0x7123fc4FCFcC0Fdba49817736D67D6CFdb43f5b6'


		const addresses = [multisig, basicToken.address, recipient, verificationKey]
		const signers = [signer]
		const m = [1, 1, 0, 0]
		const amount = web3.utils.toWei("1", "ether")

		const multisigSignature = await getMultisigSignature(signers, m, multisig)
		const blankCheckSignature = await getBlankCheckSignature(verificationKey, signer, "1")
		const recipientSignature = await getRecipientSignature(recipient, verificationKey)
		const signature = getSignatureFrom3(multisigSignature, blankCheckSignature, recipientSignature)


		await zippieWallet.redeemBlankCheck(
			addresses,
			signers,
			m,
			signature.v,
			signature.r,
			signature.s,
			amount,
			[],
			{from: sponsor}
		);

	});

	it("should allow a blank check to be cashed from a 2 of 2 multisig", async () => {
		const addresses = [multisig, basicToken.address, recipient, verificationKey]
		const signers = [signer, signer2]
		const m = [2, 2, 0, 0]
		const blankCheckAmount = "1"

		const multisigSignature = await getMultisigSignature(signers, m, multisig)
		const blankCheckSignature = await getBlankCheckSignature(verificationKey, signer, blankCheckAmount)
		const blankCheckSignature2 = await getBlankCheckSignature(verificationKey, signer2, blankCheckAmount)
		const recipientSignature = await getRecipientSignature(recipient, verificationKey)

		const signature = getSignature(multisigSignature, blankCheckSignature, blankCheckSignature2, recipientSignature)

		var initialBalanceSender = await basicToken.balanceOf(multisig)
		var initialBalanceRecipient = await basicToken.balanceOf(recipient)
		assert(await zippieWallet.usedNonces(multisig, verificationKey) === false, "check already marked as cashed before transfer");
		
		const amount = web3.utils.toWei(blankCheckAmount, "ether")
		await zippieWallet.redeemBlankCheck(addresses, signers, m, signature.v, signature.r, signature.s, amount, [], {from: sponsor});
		
		var newBalanceSender = await basicToken.balanceOf(multisig)
		var newBalanceRecipient = await basicToken.balanceOf(recipient)
		assert((initialBalanceSender - newBalanceSender).toString() === amount, "balance did not transfer from sender");
		assert((newBalanceRecipient - initialBalanceRecipient).toString() === amount, "balance did not transfer to recipient");
		assert(await zippieWallet.usedNonces(multisig, verificationKey) === true, "check has not been marked as cashed after transfer");
	});
});