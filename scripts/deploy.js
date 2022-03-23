const { ethers } = require('hardhat');

async function main() {
    const DepocketToken = await ethers.getContractFactory("DepocketToken");
    const depocketToken = await DepocketToken.deploy();
    const depocketTokenResult = await depocketToken.deployed();
    console.log("Success when deploy depocket contract: %s",depocketTokenResult.address)

    const DepocketManagement = await ethers.getContractFactory("DepocketManagement");
    /* 4 argument: token address, president address, vicepresident address, accountant address */
    const depocketManagement = await DepocketManagement.deploy(depocketTokenResult.address, "0xEBd42256B90f002d19C8f2ed4Eed406765759F57", "0x1a521Ac995ABCbc2baB882325E0427Ac0dDfd06e", "0x40d67342b910c6D710CBE9985709E796f0ccA807");
    const depocketManagementResult = await depocketManagement.deployed();
    console.log("Success when deploy depocket management contract: %s",depocketManagementResult.address)
}


main()
    .then(() => process.exit(0))
    .catch((error) => {
        console.error(error);
        process.exit(1);
    });

