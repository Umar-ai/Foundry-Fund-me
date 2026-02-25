//SPDX-License-Identifier:MIT

pragma solidity ^0.8.19;

import {Test} from "forge-std/Test.sol";
import {FundMe} from "../src/fund_me.sol";
import {DeployFundme} from "../script/Deployfundme.s.sol";

contract fundmeTest is Test {
    FundMe fundme;
    address USER = makeAddr("user");
    uint256 constant AMOUNT_SENT = 0.1 ether;
    uint256 constant STARTING_BALANCE = 10 ether;

    function setUp() external {
        DeployFundme deployFundme = new DeployFundme();
        fundme = deployFundme.run();
        vm.deal(USER, STARTING_BALANCE);
    }

    function testisMinimumUsdFive() public view {
        assertEq(fundme.MINIMUM_USD(), 5e18);
    }

    function testisOwnerisMsgSender() public view {
        assertEq(fundme.get_owner(), msg.sender);
        // assertEq(fundme.i_owner(),address(this));
    }

    function testisVersionAccurate() public view {
        uint256 version = fundme.getVersion();
        assertEq(version, 4);
    }

    function testcheckfundfailifenoughamountnotsent() public {
        vm.expectRevert();
        fundme.fund();
    }

    function testifAddresstoAmountFundedUpdated() public {
        vm.prank(USER);
        fundme.fund{value: AMOUNT_SENT}();
        uint256 fundedAmount = fundme.gets_addressToAmountFunded(USER);
        assertEq(fundedAmount, AMOUNT_SENT);
    }

    function testFunderAddedToFunderArray() public {
        vm.prank(USER);
        fundme.fund{value: AMOUNT_SENT}();
        address funderAdress = fundme.gets_checkfundersArrayupdation(0);
        assertEq(funderAdress, USER);
    }

    modifier funder() {
        vm.prank(USER);
        fundme.fund{value: AMOUNT_SENT}();
        _;
    }

    function testWithOutOwnerNoCanWithdraw() public funder {
        vm.expectRevert();
        vm.prank(USER);
        fundme.withdraw();
    }

    function testOnwercanwithdraw() public funder {
        //arrange
        uint256 ownerStartingBalance = address(fundme.get_owner()).balance;
        uint256 fundmeContractStartingBalance = address(fundme).balance;

        //act
        vm.prank(fundme.get_owner());
        fundme.withdraw();

        //assert
        uint256 ownerEndingBalance = address(fundme.get_owner()).balance;
        uint256 fundmeContractEndingBalance = address(fundme).balance;
        assertEq(fundmeContractEndingBalance, 0);
        assertEq(ownerStartingBalance + fundmeContractStartingBalance, ownerEndingBalance);
    }

    function testWithDrawWithTooManyFunders() public {
        uint160 NumberOfFunders = 10;
        uint160 FunderStartingIndex = 1;
        for (uint160 i = FunderStartingIndex; i < NumberOfFunders; i++) {
            hoax(address(i), STARTING_BALANCE);
            fundme.fund{value: AMOUNT_SENT}();
        }
        assertEq(address(fundme).balance, 0.9 ether);

        uint256 ownerStartingBalance = address(fundme.get_owner()).balance;
        uint256 fundmeContractStartingBalance = address(fundme).balance;

        //act
        vm.prank(fundme.get_owner());
        fundme.withdraw();

        //assert
        uint256 ownerEndingBalance = address(fundme.get_owner()).balance;
        uint256 fundmeContractEndingBalance = address(fundme).balance;
        assertEq(fundmeContractEndingBalance, 0);
        assertEq(ownerStartingBalance + fundmeContractStartingBalance, ownerEndingBalance);
    }

    function testWithDrawWithTooManyFundersCheaper() public {
        uint160 NumberOfFunders = 10;
        uint160 FunderStartingIndex = 1;
        for (uint160 i = FunderStartingIndex; i < NumberOfFunders; i++) {
            hoax(address(i), STARTING_BALANCE);
            fundme.fund{value: AMOUNT_SENT}();
        }
        assertEq(address(fundme).balance, 0.9 ether);

        uint256 ownerStartingBalance = address(fundme.get_owner()).balance;
        uint256 fundmeContractStartingBalance = address(fundme).balance;

        //act
        vm.prank(fundme.get_owner());
        fundme.cheaperWithdraw();

        //assert
        uint256 ownerEndingBalance = address(fundme.get_owner()).balance;
        uint256 fundmeContractEndingBalance = address(fundme).balance;
        assertEq(fundmeContractEndingBalance, 0);
        assertEq(ownerStartingBalance + fundmeContractStartingBalance, ownerEndingBalance);
    }
}
