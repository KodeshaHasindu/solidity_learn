// SPDX-License-Identifier: MIT
pragma solidity 0.8.22;

contract Array{

    int[] number;

    function addNumber(int _number) public {
        number.push(_number);
    }
    function getnumber() public view returns(int[] memory){
        return number;
    }

    
}
