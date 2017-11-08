pragma solidity ^0.4.18;
import "oraclize/usingOraclize.sol";
import "zeppelin-solidity/contracts/ownership/Ownable.sol";

contract BlockhawkNFLAdapter is Ownable, usingOraclize {
  mapping(bytes3 => bytes32)[17] public idForWeekAndHomeTeam;
  mapping(bytes32 => string) public stringForId;

  function BlockhawkNFLAdapter(uint8[] _weeks, bytes3[] _homeTeams, bytes32[] _ids) public {
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

  function setEncryptedApiKey(string apiKey) external onlyOwner {

  }
}
