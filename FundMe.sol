// SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;

import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";

contract FundMe {
    uint256 public minimumUsd = 5;

    function fund() public payable {
        //Allow users to send $
        // Have a mnimum of $5
        // How do we send ETH to this contract?
    require(msg.value >= minimumUsd, "didn't send enough ETH"); // 1e18 = 1ETH
    }
    // function withdraw() public {}

    function getPrice() public {
        // Address 0x694AA1769357215DE4FAC081bf1f309aDC325306
        // ABI 
        AggregatorV3Interface pricefeed = AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306);
        (,int256 price,,,) = pricefeed.latestRoundData();
        // returns price of ETH in terms of USD
        // 2000.00000000
        return (uint256(price) * 1e18);

    }

    function getConversionRate() public {}

    function getversion() public view returns (uint256){
        return AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306).version();
    }
}
