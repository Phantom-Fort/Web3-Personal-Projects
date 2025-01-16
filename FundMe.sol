// SPDX-License-Identifier: MIT

pragma solidity ^0.8.26;

contract FundMe {

    uint256 public minimumUsd = 5;

    function fund() public payable {
    // allow users send $
    // have a minimum $ sent
    // How do we send eth to this contract?
    require(msg.value > 1e18, "didn't send enough ETH"); // 1e18 = 1 ETH
    }


    // function withdraw() public {}
}