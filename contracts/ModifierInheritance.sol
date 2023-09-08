// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

contract Base {

    // 检查数值是否能被2和3整除
    modifier exactDividedBy2And3(uint d) virtual {
        require(d % 2 == 0 && d % 3 == 0);
        _;
    }
}

contract Identifier is Base {

    //计算一个数分别被2除和被3除的值，但是传入的参数必须是2和3的倍数
    function getExactDividedBy2And3(uint d) public exactDividedBy2And3(d) pure returns (uint, uint) {
        return getExactDividedBy2And3WithoutModifier(d);
    }

    //计算一个数分别被2除和被3除的值
    function getExactDividedBy2And3WithoutModifier(uint d) internal pure returns (uint, uint) {
        uint d2 = d / 2;
        uint d3 = d / 3;
        return (d2, d3);
    }

    // 重写检查逻辑
    // modifier exactDividedBy2And3(uint d) override {
    //     _;
    // }
}