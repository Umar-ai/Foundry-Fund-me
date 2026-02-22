//SPDX-License-Identifier:MIT
pragma solidity ^0.8.19;
import {Script} from "forge-std/Script.sol";
import {MockV3Aggregator} from "../test/mocks/mockAgrregator.sol";

contract networkConfig is Script {
    Networkconfig public activeNetworkConfig;
    uint8 public constant DECIMALS = 8;
    int256 public constant INITIAL_PRICE = 2000e8;

    constructor() {
        if (block.chainid == 11155111) {
            activeNetworkConfig = sepoliaNetworkConfig();
        } else {
            activeNetworkConfig = getOrCreateAnvilEthconfig();
        }
    }

    struct Networkconfig {
        address priceFeed;
    }

    function sepoliaNetworkConfig() public pure returns (Networkconfig memory) {
        Networkconfig memory networkconfig = Networkconfig({priceFeed: 0x694AA1769357215DE4FAC081bf1f309aDC325306});
        return networkconfig;
    }

    function getOrCreateAnvilEthconfig() public returns (Networkconfig memory) {
        // Check to see if we set an active network config
        if (activeNetworkConfig.priceFeed != address(0)) {
            return activeNetworkConfig;
        }

        vm.startBroadcast();
        MockV3Aggregator mockPriceFeed = new MockV3Aggregator(DECIMALS, INITIAL_PRICE);
        vm.stopBroadcast();

        Networkconfig memory networkconfig = Networkconfig({priceFeed: address(mockPriceFeed)});
        return networkconfig;
    }
}
