// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "contracts/ERC20.sol";

contract Faucet {
    uint256 public amountAllowed = 100; // 每次领 100单位代币
    address public tokenContract;   // token合约地址

    mapping(address => bool) public requestedAddress;   // 记录领取过代币的地址

    event SendToken(address indexed Receiver, uint256 indexed Amount); 

    // 部署时设定ERC2代币合约
    constructor(address _tokenContract) {
        tokenContract = _tokenContract; // set token contract
    }

    function requestTokens() external {
        require(!requestedAddress[msg.sender], "Can't request Multiple Times!");
        IERC20 token = IERC20(tokenContract);
        require(token.balanceOf(address(this)) >= amountAllowed, "Faucet Empty!");

        token.transfer(msg.sender, amountAllowed);
        requestedAddress[msg.sender] = true;

        emit SendToken(msg.sender, amountAllowed);
    }
}