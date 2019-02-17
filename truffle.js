// var HDWalletProvider = require("truffle-hdwallet-provider")
// var mnemonic = "side stumble wave remember grab portion tunnel song nature cave sign warm"
// const Wallet = require('ethereumjs-wallet')
//
// const privateKey = Buffer.from('0xe73a51303b5330beb14839019804b50992478f74e7163042ed65365dc606faeb', 'hex')
// const wallet = Wallet.fromPrivateKey(privateKey);
// const provider = new HDWalletProvider(wallet, `https://kovan.infura.io/v3/5cb806fa94854899b53caf71ce775809`);
//

const PrivateKeyProvider = require('truffle-privatekey-provider')
const privateKey = 'e73a51303b5330beb14839019804b50992478f74e7163042ed65365dc606faeb'

module.exports = {
  // See <http://truffleframework.com/docs/advanced/configuration>
  // to customize your Truffle ]configuration!
	networks: {
		development: {
			host: "localhost",
			port: 8545,
			network_id: "*", // Match any network id
		},
		kovan: {
			host: "localhost",
			port: 8545,
			network_id: '42',
			from: "0xDC6A1d0211B9d505cde594B8fe33E98945BccBd4",
			gas: 4600000, // <-- Use this high gas value
			gasPrice: 0x01      // <-- Use this low gas price
		},
		infura: {
			// host: "https://kovan.infura.io/v3/5cb806fa94854899b53caf71ce775809",
			// port: 8545,
			provider: new PrivateKeyProvider(privateKey, 'https://kovan.infura.io/v3/5cb806fa94854899b53caf71ce775809'),
			network_id: '*',
			// from: "0xd6498DF7Bc8b5DB4aC11FC284F2F5173abF61D67",
			gas: 4612388 // <-- Use this high gas value
		}

	},
	solc: {
		optimizer: {
			enabled: true,
			runs: 200
		}
	},
	compilers: {
		solc: {
			version: "0.5.0"
		}
	},
	coverage: {
		host: "localhost",
		network_id: "*",
		port: 8555,         // <-- If you change this, also set the port option in .solcover.js.
		gas: 0xfffffffffff, // <-- Use this high gas value
		gasPrice: 0x01      // <-- Use this low gas price
	}
};
