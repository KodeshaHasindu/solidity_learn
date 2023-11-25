// SPDX-License-Identifier: MIT
pragma solidity 0.8.22;

contract Bank{

  mapping(address => uint) balance;

  address owner;

  event depositDone(uint amount, address depositedTo);

  modifier onlyOwner{
    require(msg.sender == owner);
    _;//run the function
  }

  constructor(){
    owner = msg.sender;
  }

  function deposit() public payable  returns (uint){
     balance[msg.sender] += msg.value;
     emit depositDone(msg.value, msg.sender);
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
