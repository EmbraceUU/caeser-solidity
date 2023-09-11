// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

contract OtherContract {

    uint256 private _x = 0; // 状态变量x
    // 收到eth事件，记录amount和gas
    event Log(uint amount, uint gas);

    // 当调用不存在的函数时，被调用合约没有实现fallback，call 会失败
    fallback() external payable{}
    receive() external payable {}

    // 返回合约ETH余额
    function getBalance() view public returns(uint) {
        return address(this).balance;
    }

    // 可以调整状态变量_x的函数，并且可以往合约转ETH (payable)
    function setX(uint256 x) external payable{
        _x = x;
        // 如果转入ETH，则释放Log事件
        if(msg.value > 0){
            emit Log(msg.value, gasleft());
        }
    }

    // 读取x
    function getX() external view returns(uint256 x){
        x = _x;
    }
}

contract Call {

    event Response(bool success, bytes data);

    function callSetX(address payable _addr, uint256 x) external payable {
        // 因为参数类型写成uint，所以没有调用成功
        (bool success, bytes memory data) = _addr.call{value: msg.value}(
            abi.encodeWithSignature("setX(uint256)", x)
        );

        // 也可以只包含 {}，并且 value 可以带单位
        _addr.call{gas: 1000000, value: 1 ether};

        emit Response(success, data);
    }

    function callGetX(address _addr) external returns(uint256) {
        (bool success, bytes memory data) = _addr.call(
            abi.encodeWithSignature("getX()")
        );

        emit Response(success, data);

        // 使用 abi.decode 解码
        return abi.decode(data, (uint256));
    }

    function callNotExist(address _addr) external  {
        (bool success, bytes memory data) = _addr.call(
            abi.encodeWithSignature("foo(uint)", 0)
        );

        emit Response(success, data);
    }
}