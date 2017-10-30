var Requester = artifacts.require("./Requester.sol");

module.exports = function(deployer) {
  deployer.deploy(Requester);
};
