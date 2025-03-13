// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/IERC20.sol";
import "balancer-v2/vault/IVault.sol";

contract FlashLoanArbitrage {
    IVault private immutable vault;
    address private immutable owner;

    constructor(address _vault) {
        vault = IVault(_vault);
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Not contract owner");
        _;
    }

    function executeFlashLoan(address _token, uint256 _amount) external onlyOwner {
        // ✅ Step 1: Declare Arrays Before Assigning
        address;
        uint256;
        bytes memory userData = ""; // Custom data (if needed)

        // ✅ Step 2: Assign Values After Declaring
        assets[0] = _token;
        amounts[0] = _amount;

        // ✅ Step 3: Call Balancer Flash Loan
        vault.flashLoan(address(this), assets, amounts, userData);
    }

    function receiveFlashLoan(
        address[] calldata assets,
        uint256[] calldata amounts,
        uint256[] calldata premiums
    ) external {
        require(msg.sender == address(vault), "Only Balancer Vault can call this");

        // ✅ Implement Arbitrage Logic Here (Buy low, Sell high)
        
        // ✅ Step 4: Approve Tokens for Repayment
        for (uint256 i = 0; i < assets.length; i++) {
            uint256 totalRepayment = amounts[i] + premiums[i];
            IERC20(assets[i]).approve(address(vault), totalRepayment);
        }
    }
}
