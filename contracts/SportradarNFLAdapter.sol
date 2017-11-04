pragma solidity ^0.4.18;
import "zeppelin-solidity/contracts/ownership/Ownable.sol";

contract SportradarNFLAdapter is Ownable {
  mapping(bytes3 => bytes32)[17] public idForWeekAndHomeTeam;
  mapping(bytes32 => string) public stringForId;

  function SportradarNFLAdapter(uint8[] _weeks, bytes3[] _homeTeams, bytes32[] _ids) public {
    for (uint i = 0; i < _weeks.length; i++) {
      //string memory uuid = b32ToUUID(_ids[i]);
      addIdMapping(_weeks[i], _homeTeams[i], _ids[i]);
    }
  }

  function addIdMapping(uint8 week, bytes3 homeTeam, bytes32 id) public onlyOwner {
    idForWeekAndHomeTeam[week][homeTeam] = id;
  }

  function b32ToUUID(bytes32 x) internal pure returns (string) {
    bytes memory bytesString = new bytes(36);
    uint charCount = 0;
    uint uintX = uint(x);

    for (uint i = 0; i < 32; i++) {
      byte char = byte(bytes32(uintX * 2 ** (8 * i)));
      bytesString[charCount] = char;
      charCount++;

      if (i == 7 || i == 11 || i == 15 || i == 19) {
        bytesString[charCount] = 0x2d;
        charCount++;
      }
    }

    return string(bytesString);
  }
}

/*import "oraclize/usingOraclize.sol";

contract BlockhawkAdapter {

}

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
