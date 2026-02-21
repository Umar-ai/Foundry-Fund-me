//SPDX-License-Identifier:MIT

pragma solidity ^0.8.19;

import {Test} from "forge-std/Test.sol";
import {FundMe} from "../src/fund_me.sol";

contract fundmeTest is Test {
    FundMe fundme;

    function setUp() external {
        fundme = new FundMe(0x694AA1769357215DE4FAC081bf1f309aDC325306);
    }

    function testisMinimumUsdFive() public view {
        assertEq(fundme.MINIMUM_USD(), 5e18);
    }

    function testisOwnerisMsgSender() public view{
        // assertEq(fundme.i_owner(),msg.sender);
        assertEq(fundme.i_owner(),address(this));
    }

    function testisVersionAccurate() public view{
        uint256 version=fundme.getVersion();
        assertEq(version,4);
    }
}
