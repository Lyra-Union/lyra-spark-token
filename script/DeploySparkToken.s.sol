// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {Script} from "lib/forge-std/src/Script.sol";
import {SparkToken} from "../src/SparkToken.sol";
import {console} from "lib/forge-std/src/console.sol";
import {HelperConfig} from "./HelperConfig.s.sol"; // Import HelperConfig

contract DeploySparkToken is Script {
    // Declare sparkToken as a public state variable
    SparkToken public sparkToken;

    function run() external {
        // Use HelperConfig to determine the correct owner address
        HelperConfig helperConfig = new HelperConfig();
        address deployer = helperConfig.owner(); // Deployer address for initial minting
        address finalOwner = 0x21310a7f2c88194fb70194df679b260F024cCF77; // New owner address for production

        uint256 initialSupply = 250_000 ether; // Updated initial supply for hackathon

        // Start a broadcast as the deployer
        vm.startBroadcast(deployer);
        sparkToken = new SparkToken(deployer, initialSupply); // Deploy the contract

        // Transfer ownership to the final owner
        sparkToken.transferOwnership(finalOwner);

        // Transfer all minted tokens to the final owner
        sparkToken.transfer(finalOwner, initialSupply);
        vm.stopBroadcast();

        // Print the deployed contract address and the new owner address
        console.log("Deployed SparkToken at:", address(sparkToken));
        console.log("Ownership transferred to:", finalOwner);
    }
}
