// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.4;

import "remix_tests.sol"; // this import is automatically injected by Remix.
//import "remix_accounts.sol";
import "../contracts/Billboard.sol";

// File name has to end with '_test.sol', this file can contain more than one testSuite contracts
contract testSuite {
    
    Billboard billboard;
    
    string[] names = ["n0","n1","n2","n3","n4","n5","n6","n7","n8","n9","n10","n11","n12","n13"];
    uint[] starAppIds = [10, 4, 5, 6, 2];
    uint8[] appStars = [5, 4, 3, 2, 1];

    /// 'beforeAll' runs before all other tests
    /// More special functions are: 'beforeEach', 'beforeAll', 'afterEach' & 'afterAll'
    function beforeAll() public {
        billboard = new Billboard();
        for(uint i=0; i<names.length;i++){
            billboard.publish(names[i]);
        }
        for(uint i=0; i<starAppIds.length;i++){
            billboard.star(starAppIds[i], appStars[i]);
        }
    }

    function checkStar() public {
        for(uint i=0; i<starAppIds.length; i++){
            (,,uint appTotalStar) = billboard.apps(starAppIds[i]);
            Assert.equal(appTotalStar, appStars[i], "star error message. ");
        }
    }

    function checkTop() public {
        uint[] memory topAppIds = billboard.top();
        for(uint i=0; i<starAppIds.length;i++){
            Assert.equal(topAppIds[i], starAppIds[i], "top error message. ");
        }
    }
}
