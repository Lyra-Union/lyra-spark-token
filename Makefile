-include .env

.PHONY: build test deploy deploy-local deploy-aurora deploy-mainnet mint transfer

# Build the contracts
build:
	forge build

# Run the test suite
test:
	forge test

# Deploy locally using Anvil
deploy-local:
	@forge script script/DeployFyreToken.s.sol --fork-url http://127.0.0.1:8545 --broadcast --private-key $(ANVIL_PRIVATE_KEY) --legacy

# Deploy to Aurora Testnet
deploy-aurora:
	@forge script script/DeployFyreToken.s.sol --rpc-url $(AURORA_TESTNET_RPC_URL) --broadcast --private-key $(PRIVATE_KEY) --legacy

# Deploy to Mainnet
deploy-mainnet:
	@forge script script/DeployFyreToken.s.sol --rpc-url $(MAINNET_RPC_URL) --broadcast --private-key $(PRIVATE_KEY) --legacy

# Mint new tokens to a specified address
mint:
	@cast send $(FIRE_TOKEN_ADDRESS) "mint(address,uint256)" $(OWNER_ADDRESS) $(AMOUNT) --rpc-url $(RPC_URL) --private-key $(PRIVATE_KEY) --json

# Transfer tokens from OWNER_ADDRESS to another address
transfer:
	@cast send $(FIRE_TOKEN_ADDRESS) "transfer(address,uint256)" $(TO_ADDRESS) $(AMOUNT) --rpc-url $(RPC_URL) --private-key $(PRIVATE_KEY) --json
