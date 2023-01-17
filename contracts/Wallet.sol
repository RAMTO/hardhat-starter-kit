// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

// Import this file to use console.log
import 'hardhat/console.sol';

contract Wallet {
    address payable public owner;

    mapping(address => uint256) public userBalance;

    constructor() {
        owner = payable(msg.sender);
    }

    function deposit() public payable {
        userBalance[msg.sender] += msg.value;
    }

    function withdraw() public {
        require(userBalance[msg.sender] > 0, 'Not enough funds');
        (bool sent, bytes memory data) = msg.sender.call{ value: userBalance[msg.sender] }('');
        require(sent, 'Failed to send Ether');
        userBalance[msg.sender] = 0;
    }
}
