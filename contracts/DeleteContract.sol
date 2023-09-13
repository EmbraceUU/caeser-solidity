// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

contract DeleteContract {
    // selfdestruct: 删除合约，并强制将合约剩余的ETH转入指定账户
    uint public value = 10;

    constructor() payable {}

    receive() external payable {}

    // 0.8.18 以后废弃了
    function deleteContract() external {
        // 自毁，并将ETH转给发起者
        selfdestruct(payable(msg.sender));
    }

    function balanceOf() external view returns(uint) {
        return address(this).balance;
    }
}