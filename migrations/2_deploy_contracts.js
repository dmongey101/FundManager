var FundingRound = artifacts.require("./FundingRound.sol");

module.exports = function(deployer) {
    deployer.deploy(FundingRound, "0xbEe6eC1f14db12DDa953707f118C3fA4C5d92E30", "0xbEe6eC1f14db12DDa953707f118C3fA4C5d92E30", 5);
  };