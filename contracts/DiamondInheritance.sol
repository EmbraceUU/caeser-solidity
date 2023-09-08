// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

/* 继承树：
  God
 /  \
Adam Eve
 \  /
people
*/

contract God {
    event Log(string log);

    function foo() public virtual {
        emit Log("God.foo call");
    }

    function bar() public virtual {
        emit Log("God.bar call");
    }
}

contract Adam is God {
    function foo() public virtual override  {
        emit Log("Adam.foo call");
    }

    function bar() public virtual override {
        emit Log("Adam.bar call");
        super.bar();
    }
}

contract Eve is God {
    function foo() public virtual override {
        emit Log("Eve.foo called");
    }

    function bar() public virtual override {
        emit Log("Eve.bar called");
        super.bar();
    }
}

contract People is Adam, Eve {
    // 会执行Eve
    function foo() public override(Adam, Eve) {
        super.foo();
    }

    // 会执行Eve，Adam，God
    function bar() public override(Adam, Eve) {
        super.bar();
    }
}