# Security Audit Notes

## Overview
Basic security review of TaskBoard contracts.

## Key Checks
1. Reentrancy: No reentrancy issues in ETH transfers (use reentrancyGuard if needed).
2. Access Control: Only creator can cancel tasks.
3. Input Validation: Rewards > 0, valid task IDs.

## Recommendations
- Add reentrancyGuard modifier.
- Test with multiple wallets.
- Audit via external service (e.g., OpenZeppelin).
