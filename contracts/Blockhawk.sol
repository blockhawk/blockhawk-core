pragma solidity ^0.4.18;
import "github.com/oraclize/ethereum-api/oraclizeAPI.sol";
import "github.com/OpenZeppelin/zeppelin-solidity/contracts/ownership/Ownable.sol";

contract BlockhawkNFLAdapter is usingOraclize {
    event OraclizeQuery(bytes32 queryId);
    event OraclizeCallback(bytes32 queryId, string result, bytes proof);

    enum QueryState { Unknown, Pending, Complete }
    struct Query {
        bytes3 homeTeam;
        QueryState state;
    }
    mapping(bytes32 => Query) queries;

    function BlockhawkNFLAdapter() public {
        //oraclize_setCustomGasPrice(4000000000 wei);
        //other storage options cheaper? maybe just log proof
        //oraclize_setProof(proofType_TLSNotary | proofStorage_IPFS);
    }

    // ABSTRACT FUNCTIONS
    function jsonPathForWeek(uint8 week) returns (string);
    function handleResult(string result, bytes3 homeTeam);

    function getScore(uint8 week, bytes3 homeTeam) payable public {
        //require enough money: oraclize_getPrice("URL") > this.balance maybe
        //gasLimit = 500000;
        bytes32 queryId = oraclize_query("URL", jsonPathForWeek(week)/*, gasLimit*/);
        OraclizeQuery(queryId);
        queries[queryId] = Query(homeTeam, QueryState.Pending);
    }

    function __callback(bytes32 queryId, string result, bytes proof) public {
        require(queries[queryId].state == QueryState.Pending);
        require(msg.sender == oraclize_cbAddress());
        OraclizeCallback(queryId, result, proof);
        Query query = queries[queryId];
        query.state == QueryState.Complete;
        handleResult(result, query.homeTeam);
    }
}

contract SportradarNFLAdapter is BlockhawkNFLAdapter {
    function jsonPathForWeek(uint8 week) returns (string) {
        //encrypt apiKey, strConcat
        //bytes32 rngId = oraclize_query("nested", "[URL] ['json(https://api.random.org/json-rpc/1/invoke).result.random[\"serialNumber\",\"data\"]', '\\n{\"jsonrpc\":\"2.0\",\"method\":\"generateSignedIntegers\",\"params\":{\"apiKey\":${[decrypt] BLTr+ZtMOLP2SQVXx8GRscYuXv+3wY5zdFgrQZNMMY3oO/6C7OoQkgu3KgfBuiJWW1S3U/+ya10XFGHv2P7MB7VYwFIZd3VOMI/Os8o1uJCdGGZgpR0Dkm5QoNH7MbDM0wa2RewBqlVLFGoZX1PJC+igBPNoHC4=},\"n\":1,\"min\":1,\"max\":100,\"replacement\":true,\"base\":10${[identity] \"}\"},\"id\":1${[identity] \"}\"}']", gasForOraclize);
        return "json(http://api.sportradar.us/nfl-ot2/games/2017/REG/9/schedule.json?api_key=93dsy2afg8cynjyk99spk73f).week.games[?(@.status=\"closed\")][home,away,scoring][alias,home_points,away_points]";
    }

    function handleResult(string result, bytes3 homeTeam) {

    }
}

contract Blockhawk is Ownable {
    BlockhawkNFLAdapter[] adapters;

    function Blockhawk() public {
        adapters.push(new SportradarNFLAdapter());
    }

    function getScore(uint8 week, bytes3 homeTeam) payable external {
        //string url = urlForWeek(week);
        for(uint i = 0; i < adapters.length; i++) {
            adapters[i].getScore(week, homeTeam);
        }
    }

    function __blockhawkCallback(string result) {

    }
}

contract MockRequester {

}
