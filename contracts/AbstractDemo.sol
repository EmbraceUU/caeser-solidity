// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

abstract contract Base {
    string public name = "Base";

    // 必须有 virtual
    function getAlias() public pure virtual returns(string memory);
}

contract BaseImpl is Base {
    // override
    function getAlias() public pure override returns(string memory) {
        return "BaseImpl";
    }
}