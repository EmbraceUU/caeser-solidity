// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

contract InitialValues {
    // 值类型初始值
    bool public _bool;
    int public _int;
    uint public _uint;
    address public _addr;
    string public _string;
    bytes1 public _bytes1; // 0x00

    enum ActionType {Buy, Sell, Hold}
    ActionType public _action;

    function fe() external {}
    function fi() internal {}

    // 引用类型初始值
    uint[8] public _uint8; // [0,0,0,0,0,0,0,0], out of bound will be revert.
    uint[] public _uints; // [], 查询会被 revert
    mapping(uint => address) public _map;
    struct Student{
        uint256 id;
        uint256 score; 
    }
    Student public student;

    // delete 操作, 会将变量置为初始值
    bool public _bool2 = true;
    function del() external {
        delete _bool2;
    }

    string  public _strings = "true";
    function d() external returns(address){
        delete _addr;
        return _addr;
    }

    mapping(address => uint256) private _balances;
    function balanceOf(address _Key) external view returns (uint256) {
        return _balances[_Key];
    }
}