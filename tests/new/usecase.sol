// SPDX-License-Identifier: MIT
pragma solidity 0.8.22;

contract usecase{

    mapping(address => uint) balance;
  address owner;

   modifier onlyOwner{
    require(msg.sender == owner);
    _;
  }

    constructor(){
    owner = msg.sender;
  }

  function addBlance(uint _toAdd) public returns (uint){
     balance[msg.sender] += _toAdd;
    return balance[msg.sender];
  }

  function getBlance(address user) public onlyOwner view returns (uint){
    return balance[user];
  }
  

}