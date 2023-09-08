// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

contract Grandpa {
    // 可以被继承
    event Log(string log);

    // 如果不写virtual和override，出现了一样的函数会无法编译
    function hip() public virtual {
        emit Log("Grandpa");
    }

    function pop() public virtual {
        emit Log("Grandpa");
    }

    function grandpa() public virtual {
        emit Log("Grandpa");
    }
}

contract Father is Grandpa {
    function hip() public virtual override {
        emit Log("Father");
    }

    function pop() public virtual override {
        emit Log("Father");
    }

    function father() public virtual {
        emit Log("father");
    }
}

// 可以只继承 Father，如果也继承了 Grandpa，Grandpa 要在前面
contract Sun is Grandpa, Father {

    // override 必须标明 Grandpa, Father
    function hip() public override(Grandpa, Father) {
        emit Log("Sun");
        // super 只执行了 Father，没有执行 Grandpa
        super.hip();
    }

    function pop() public override(Grandpa, Father) {
        emit Log("Sun");
    }

    // 可以通过合约直接调用
    function callParent() public {
        Grandpa.pop();
    }

    // 可以通过super调用
    function callParentSuper() public {
        // 这里 super 调用的 Father
        super.pop();
    }
}

// 抽象合约不能直接部署
abstract contract A {
    uint public a;

    constructor(uint x) {
        a = x;
    }
}

// 部署时需要传参
contract B is A(1) {

}

contract C is A {
    constructor(uint x) A(x * x) {
    
    }
}