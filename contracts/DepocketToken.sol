// SPDX-License-Identifier: MIT

pragma solidity ^0.8.6;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";

contract DepocketToken is ERC20, Ownable {
    address public admin;
    uint256 public totalTokens;

    // wei
    constructor() ERC20("Depocket", "Depocket") {
        totalTokens = 100 * 10**7 * 10**uint256(decimals()); // 100M
        _mint(owner(), totalTokens);
        admin = owner(); // Sets admin address in blockchain
    }

    function mint(address to, uint256 amount) public onlyOwner{
        _mint(to, amount);
    }

    function burn(address from, uint256 amount) public onlyOwner{
        _burn(from, amount);
    }
}
