//SPDX-License-Identifier:MIT
pragma solidity ^0.8.19;

import {Script} from 'forge-std/Script.sol';
import {FundMe} from '../src/fund_me.sol';

contract DeployFundme is Script{
    function run() external{
        vm.startBroadcast();
        new FundMe();
        vm.stopBroadcast();
    }
}