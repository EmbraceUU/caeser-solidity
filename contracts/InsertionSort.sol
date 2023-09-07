// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

contract InsertionSort {
    // if else
    function ifElse(uint256 _number) public pure returns(bool) {
        if (_number == 0) {
            return (false);
        } else {
            return (true);
        }
    }

    // for loop
    function forLoop() public pure returns (uint256) {
        uint256 a = 0;
        for (uint i=1; i<11; i++) {
            a += i;
        }
        return (a);
    }

    // while
    function whileTest() public pure returns (uint256) {
        uint256 a = 0;
        uint i = 0;
        while (i<10) {
            a += i;
            i++;
        }
        return (a);
    }

    // do-while
    function doWhileTest() public pure returns (uint256) {
        uint256 a = 0;
        uint i = 0;
        do {
            a += i;
            i++;
        } while (i<11);
        return (a);
    }

    // 三元运算符 ternary/conditional operator
    function ternaryTest(uint256 x, uint256 y) public pure returns(uint256){
        // return the max of x and y
        return x >= y ? x: y; 
    }

    // 因为 j 会取到 -1, 所以 uint 会报异常
    function insertionSortW(uint[] memory a) public pure returns (uint[] memory) {
        for (uint i=1; i<a.length; i++) {
            uint temp = a[i];
            uint j = i-1;
            while (j>=0 && temp < a[j]) {
                a[j+1] = a[j];
                j--;
            }
            a[j+1] = temp;
        }
        return (a);
    }

    function insertionSortT(uint[] memory a) public pure returns (uint[] memory) {
        for (uint i=1; i<a.length; i++) {
            uint temp = a[i];
            uint j = i;
            while (j>=1 && temp < a[j-1]) {
                a[j] = a[j-1];
                j--;
            }
            a[j] = temp;
        }
        return (a);
    }
}