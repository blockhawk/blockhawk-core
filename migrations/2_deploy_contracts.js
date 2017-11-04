const Requester = artifacts.require('./Requester.sol');
const SportradarNFLAdapter = artifacts.require('./SportradarNFLAdapter.sol');
const fs = require('fs');

module.exports = deployer => {
  const sportradar = JSON.parse(fs.readFileSync('./helpers/2017/REG/sportradar.json'));
  /*deployer.deploy([A, B, C]).then(() => {

  });*/
  deployer.deploy(SportradarNFLAdapter, sportradar.weeks, sportradar.homeTeams, sportradar.ids);
  //deployer.deploy(Requester);
};
