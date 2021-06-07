// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/utils/Address.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

/**
 * @title Calulator
 * @author Ricardo
 **/
contract CAL is ERC20, Ownable {
 
    using Address for address payable;
    mapping(address => uint256) private _credits;

    event Add(int256 result, int256 nb1, int256 nb2);
    event Sub(int256 result, int256 nb1, int256 nb2);
    event Mul(int256 result, int256 nb1, int256 nb2);
    event Mod(int256 result, int256 nb1, int256 nb2);
    event Div(int256 result, int256 nb1, int256 nb2);

    constructor() ERC20("CalToken", "CLT") Ownable() {
        _mint(msg.sender, 420000 * 10 ** decimals());
    }

    modifier payCredit() {
        require(_credits[msg.sender] != 0, "Cal: you have no more credits.");
        _credits[msg.sender] -= 1;
        _;
    }

    function add(int256 nb1, int256 nb2) public  returns (int256) {
        emit Add(nb1 + nb2, nb1, nb2);
        return nb1 + nb2;
    }

    function sub(int256 nb1, int256 nb2) public returns (int256) {
        emit Sub(nb1 - nb2, nb1, nb2);
        return nb1 - nb2;
    }

    function mul(int256 nb1, int256 nb2) public returns (int256) {
        emit Mul(nb1 * nb2, nb1, nb2);
        return nb1 * nb2;
    }

    function mod(int256 nb1, int256 nb2) public returns (int256) {
        emit Mod(nb1 % nb2, nb1, nb2);
        return nb1 % nb2;
    }

    function div(int256 nb1, int256 nb2) public returns (int256) {
        require(nb2 != 0, "Cal: you cannot divide by zero.");
        emit Div(nb1 / nb2, nb1, nb2);
        return nb1 / nb2;
    }
}
