//SPDX-License-Identifier:MIT

pragma solidity ^0.8.19;

import {Script, console} from "forge-std/Script.sol";
import {FundMe} from "../src/fund_me.sol";
import {DevOpsTools} from "lib/foundry-devops/src/DevOpsTools.sol";

contract Fundfundme is Script {
    uint256 SEND_VALUE = 0.1 ether;

    function fundme(address mostrecentDeployedContract) public {
        FundMe(payable(mostrecentDeployedContract)).fund{value: SEND_VALUE}();
    }

    function run() public {
        vm.startBroadcast();
        address latestContractAddres = DevOpsTools.get_most_recent_deployment("FundMe", block.chainid);
        fundme(latestContractAddres);
        vm.stopBroadcast();
    }
}

contract WithDrawMe is Script{
    function withDrawDraw(address mostRecentContractAdress)public{
        vm.startBroadcast();
        FundMe(payable(mostRecentContractAdress)).withdraw();
        vm.stopBroadcast();
    }

    function run() public {
        vm.startBroadcast();
        address latestContractAddres = DevOpsTools.get_most_recent_deployment("FundMe", block.chainid);
        WithDrawMe(latestContractAddres);
        vm.stopBroadcast();
    }
}
