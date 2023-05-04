const ThesisContract = artifacts.require("ThesisContract");

module.exports = function(deployer) {
  deployer.deploy(ThesisContract);
};