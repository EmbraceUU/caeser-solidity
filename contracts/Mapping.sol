// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

contract MappingTypes {
    mapping(uint => address) public idToAddress;
    mapping(address => address) public swapPair;

    // mapping 可以嵌套, 但是查询的时候需要传入两个参数, 一个是外层mapping的key, 一个是内层mapping的key
    mapping(uint => mapping(uint => address)) public idToMap;
    

    // key 不可以是 struct类型

    function writeValue(uint _Key, address _Value) public {
        idToAddress[_Key] = _Value;
    }
}