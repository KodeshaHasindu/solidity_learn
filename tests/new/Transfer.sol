// SPDX-License-Identifier: MIT
pragma solidity 0.8.22;

import "./Ownable.sol";

interface GovermentInterface {
  function addTransaction(address _from, address _to, uint _amount) external;
}

contract Bank is Ownable {

  GovermentInterface govermentInstance = GovermentInterface(0x438eacEBf3F2a1c3E8560277345E83ff228355bE);

  mapping(address => uint) balance;


  event depositDone(uint amount, address indexed depositedTo);

 

  function deposit() public payable  returns (uint){
     balance[msg.sender] += msg.value;
     emit depositDone(msg.value, msg.sender);
    return balance[msg.sender];
  }

  function withdraw(uint amount) public onlyOwner returns (uint) {
    payable(msg.sender).transfer(amount);
    return balance[msg.sender];
  }

  function getBlance() public view returns (uint){
    return balance[msg.sender];
  }

    function getOwner() public view returns (address){
        return owner;
    }


    function transfer(address recipient, uint amount) public {
        require(balance[msg.sender] >= amount, "Balance not sufficient");
        require(msg.sender != recipient, "Don't transfer money to yourself");

        uint previousSenderBalance = balance[msg.sender];

        _transfer(msg.sender, recipient, amount);
        govermentInstance.addTransaction(msg.sender, recipient,amount );

        assert(balance[msg.sender] == previousSenderBalance - amount);
    }

    function _transfer(address from, address to, uint amount) private {
        balance[from] -= amount;
        balance[to] += amount;
    }


}
