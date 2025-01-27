// SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;

import "./PriceConverter.sol";
// constant, immutable {gas optimization}

error NotOwner();

contract FundMe {
    using PriceConverter for uint256;

    uint256 public constant MINIMUM_USD = 5 * 1e18; // 5 USD in wei (assuming 1 ETH = 2000 USD)

    address[] public funders;
    mapping(address funder => uint256 amountFunded) public addressToAmountFunded;

   address public immutable i_owner;
   
   constructor() {
        i_owner = msg.sender;
    }
    
    function fund() public payable {
        require(msg.value.getConversionRate() >= MINIMUM_USD, "didn't send enough ETH");
        // require(getConversionRate(msg.value) >= minimumUsd, "Didn't send enough ETH");
        funders.push(msg.sender);
        addressToAmountFunded[msg.sender] += msg.value;
    }

    function withdraw() public onlyOwner {
        // for loop
        // {1, 2, 3, 4}
        for(uint256 funderIndex = 0; funderIndex < funders.length; funderIndex = funderIndex ++){
            address funder = funders[funderIndex];
            addressToAmountFunded[funder] = 0;
        }
        funders = new address[](0);
        // withdraw the funds (3 ways)

        // transfer
        // send
        // call

        // call is the standardised way to withdraw. Check solidity by example for reason

        // transfer
        // msg.sender = address
        // payable(msg.sender) = payable address
        // payable(msg.sender).transfer(address(this).balance);

        // send
        // bool sendSuccess = payable(msg.sender).send(address(this).balance);
        // require(sendSuccess, "Send failed");

        // call
        (bool callSuccess, ) = payable (msg.sender).call{value: address(this).balance}("");
        require(callSuccess, "Call failed");
    } 

    modifier onlyOwner() {
        // require(msg.sender == i_owner, "Sender is not owner!");
        if (msg.sender != i_owner) {revert NotOwner(); } 
        _;
    }


    // what happens of someone sends money to this contract without calling the fund function

    // receive {}
    // fallback {}

    receive() external payable {
        fund();
    }

    fallback() external payable {
        fund();
    }
}