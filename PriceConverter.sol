// SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;

import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";

library PriceConverter {
    function getPrice() internal view returns (uint256) {
        // Address of the Chainlink ETH/USD price feed on Sepolia testnet
        AggregatorV3Interface priceFeed = AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306);
        
        // Get the latest price data
        (, int256 price,,,) = priceFeed.latestRoundData();
          
        // Convert the price to a uint256 and adjust for 8 decimal places
        return uint256(price) * 1e10; // 1e10 to convert from 8 decimals to 18 decimals
    }

    function getConversionRate(uint256 ethAmount) internal view returns (uint256) {
        // Get the current price of ETH in USD
        uint256 ethPrice = getPrice();
        
        // Calculate the USD value of the given ETH amount
        uint256 ethAmountInUsd = (ethPrice * ethAmount) / 1e18;
        
        return ethAmountInUsd;
    }

    function getVersion() public view returns (uint256) {
        // Get the version of the price feed contract
        return AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306).version();
    }
}