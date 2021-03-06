// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

/**
 * @author Ricardo
 * @title Initial Coin Offerring(ICO) contract
 */
contract ICO is ERC20, Ownable {
    uint256 private _startTimeEpoch;

    constructor() ERC20("InitialCO", "ICO") {
         _mint(msg.sender, 420000 * 10 ** decimals());
    }

    /**
    * @notice Function to prevent a purchase if it is out of the sale period.
    */
    modifier isSalePeriod() {
        require(_startTimeEpoch != 0, "ICO: the sale is not started yet.");
        if (_startTimeEpoch != 0) {
            require(block.timestamp < _startTimeEpoch + 2 weeks, "ICO: The sale is over.");
        }
        _;
    }

    /**
     * @param account (type address) address of recipient
     * @param amount (type uint256) amount of token
     * @dev function use to mint token
     */
    function mint(address account, uint256 amount) public onlyOwner returns (bool success) {
        require(account != address(0) && amount != uint256(0), "ICO: function mint invalid input");
        _mint(account, amount);
        return true;
    }

    /**
     * @dev function to buy token with ether
     */
    function buy() public payable returns (bool success) {
        require(msg.sender.balance >= msg.value && msg.value != 0 ether, "ICO: function buy invalid input");
        uint256 amount = msg.value * 1000;
        _transfer(owner(), msg.sender, amount);
        return true;
    }

    /**
     * @param amount (type uint256) amount of ether
     * @dev function use to withdraw ether from contract
     */
    function withdraw(uint256 amount) public onlyOwner returns (bool) {
        require(amount <= address(this).balance, "ICO: function withdraw invalid input");
        payable(msg.sender).transfer(amount);
        return true;
    }
}
