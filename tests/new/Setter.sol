// SPDX-License-Identifier: MIT
pragma solidity 0.8.22;

contract Setter{

    int number;

    function getnumber() public view returns(int){
        return number;
    }
     function setnumber(int _number) public {
        number = _number;
     }
}
