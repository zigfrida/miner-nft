const HDWalletProvider = require('@truffle/hdwallet-provider');
require('dotenv').config()

// const fs = require('fs');
// const mnemonic = fs.readFileSync(".secret").toString().trim();
// if (!mnemonic || mnemonic.split(' ').length !== 12) {
// 	throw new Error('unable to retrieve mnemonic from .secret');
// }

// const gasPriceTestnetRaw = fs.readFileSync(".gas-price-testnet.json").toString().trim();
// const gasPriceTestnet = parseInt(JSON.parse(gasPriceTestnetRaw).result, 16);
// if (typeof gasPriceTestnet !== 'number' || isNaN(gasPriceTestnet)) {
// 	throw new Error('unable to retrieve network gas price from .gas-price-testnet.json');
// }
// console.log("Gas price Testnet: " + gasPriceTestnet);

const path = require("path");

module.exports = {
	networks: {
		testnet: {
			provider: () => new HDWalletProvider(process.env.MNEMONIC, process.env.RINKEBY_RPC_URL),
			network_id: '4'
		},
		rinkeby: {
			provider: () => new HDWalletProvider(process.env.MNEMONIC, process.env.RINKEBY_RPC_URL),
			network_id: '4',
			networkCheckTimeout: 10000000,
		},
	},

	contracts_build_directory: path.join(__dirname, "app/src/contracts"),

	compilers: {
		solc: {
			version: "0.6.6",
		}
	}
}