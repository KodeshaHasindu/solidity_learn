// SPDX-License-Identifier: MIT
pragma solidity 0.8.22;

contract Bank{

  mapping(address => uint) balance;
  address owner;

  constructor(){
    owner = msg.sender;
  }

  function addBlance(uint _toAdd) public returns (uint){
    require(msg.sender == owner);
    balance[msg.sender] += _toAdd;
    return balance[msg.sender];
  }

  function getBlance() public view returns (uint){
    return balance[msg.sender];
  }

    function transfer(address recipient, uint amount) public {
        require(balance[msg.sender] >= amount, "Balance not sufficient");
        require(msg.sender != recipient, "Don't transfer money to yourself");

        uint previousSenderBalance = balance[msg.sender];

        _transfer(msg.sender, recipient, amount);

        assert(balance[msg.sender] == previousSenderBalance - amount);
    }

    function _transfer(address from, address to, uint amount) private {
        balance[from] -= amount;
        balance[to] += amount;
    }


}
