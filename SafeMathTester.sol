// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract SafeMathTester{
    uint8 public bignumber = 255; // checked

    function addUnchecked() public {
        unchecked {bignumber = bignumber + 1;}
    }

    function addChecked() public {
        bignumber = bignumber + 1;
    }
}