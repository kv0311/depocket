# Basic Sample Hardhat Project

This project demonstrates a basic Hardhat use case. It comes with a sample contract, a test for that contract, a sample script that deploys that contract, and an example of a task implementation, which simply lists the available accounts.

Try running some of the following tasks:

npm install

cp env.dist .env -> add private key and bsc api key (https://bscscan.com/myapikey)

// Read and change file scripts/deploy.js
npx hardhat run --network testnet scripts/deploy.js

//read and change file argument.js
npx hardhat verify --network testnet  --contract contracts/DepocketToken.sol:DepocketToken 0x149f7a5E79C36b36093312104f5dB99DC097Ee47   -> contract address depocket token
npx hardhat verify --network testnet --constructor-args scripts/arguments.js --contract contracts/Depocket-Management.sol:DepocketManagement 0x24ED0b7135aE87d38D320ADA933bdDE4467f113e  -> contract address depocket management

example contract: - depocket token https://testnet.bscscan.com/address/0x7E9BeFBc5dAf59176f11913ae3f83099CeE92fDF#code
                  - depocket management https://testnet.bscscan.com/address/0x7E9BeFBc5dAf59176f11913ae3f83099CeE92fDF#code


flow test 
   - to deposit money from need to call method approve first
   - withdraw president unlimited - vice president < 500 depocket token
   - create createTransferProposal only accountant
   - execute transfer proposal


