// SPDX-License-Identifier: MIT
pragma solidity 0.8.22;

contract whileLoop{

    function count(int number) public pure returns(int){
      for (int i=0;i<10;i++){
      number++;
        }
     return number;
     }
}
