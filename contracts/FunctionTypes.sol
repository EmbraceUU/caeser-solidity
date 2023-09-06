// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.4;

contract FunctionTypes {
    uint256 public number = 5;

    // 产生了 transaction
    function add() external {
        number = number + 1;
    }

    // 不产生 transaction, 并且不可以 read / write 合约
    function addPure(uint256 _number) external pure returns(uint256 new_number) {
        new_number = _number + 1;
    }

    // // 不产生 transaction, 可以 read 但不能 wirte
    function addView() external view returns(uint256 new_number) {
        new_number = number + 1;
    }

    // 只能内部调用, 可继承
    function minus() internal {
        number = number - 1;
    }

    // 可以外部调用
    function minusCall() external {
        minus();
    }

    // 带有 payable 的函数, 可以给合约转 ETH
    function minusPayable() external payable {
        minus();
    }
}