//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.6;

import "hardhat/console.sol";
import "@openzeppelin/contracts/access/AccessControlEnumerable.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/utils/math/SafeMath.sol";
import {Counters} from "@openzeppelin/contracts/utils/Counters.sol";


contract DepocketManagement is AccessControlEnumerable {

    bytes32 public constant PRESIDENT_ROLE = keccak256("PRESIDENT_ROLE");
    bytes32 public constant VICE_PRESIDENT_ROLE = keccak256("VICE_PRESIDENT_ROLE");
    bytes32 public constant ACCOUNTANT_ROLE = keccak256("ACCOUNTANT_ROLE");

    using Counters for Counters.Counter;
    Counters.Counter public transferProposalCounter;

    using SafeMath for uint256;

    IERC20 public token;

    struct TransferProposal {
        address receiver ;
        uint256 amount;
    }

    mapping(uint256=> TransferProposal) public TransferProposalMapping;

    constructor(IERC20 _token, address _presidentRole, address _vicePresidentRole, address _accountantRole) {
       token = _token;
       _setupRole(PRESIDENT_ROLE, _presidentRole);
       _setupRole(VICE_PRESIDENT_ROLE, _vicePresidentRole);
       _setupRole(ACCOUNTANT_ROLE, _accountantRole);
    }

    function deposit(uint256 _amount) external onlyViceOrPresident{
        require(token.balanceOf(address(msg.sender)) > _amount, "Amount need to be smaller than total amount of this address");
        if(hasRole(VICE_PRESIDENT_ROLE, _msgSender())){
            require(_amount < 500 ether,"Vicepresident withdraw amount is must smaller than 500");
        }
        token.transferFrom(msg.sender,address(this),_amount);
    }

    function withdraw(uint256 _amount) external onlyViceOrPresident{
        require(token.balanceOf(address(this)) > _amount, "Amount need to be smaller than total amount of this address");
        if(hasRole(VICE_PRESIDENT_ROLE, _msgSender())){
            require(_amount < 500 ether,"Vicepresident withdraw amount is must smaller than 500");
        }
        token.transfer(msg.sender,_amount);
    }

    function createTransferProposal(address _receiver, uint256 _amount ) external onlyAccountant{
        uint256 currentIndex = transferProposalCounter.current();
        TransferProposalMapping[currentIndex] = TransferProposal(_receiver, _amount);
        transferProposalCounter.increment();
    }

    function executeTransferProposal(uint256 proposalId) external onlyPresident {
        require(TransferProposalMapping[proposalId].receiver != address(0), "proposal id is not exists");
        TransferProposal memory transferProposal = TransferProposalMapping[proposalId];
        token.transfer(transferProposal.receiver,transferProposal.amount);
    }

    modifier onlyViceOrPresident(){
        require(hasRole(VICE_PRESIDENT_ROLE, _msgSender()) || hasRole(PRESIDENT_ROLE, _msgSender()), "Caller must be president or vicepresident");
        _;
    }

    modifier onlyAccountant(){
        require(hasRole(ACCOUNTANT_ROLE, _msgSender()), "Caller must be accountant");
        _;
    }

    modifier onlyPresident(){
        require(hasRole(PRESIDENT_ROLE, _msgSender()), "Caller must be president");
        _;
    }
}
