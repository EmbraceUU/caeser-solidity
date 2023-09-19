// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "./ERC20.sol";

contract Airdrop {
    mapping (address => uint) failTransferList;

    function multiTransferToken(
        address _token,
        address[] calldata _addresses,
        uint256[] calldata _amounts
    ) external {
        // 先检查参数合法
        require(_addresses.length == _amounts.length, "Lengths of Addresses and Amounts NOT EQUAL");
        ERC20 token = ERC20(_token);
        uint _amountSum = getSum(_amounts); // 计算空投代币总量

        // 判断授权额度
        require(
            token.allowance(msg.sender, address(this)) >= _amountSum,
            "Need Approve ERC20 token"
        );

        for (uint i = 0; i< _addresses.length; i++) {
            // 授权转账
            token.transferFrom(msg.sender, _addresses[i], _amounts[i]);
        }
    }

    function multiTransferETH (
        address payable[] calldata _addresses,
        uint256[] calldata _amounts
    ) external payable {
        // 检查参数合法
        require(_addresses.length == _amounts.length, "Lengths of Addresses and Amounts NOT EQUAL");
        // 获取总量
        uint256 _amountSum = getSum(_amounts);

        // 检查转入金额
        require(msg.value >= _amountSum, "");

        for (uint i = 0; i<_addresses.length; i++) {
            (bool success,) = _addresses[i].call{value: _amounts[i]}("");
            if (!success) {
                failTransferList[_addresses[i]] = _amounts[i];
            }
        }
    }

    // 给空投失败提供主动操作机会
    function withdrawFromFailList(address _to) public {
        uint failAmount = failTransferList[msg.sender];
        require(failAmount > 0, "You are not in failed list");
        failTransferList[msg.sender] = 0;
        (bool success, ) = _to.call{value: failAmount}("");
        require(success, "Fail withdraw");
    }

    function getSum(uint256[] calldata _amounts) public pure returns (uint256 sum) {
        for (uint i = 0; i < _amounts.length; i++) {
            sum += _amounts[i];
        }
    }
}