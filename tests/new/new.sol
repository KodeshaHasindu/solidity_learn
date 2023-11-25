// SPDX-License-Identifier: MIT
pragma solidity ^0.8.22;

import "@openzeppelin/contracts/utils/cryptography/MerkleProof.sol";

contract Bank{
    mapping(address => uint) public depositFund;
    mapping (address => uint) public withdrawlFund;

    address internal owner;

    event depositedFund(uint amount, address indexed depositedOwner);
    event withdrawalFund(uint amount, address indexed  withdrawalOwner);

    modifier onlyOwner(){
        require(msg.sender == owner, "Not Allow");
        _;
    }

    modifier isWithdraw(uint amount) {
        uint previousWithdrawal = withdrawlFund[msg.sender];
        require(depositFund[msg.sender] - previousWithdrawal >= amount, "Insufficient Account Balance");
        _;
    }

    constructor (bytes32 _merkleRoot){
        merkleRoot = _merkleRoot ;
    owner = msg.sender;
    } 
        
    function deposite() public onlyOwner payable {
        depositFund[msg.sender] += msg.value;
        emit depositedFund(msg.value, msg.sender);
    }

    function withdrawal(uint _amount) public onlyOwner isWithdraw(_amount) {
        withdrawlFund[msg.sender] += _amount;

        emit withdrawalFund(_amount, msg.sender);

    }

    function getBalance() public view returns (uint balance){
        return depositFund[msg.sender] - withdrawlFund[msg.sender];
    }

    address public test;
    bytes32 public merkleRoot;


function claim(bytes32[] memory _proof) public {
  bytes32 leaf = keccak256(abi.encodePacked(msg.sender));
require(MerkleProof.verify(_proof, merkleRoot, leaf), "Invalid Merkle Proof." );
test = msg.sender;
}

}


//[0x999bf57501565dbd2fdcea36efa2b9aef8340a8901e3459f4a4c926275d36cdb,0x5931b4ed56ace4c46b68524cb5bcbf4195f1bbaacbe5228fbd090546c88dd229]

//0x9d997719c0a5b5f6db9b8ac69a988be57cf324cb9fffd51dc2c37544bb520d65