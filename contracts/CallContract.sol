// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

interface IOtherContract {
    function getBalance() external returns(uint);
    function setX(uint256 x) external payable;
    function getX() external view returns(uint x);
}

contract OtherContract is IOtherContract {
    uint256 private _x = 0; // 状态变量x

    event Log(uint amount, uint gas);

    // 返回合约ETH余额
    function getBalance() external view override returns(uint) {
        return address(this).balance;
    }

    // 可以调整状态变量_x的函数，并且可以往合约转ETH (payable)
    function setX(uint256 x) external override payable{
        _x = x;
        if(msg.value > 0){
            emit Log(msg.value, gasleft());
        }
    }

    function getX() external view override returns(uint x){
        x = _x;
    }
}

contract CallContract{
    event Log(uint amount, uint gas);

    function callSetX(address _Addr, uint x) external {
        OtherContract(_Addr).setX(x);
    }

    function callGetX(OtherContract _Addr) external view returns(uint) {
        return _Addr.getX();
    }

    function callGetX2(address _Addr) external view returns(uint) {
        // 这里没有 new 
        // 如果有接口，使用接口也可以
        // IOtherContract o = IOtherContract(_Addr);
        OtherContract o = OtherContract(_Addr);
        return o.getX();
    }

    function callGetX3(address _Addr) external view returns(uint) {
        // 这里没有 new 
        // 如果有接口，使用接口也可以
        IOtherContract o = IOtherContract(_Addr);
        return o.getX();
    }

    function setXTransferETH(address _Addr, uint x) external payable {
        // 使用 msg.value 获取ETH数量
        // ETH 被转到了 _Addr 合约上，没有被 当前的合约接受
        OtherContract(_Addr).setX{value: msg.value}(x);

        // 这里的 log 没有被监听到
        emit Log(x, gasleft());
    }
}

contract MyContract {
    OtherContract other = OtherContract(0x81fc54CBb25855Bf8Cd172643BA55dc32d9053C2);
    
    function call_getX() external view returns(uint x){
        x = other.getX();
    }

    // 有安全隐患
    function call_setX(uint256 x) external{
        other.setX(x);
    }
}