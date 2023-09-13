// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

contract ABIEncode {
    uint x = 10;
    address addr = 0x7A58c0Be72BE218B41C608b7Fe7C5bB630736C71;
    string name = "0xAA";
    uint[2] array = [5, 6]; 

    function encode() external view returns (bytes memory result) {
        result = abi.encode(x, addr, name, array);
    }

    function encodePack() external view returns (bytes memory result) {
        result = abi.encodePacked(x, addr, name, array);
    }

    // encodeWithSignature 和 encodeWithSelector 返回结果一致
    function encodeWithSignature() external view returns (bytes memory result) {
        result = abi.encodeWithSignature("foo(uint256,address,string,uint256[2])", x, addr, name, array);
    }

    function encodeWithSelector() external view returns (bytes memory result) {
        result = abi.encodeWithSelector(bytes4(keccak256("foo(uint256,address,string,uint256[2])")), x, addr, name, array);
    }

    // 将 encode 数据传入，返回4个状态变量的值
    function decode(bytes memory data) external pure returns (uint, address, string memory, uint[2] memory) {
        return abi.decode(data, (uint, address, string, uint[2]));
    }
}