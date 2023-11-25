// SPDX-License-Identifier: MIT
pragma solidity ^0.8.22;

import "@openzeppelin/contracts/utils/cryptography/MerkleProof.sol";

contract NFTMint {
    address public test;
  bytes32 public merkleRoot;

  constructor(bytes32 _merkleRoot) {
    merkleRoot = _merkleRoot;
  }

  function claim(bytes32[] memory _proof) public  {
    bytes32 leaf = keccak256(abi.encodePacked(msg.sender));
    require(MerkleProof.verify(_proof, merkleRoot, leaf), "Invalid proof");
    test = msg.sender;
    // User is in the whitelist, allow them to claim the NFT

  }
}