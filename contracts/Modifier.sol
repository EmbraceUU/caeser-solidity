// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

contract Owner {
    address public owner ;

    // 只能定义一个构造函数
    constructor() {
        // 在部署合约的时候，将owner设置为部署者的地址
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner); // 检查调用者是否为owner地址
        _; // 如果是的话，继续运行函数主体；否则报错并revert交易
    }

    function changeOwner(address _address) external onlyOwner {
        owner = _address; // 只有owner地址运行这个函数，并改变owner
    }
}