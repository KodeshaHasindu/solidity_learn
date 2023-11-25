// SPDX-License-Identifier: MIT
pragma solidity 0.8.22;

contract Bank{

  mapping(address => uint) balance;

  function addBlance(uint _toAdd) public returns (uint){
    balance[msg.sender] += _toAdd;
    return balance[msg.sender];
  }

  function getBlance() public view returns (uint){
    return balance[msg.sender];
  }

    function transfer(address recipient, uint amount) public {
        //check balance of msg.sender

        _transfer(msg.sender, recipient, amount);

        //event logs and further checks
    }

    function _transfer(address from, address to, uint amount) private {
        balance[from] -= amount;
        balance[to] += amount;
    }


}
