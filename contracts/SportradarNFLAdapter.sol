pragma solidity ^0.4.18;
import "./BlockhawkNFLAdapter.sol";

contract SportradarNFLAdapter is BlockhawkNFLAdapter {
  //json(http://api.sportradar.us/nfl-ot2/games/2017/REG/9/schedule.json?api_key=93dsy2afg8cynjyk99spk73f).week.games[?(@.status="closed")][home,away,scoring][alias,home_points,away_points]
}

/*



contract SportradarNFLAdapter is BlockhawkAdapter, usingOraclize {
  event OraclizeQuery();
  event OraclizeCallback();

  enum QueryState { Invalid, Pending, Complete }
  mapping(bytes32 => QueryState) queryStates;

  function SportradarNFLAdapter() {
    //oraclize_setCustomGasPrice(4000000000 wei);
    oraclize_setProof(proofType_TLSNotary | proofStorage_IPFS);
  }

  function pathForBlockhawkId(string blockhawkId) {
    //encrypt query
    // url
    // TLSNotary
    // strConcat("", "", "")
    //json(https://api.kraken.com/0/public/Ticker?pair=ETHUSD).result.XETHZUSD.c.0
    //bytes32 rngId = oraclize_query("nested", "[URL] ['json(https://api.random.org/json-rpc/1/invoke).result.random[\"serialNumber\",\"data\"]', '\\n{\"jsonrpc\":\"2.0\",\"method\":\"generateSignedIntegers\",\"params\":{\"apiKey\":${[decrypt] BLTr+ZtMOLP2SQVXx8GRscYuXv+3wY5zdFgrQZNMMY3oO/6C7OoQkgu3KgfBuiJWW1S3U/+ya10XFGHv2P7MB7VYwFIZd3VOMI/Os8o1uJCdGGZgpR0Dkm5QoNH7MbDM0wa2RewBqlVLFGoZX1PJC+igBPNoHC4=},\"n\":1,\"min\":1,\"max\":100,\"replacement\":true,\"base\":10${[identity] \"}\"},\"id\":1${[identity] \"}\"}']", gasForOraclize);
  }

  function getScore(string blockhawkId) payable {
    //oraclize_getPrice("URL") > this.balance
    OraclizeQuery();
    // gasLimit = 500000;
    bytes32 queryId = oraclize_query("URL", pathForBlockhawkId(blockhawkId), gasLimit);
    queryStates[queryId] = QueryState.Pending;
  }

  function __callback(bytes32 queryId, string result, bytes proof) {
    require(queryStates[queryId] == QueryState.Pending);
    require(msg.sender == oraclize_cbAddress());
    OraclizeCallback();
    queryStates[queryId] = QueryState.Complete;
  }
}*/
