pragma solidity ^0.4.4;

contract IcoProxy {

  address[] public managers;
  mapping (address => address) votesAddr;

  bool isLocked = false;

  function IcoProxy() {
    managers.push(0x123);
  }

  // contribute function
  function() payable {
    assert(isLocked);

    votesAddr[managers[0]].transfer(msg.value);
  }

  function setIcoAddr(address addr) isManager {
    votesAddr[msg.sender] = addr;
    lockAttemp();
  }
  
  function lockAttemp() private {
    address addr = votesAddr[managers[0]];
    bool lock = true;
    for (uint8 i = 0; i < managers.length; ++i) {
      if (votesAddr[managers[i]] == 0x0) {
        lock = false;
        break;
      }
      if (votesAddr[managers[i]] != addr) {
        lock = false;
        break;
      }
    }
    if (lock) {
      isLocked = true;
    }
  }
  
  modifier isManager() {
    for (uint8 i = 0; i < managers.length; ++i) {
      if (managers[i] == msg.sender) {
        _;
      }
    }
  }
  
}