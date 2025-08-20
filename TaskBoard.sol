// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract TaskBoard {
    // Structure to store task details
    struct Task {
        address creator; // Who created the task
        string description; // Task description
        uint256 reward; // ETH reward in wei
        bool completed; // Is the task completed?
        address completer; // Who completed the task
    }

    // Mapping to store tasks by ID
    mapping(uint256 => Task) public tasks;
    uint256 public taskCount; // Total number of tasks

    // Events for tracking actions
    event TaskCreated(uint256 taskId, address creator, string description, uint256 reward);
    event TaskCompleted(uint256 taskId, address completer);
    event TaskCancelled(uint256 taskId, address creator);

    // Create a task with an ETH reward
    function createTask(string memory _description) external payable {
        require(msg.value > 0, "Reward must be greater than 0");
        taskCount++;
        tasks[taskCount] = Task(msg.sender, _description, msg.value, false, address(0));
        emit TaskCreated(taskCount, msg.sender, _description, msg.value);
    }

    // Complete a task and claim the reward
    function completeTask(uint256 _taskId) external {
        Task storage task = tasks[_taskId];
        require(task.creator != address(0), "Task does not exist");
        require(!task.completed, "Task already completed");
        task.completed = true;
        task.completer = msg.sender;
        payable(msg.sender).transfer(task.reward);
        emit TaskCompleted(_taskId, msg.sender);
    }

    // Cancel a task and reclaim the reward
    function cancelTask(uint256 _taskId) external {
        Task storage task = tasks[_taskId];
        require(task.creator == msg.sender, "Only creator can cancel");
        require(!task.completed, "Task already completed");
        task.completed = true;
        payable(task.creator).transfer(task.reward);
        emit TaskCancelled(_taskId, msg.sender);
    }
}
