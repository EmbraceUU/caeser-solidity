// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.4;

contract ValueTypes {

    // address
    address public _addr = 0x7A58c0Be72BE218B41C608b7Fe7C5bB630736C71;
    address payable public _payaddr = payable(_addr);
    uint256 public _balance = _payaddr.balance;


    // bytes
    bytes32 public _bytes32 = "MiniSolidity";
    bytes1 public _bytes1 = _bytes32[0];


    // enum
    enum ActionSet { Buy, Sell, Hold}
    ActionSet action = ActionSet.Buy;

    function enumToUint() external view returns(uint) {
        return uint(action);
    }
}