// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

contract Pair {
    address public factory;
    address public token0;
    address public token1;

    constructor() payable {
        // 工厂合约地址
        factory = msg.sender;
    }

    function initialize(address _token0, address _token1) external {
        require(msg.sender == factory, 'UniswapV2: FORBIDDEN');
        token0 = _token0;
        token1 = _token1;
    }
}

contract PairFactory {
    // 通过两个代币地址查Pair地址
    mapping(address => mapping(address => address)) public getPair;
    // 保存所有Pair地址
    address[] public allPairs;

    // 可以增加逻辑控制Pair创建数量
    function createPair(address _token0, address _token1) external returns(address pairAddrs) {
        // 创建新合约
        Pair p = new Pair();
        // 调用新合约的initialize方法
        p.initialize(_token0, _token1);
        // 获取合约地址
        pairAddrs = address(p);
        getPair[_token0][_token1] = pairAddrs;
        getPair[_token1][_token0] = pairAddrs;
        allPairs.push(pairAddrs);
    }
}