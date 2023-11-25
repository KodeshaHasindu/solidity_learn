// SPDX-License-Identifier: MIT
pragma solidity ^0.8.22;
pragma abicoder v2;

//["0x5B38Da6a701c568545dCfcB03FcB875f56beddC4","0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2","0x4B20993Bc481177ec7E8f571ceCaE8A9e22C02db"]

contract Wallet {
    address[] public owners;
    uint limit;

    struct Transfer {
        uint amount;
        address payable receiver;
        uint approvals;
        bool hasBeenSent;
        uint id;
    }

    event TransferRequestsCreated(uint _id, uint _amount, address _initiator, address _receiver);
    event ApprovalReceived(uint _id, uint _approvals, address _approver);
    event TransferApproved(uint _id);

    Transfer[] transferRequests;

    mapping(address => mapping(uint => bool)) approvals;

    mapping (address => uint)balance;

    modifier onlyOwners() {
        bool owner = false;
        for(uint i=0; i<owners.length;i++){
            if(owners[i] == msg.sender){
                owner = true;
            }
        }
        require(owner == true);
        _;
    }


    constructor(address[] memory _owners, uint _limit) {
        owners = _owners;
        _limit = _limit;
    }

    function deposit() public payable {}

    function createTransfer(uint _amount, address payable _receiver) public onlyOwners {
        emit TransferRequestsCreated(transferRequests.length, _amount, msg.sender, _receiver);
        transferRequests.push(
            Transfer(_amount, _receiver, 0, false, transferRequests.length)
        );
    }
    function getBlance() public view returns (uint){
    return balance[msg.sender];
    }
  

    function approve(uint _id) public onlyOwners {
        require(approvals[msg.sender][_id] == false);
        require(transferRequests[_id].hasBeenSent == false);

        approvals[msg.sender][_id] = true;
        transferRequests[_id].approvals++;

        emit ApprovalReceived(_id, transferRequests[_id].approvals, msg.sender);
   

   if(transferRequests[_id].approvals >= limit){
    transferRequests[_id].hasBeenSent = true;
    transferRequests[_id].receiver.transfer(transferRequests[_id].amount);
    emit TransferApproved(_id);
   }
    }

    function getTransferRequests() public view returns (Transfer[] memory) {
        return transferRequests;
    }
}
