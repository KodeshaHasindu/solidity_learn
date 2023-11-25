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

    constructor() {
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

    bytes32 public markleRoot = 0x9d997719c0a5b5f6db9b8ac69a988be57cf324cb9fffd51dc2c37544bb520d65;

    mapping (address=> bool) public whitelistClaimed;
    
    function whitelistMint(bytes32[] memory _merkaleProof) public {
        require(!whitelistClaimed[msg.sender], "Address already claimed");

        bytes32 leaf = keccak256(abi.encode(msg.sender));

        require(
            MerkleProof.verify(_merkaleProof, markleRoot, leaf), 
        "Invalid Merkle Proof."
        );

        whitelistClaimed[msg.sender] = true;
    }
}


// [
//   "0x1c22adb6b75b7a618594eacef369bc4f0ec06380e8630fd7580f9bf0ea413ca8",
//   "0x0befebd5f6f5e8b5f7ec6935245efbd76ce396aedac1b12781a64df01b75aab7",
//   "0xeeefd63003e0e702cb41cd0043015a6e26ddb38073cc6ffeb0ba3e808ba8c097"
// ]