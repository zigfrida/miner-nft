const MinersNFTs = artifacts.require("MinerNFTContract");

module.exports = function(deployer) {
    deployer.deploy(MinersNFTs);
};