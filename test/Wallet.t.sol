// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import "forge-std/Test.sol";
import "forge-std/console.sol";
import {Wallet} from "../src/Wallet.sol";

// Examples of deal and hoax
// deal(address, uint) - Set balance of address
// hoax(address, uint) - deal + prank, Sets up a prank and set balance

contract WalletTest is Test {
    Wallet public wallet;

    function setUp() public {
        wallet = new Wallet{value: 1e18}();
    }

    function _send(uint256 amount) private {
        (bool ok,) = address(wallet).call{value: amount}("");
        require(ok, "send ETH failed");
    }

    function testEthBalance() public {
        console.log("ETH balance ", address(this).balance / 1e18);
    }

    function testSendEth() public {
        uint256 bal = address(wallet).balance;
        // deal(address, uint) - Set balance of address
        deal(address(1), 100);
        assertEq(address(1).balance, 100);

        deal(address(1), 11);
        assertEq(address(1).balance, 11);

        // hoax(address, uint) - deal + prank, Sets up a prank and set balance
        deal(address(1), 123);
        //if i call _send(123) => msg.sender == address of wallet.t.sol contract
        //if i use prank(address(1)) => msg.sender == address(1)
        vm.prank(address(1));
        _send(123);

        hoax(address(2), 456);
        _send(456);
        assertEq(address(wallet).balance, bal + 123 + 456);
    }
}
