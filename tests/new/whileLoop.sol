// SPDX-License-Identifier: MIT
pragma solidity 0.8.22;

contract whileLoop{

    function count(int number) public pure returns(int){
       int i = 0;
        while(i < 10){
            number++;
            i++;
        }
        return number;
    }
}