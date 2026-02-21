//SPDX-License-Identifier:MIT
pragma solidity ^0.8.19;

import {Script} from 'forge-std/Script.sol';
import {FundMe} from '../src/fund_me.sol';
import {networkConfig} from "./networkconfig.s.sol";
contract DeployFundme is Script{
    function run() external returns (FundMe){
        networkConfig networkconfig=new networkConfig();
        (address Eth_usd)=networkconfig.activeNetworkConfig();
        vm.startBroadcast();
        FundMe fundme=new FundMe(Eth_usd);
        vm.stopBroadcast();
        return fundme;
    }
}