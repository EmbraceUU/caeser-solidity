// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

contract ArrayTypes {
    // 固定长度
    uint[8] array1;
    bytes1[5] array2;
    address[100] array3;

    // 动态数组
    uint[] public array4;
    bytes1[] array5;
    address[] array6;
    bytes array7;

    // 初始化
    uint[] array8 = new uint[](5);
    bytes array9 = new bytes(9);

    // 初始化动态数组
    function initArray() external pure returns(uint[] memory) {
        uint[] memory x = new uint[](3);
        x[0] = 1;
        x[1] = 2;
        x[2] = 3;
        return x;
    }

    function arrayPush() external returns(uint[] memory) {
        // 声明的是内存变量
        uint[2] memory a = [uint(1), 2];
        // 赋值, 影响了 storage 变量
        array4 = a;
        array4.push(3);
        // 修改 memory 变量, 不会影响 storage 变量
        a[0] = 1000;
        return array4;
    }
}

contract StatusTypes {
    // 结构体 Struct
    struct Student{
        uint256 id;
        uint256 score; 
    }
    Student student; // 初始一个student结构体

    function initStudent1() external {
        Student storage _student = student; // assign a copy of student
        _student.id = 11;
        _student.score = 100;
    }

     // 方法2:直接引用状态变量的struct
    function initStudent2() external{
        student.id = 1;
        student.score = 80;
    }

    // 方法3:构造函数式
    function initStudent3() external {
        student = Student(3, 90);
    }

    // 方法4:key value
    function initStudent4() external {
        student = Student({id: 4, score: 60});
    }
}