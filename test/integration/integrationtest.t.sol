//SPDX-License-Identifier:MIT

pragma solidity ^0.8.19;

import {Test} from "forge-std/Test.sol";
import {FundMe} from "../../src/fund_me.sol";
import {DeployFundme} from "../../script/Deployfundme.s.sol";
import {Fundfundme} from "../../script/interaction.s.sol";

contract fundmeTest is Test {
    FundMe fundme;
    address USER = makeAddr("user");
    uint256 constant AMOUNT_SENT = 0.1 ether;
    uint256 constant STARTING_BALANCE = 10 ether;

    function setup()public{
        DeployFundme deployfund = new DeployFundme();
        fundme=deployfund.run();
        vm.deal(USER,STARTING_BALANCE);
    }

    function testIntegrationFundme()public{
        Fundfundme fundfundme=new Fundfundme();
        vm.prank(USER);
        fundfundme.fundme(address(fundme));
    }

}
