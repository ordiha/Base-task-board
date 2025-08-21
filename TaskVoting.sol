// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

// Interface to interact with the existing TaskBoard contract
interface ITaskBoard {
    struct Task {
        address creator;
        string description;
        uint256 reward;
        bool completed;
        address completer;
    }
    function tasks(uint256) external view returns (Task memory);
}

contract TaskVoting {
    // Reference to the deployed TaskBoard contract
    ITaskBoard public taskBoard;

    // Struct to store voting details
    struct Vote {
        uint256 approvalCount; // Number of approvals
        uint256 rejectionCount; // Number of rejections
        mapping(address => bool) hasVoted; // Track who voted
        bool rewardReleased; // Is reward released?
    }

    // Mapping to store votes for each TaskBoard task ID
    mapping(uint256 => Vote) public votes;
    uint256 public constant MIN_VOTES = 3; // Minimum approvals needed

    // Events for tracking actions
    event Voted(uint256 taskId, address voter, bool approved);
    event RewardReleased(uint256 taskId, address completer, uint256 reward);
    event VotingCancelled(uint256 taskId, address creator);

    // Constructor to set TaskBoard contract address
    constructor(address _taskBoard) {
        taskBoard = ITaskBoard(_taskBoard);
    }

    // Vote on a completed task
    function voteOnTask(uint256 _taskId, bool _approve) external {
        ITaskBoard.Task memory task = taskBoard.tasks(_taskId);
        require(task.creator != address(0), "Task does not exist");
        require(task.completed, "Task not completed");
        require(!votes[_taskId].hasVoted[msg.sender], "Already voted");
        require(!votes[_taskId].rewardReleased, "Reward already released");

        votes[_taskId].hasVoted[msg.sender] = true;
        if (_approve) {
            votes[_taskId].approvalCount++;
        } else {
            votes[_taskId].rejectionCount++;
        }
        emit Voted(_taskId, msg.sender, _approve);
    }

    // Release reward if enough approvals
    function releaseReward(uint256 _taskId) external {
        ITaskBoard.Task memory task = taskBoard.tasks(_taskId);
        require(task.creator != address(0), "Task does not exist");
        require(task.completed, "Task not completed");
        require(!votes[_taskId].rewardReleased, "Reward already released");
        require(votes[_taskId].approvalCount >= MIN_VOTES, "Not enough approvals");

        votes[_taskId].rewardReleased = true;
        payable(task.completer).transfer(task.reward);
        emit RewardReleased(_taskId, task.completer, task.reward);
    }

    // Cancel voting and reclaim reward
    function cancelVoting(uint256 _taskId) external {
        ITaskBoard.Task memory task = taskBoard.tasks(_taskId);
        require(task.creator == msg.sender, "Only creator can cancel");
        require(task.completed, "Task not completed");
        require(!votes[_taskId].rewardReleased, "Reward already released");

        votes[_taskId].rewardReleased = true;
        payable(task.creator).transfer(task.reward);
        emit VotingCancelled(_taskId, msg.sender);
    }
}
