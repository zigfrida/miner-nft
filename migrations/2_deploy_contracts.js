const MinersNFTs = artifacts.require("MinerNFT");
require('dotenv').config()

module.exports = async (deployer, network, [defaultAccount]) => {
    if(network.startsWith('rinkeby')) {
        await deployer.deploy(MinersNFTs, process.env.RINKEBY_VRF_COORDINATOR, process.env.RINKEBY_LINKTOKEN, process.env.RINKEBY_KEYHASH);
        let dnd = await MinersNFTs.deployed();
    } else {
        console.log("Right now only rinkeby works! Please change your network to Rinkeby");
    }

};

// const MinersNFTs = artifacts.require("MinerNFT");

// module.exports = function(deployer) {
//     deployer.deploy(MinersNFTs);
// };