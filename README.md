# Decentralized Task Board on Base

A smart contract on the Base network for creating, completing, canceling tasks and voting on tasks with ETH rewards with ETH rewards.

## Purpose
This project demonstrates onchain activity and GitHub contributions for the Base ecosystem.

## Contract Details
1. **TaskBoard.sol**:
- **Network**: Base mainnet \ Base Sepolia
- Sepolia Address**: 0x2469EB4f7C098bB082AE8cafBAE2F401ec66d731, Link: https://sepolia.basescan.org/address/0x2469eb4f7c098bb082ae8cafbae2f401ec66d731#code
- Mainnet Address**: 0xc69377c8B5C240bdffA71F57a805Fd0866f5281E, Link: https://basescan.org/address/0xc69377c8b5c240bdffa71f57a805fd0866f5281e
- Verification: Verified on Basescan

2. **TaskVoting.sol**:
   - Base Sepolia: 0x47E3319bbf107A0506C9379a4B9B99ef221d91fC   link: https://sepolia.basescan.org/address/0x47e3319bbf107a0506c9379a4b9b99ef221d91fc#code
   - Base Mainnet: 0x55dB1777BfaCBFD89757f621B13440e960599548        link: https://basescan.org/address/0x55db1777bfacbfd89757f621b13440e960599548#writeContract
   - Functionality: Vote on completed tasks to approve/reject and release rewards.
   - Verification: Verified on Basescan

**TaskFeedback.sol**:
   - Base Sepolia: 0x6887e09b52879Ba371bf1fc00B2032f4AD72FB82  link: https://sepolia.basescan.org/address/0x6887e09b52879ba371bf1fc00b2032f4ad72fb82#code
   - Base Mainnet: 0x7E2a95ad2e2Af4f3d762A7E3df8BFd5b8aE74A13  link: https://basescan.org/address/0x7e2a95ad2e2af4f3d762a7e3df8bfd5b8ae74a13#code
   - Functionality: Submit and view feedback (rating/comment) on completed tasks.
   - Verified on Basescan.
     
## How It Works
- **TaskBoard**: Create tasks with ETH rewards, complete or cancel them.
- **TaskVoting**: Vote on completed tasks (min. 3 approvals) to release rewards or cancel voting

## Usage
1. Open Remix (remix.ethereum.org).
2. Paste `TaskBoard.sol` and `TaskVoting.sol`, compile with Solidity 0.8.20.
3. Deploy `TaskBoard`, then deploy `TaskVoting` with TaskBoard’s address.
4. Deploy to Base Sepolia and Mainnet using MetaMask.
5. Interact to create tasks, vote, and release rewards.

## Links
- Base: https://base.org
- Talent Protocol: https://talentprotocol.com
- Builder Score: https://builderscore.xyz

