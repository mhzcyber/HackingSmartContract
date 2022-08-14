// SPDX-License-Identifier: MIT
pragma solidity ^0.8.11;

import "hardhat/console.sol";


contract ReentrancyBank{
    mapping(address => uint) public balances;

    function deposit() public payable{
        balances[msg.sender] += msg.value;
    }

    function withdraw() public{
        uint bal = balances[msg.sender];
        require(bal > 0);

        console.log("");
        console.log("EtherBank balance: ", address(this).balance);
        console.log("Attacker balance: ", balances[msg.sender]);
        console.log("");

        (bool sent, ) = msg.sender.call{value: bal}("");
        require(sent, "Failed to send eth");

        balances[msg.sender] = 0;
    }

    function getBalance() public view returns(uint){
        return address(this).balance;
    }
}
