//SPDX-License-Identifier:MIT
pragma solidity ^0.8.19;
import {Script} from "forge-std/Script.sol";

contract networkConfig {
    Networkconfig public activeNetworkConfig;

    constructor() {
        if (block.chainid == 11155111) {
            activeNetworkConfig = sepoliaNetworkConfig();
        } else {
            activeNetworkConfig = sepoliaNetworkConfig();
        }
    }

    struct Networkconfig {
        address priceFeed;
    }

    function sepoliaNetworkConfig() public pure returns (Networkconfig memory) {
        Networkconfig memory networkconfig = Networkconfig({priceFeed: 0x694AA1769357215DE4FAC081bf1f309aDC325306});
        return networkconfig;
    }

    function anvilNetworkConfig() public pure returns (Networkconfig memory) {}
}
