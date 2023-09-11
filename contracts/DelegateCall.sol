// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

// delegatecall和call类似，都是低级函数
// call: B call C, 上下文为 C (msg.sender = B, C中的状态变量受影响)
// delegatecall: B delegatecall C, 上下文为B (msg.sender = A, B中的状态变量受影响)
// 注意B和C的数据存储布局必须相同！变量类型、声明的前后顺序要相同，不然会搞砸合约。

contract C {
    uint256 public num;
    address public sender;

    function setVars(uint256 _num) external payable {
        num = _num;
        sender = msg.sender;
    }
}

contract B {
    uint256 public num;
    address public sender;
    address public callAddr;

    event Response(bool success, bytes data);

    function setCallAddr(address addr) external {
        callAddr = addr;
    }

    function callSetVars(uint256 _num) external payable {
        (bool success, bytes memory data) = callAddr.call(
            abi.encodeWithSignature("setVars(uint256)", _num)
        );

        emit Response(success, data);
    }

    function delegateCallSetVars(uint256 _num) external payable {
        (bool success, bytes memory data) = callAddr.delegatecall(
            abi.encodeWithSignature("setVars(uint256)", _num)
        );

        emit Response(success, data);
    }
}