# SparkToken Project

Welcome to the **SparkToken** project! This repository contains the smart contracts, tests, and deployment scripts to manage an ERC20-based token with ownership and minting controls. The contracts are written in Solidity and are designed for ease of deployment across various Ethereum-compatible networks.

## Table of Contents

- [Overview](#overview)
- [Contracts](#contracts)
  - [SparkToken](#sparktoken)
  - [HelperConfig](#helperconfig)
  - [DeployFyreToken](#deployfyretoken)
  - [FyreTokenHandler](#fyretokenhandler)
- [Testing](#testing)
  - [Unit Tests](#unit-tests)
  - [Invariant Tests](#invariant-tests)
  - [Deployment Script Tests](#deployment-script-tests)
  - [HelperConfig Tests](#helperconfig-tests)
- [Deployment](#deployment)
- [Makefile Commands](#makefile-commands)
- [Project Configuration](#project-configuration)

## Overview

The **SparkToken** project is an ERC20 token implementation with custom minting and burning functionality, along with ownership management. The project utilizes **Forge** as the development and testing environment and includes deployment scripts for various networks.

## Contracts

### 1. FyreToken

The main ERC20 contract:

- **Inherits**: `ERC20` and `Ownable` from OpenZeppelin.
- **Constructor Parameters**:
  - `address owner` — Initial owner of the contract.
  - `uint256 initialSupply` — The initial supply of tokens to mint.
- **Key Functions**:
  - `mint(address account, uint256 amount)` — Allows the owner to mint new tokens.
  - `burn(address account, uint256 amount)` — Allows the owner to burn tokens from a specified account.

### 2. HelperConfig

A helper contract to determine the owner address based on the current network.

- **Key Functionality**:
  - Sets the owner address based on the current chain ID.
  - Supports local Anvil, Aurora testnet, and mainnet.

### 3. DeployFyreToken

A deployment script to initialize and deploy the `SparkToken` contract.

- **Key Steps**:
  - Deploys `SparkToken` with an initial supply.
  - Transfers ownership to the specified production address.
  - Transfers all minted tokens to the final owner.

### 4. FyreTokenHandler

A helper contract designed for fuzz testing and token management operations.

- **Key Features**:
  - Handles minting, burning, and transferring tokens within safe bounds.
  - Enforces a maximum supply limit for minting operations.

## Testing

### Unit Tests

- `SparkTokenUnitTest` contains tests for basic functionality such as minting, burning, and transferring tokens.
- Test scripts simulate common operations to ensure contract correctness.

### Invariant Tests

- **SparkTokenInvariantTest** checks that the total supply never exceeds a pre-defined maximum limit of `1,000,000 ether`.

### Deployment Script Tests

- **DeploySparkTokenTest** validates that the deployment script correctly deploys the token and transfers ownership.

### HelperConfig Tests

- **HelperConfigTest** checks that the `HelperConfig` contract sets the owner correctly based on the network configuration.

## Deployment

You can deploy the contracts using the included scripts. Ensure you have the appropriate environment variables set and network RPC URLs configured.

### Local Deployment

```bash
make deploy-local
```

## Deployment

### Deploy to Aurora Testnet

```bash
make deploy-aurora
```

### Deploy to Mainnet

```bash
make deploy-mainnet
```

## Makefile Commands

The Makefile includes several commands to streamline your development and deployment workflow:

- **Build the contracts**:

  ```bash
  make build
  ```

- **Run the test suite**:

  ```bash
  make test
  ```

- **Deploy locally using Anvil**:

  ```bash
  make deploy-local
  ```

- **Deploy to Aurora Testnet**:

  ```bash
  make deploy-aurora
  ```

- **Deploy to Mainnet**:

  ```bash
  make deploy-mainnet
  ```

- **Mint new tokens to a specified address**:

  ```bash
  make mint
  ```

- **Transfer tokens from the owner to another address**:

  ```bash
  make transfer
  ```

## Project Configuration

The project configuration is managed through the `foundry.toml` file:

```toml
[profile.default]
src = "src"
out = "out"
libs = ["lib"]

[fuzz]
# Control how many test cases fuzz runs
runs = 1000
max_shrink_iters = 1000
```

## Environment Variables

Ensure you have the following environment variables configured:

- `ANVIL_PRIVATE_KEY` — Private key for local Anvil deployments.
- `AURORA_TESTNET_RPC_URL` — Aurora Testnet RPC URL.
- `MAINNET_RPC_URL` — Mainnet RPC URL.
- `PRIVATE_KEY` — Private key for signing transactions on live networks.
- `OWNER_ADDRESS` — Owner address for deployment and minting.
- `FIRE_TOKEN_ADDRESS` — Address of the deployed `FyreToken` contract.
- `RPC_URL` — RPC URL of the desired network for operations.

## Acknowledgments

The project leverages the **Foundry** development framework and OpenZeppelin contracts. Special thanks to the blockchain community for continuous innovation.

---

Feel free to explore, test, and contribute to the **FyreToken** project!
