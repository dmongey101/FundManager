var Fund = artifacts.require("./Fund.sol");

module.exports = function(deployer) {
    deployer.deploy(Fund, "0xCe0C08a78954b272e6450A40E701233286a1b9a3");
  };