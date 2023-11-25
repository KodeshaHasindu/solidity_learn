// SPDX-License-Identifier: MIT
pragma solidity ^0.8.22;

contract HelloWorld {

    string message;

    constructor(string memory _message){
        message = _message;
    }

    function hello() public returns (string memory){
      
        return message;
    }   
}