// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

contract Events {
    mapping (address => uint256) public _balance;

    event Transfer(address indexed from, address indexed to, uint256 amount);

    function _transfer(address to, uint256 amount) external {
        _balance[msg.sender] = 1000000;
        _balance[msg.sender] -= amount;
        _balance[to] += amount;

        emit Transfer(msg.sender, to, amount);
    }
}