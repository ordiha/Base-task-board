// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

interface ITaskBoard {
    struct Task {
        address creator;
        string description;
        uint256 reward;
        bool completed;
        address completer;
    }
    function tasks(uint256) external view returns (Task memory);
    function taskCount() external view returns (uint256);
}

contract RewardTracker {
    ITaskBoard public taskBoard;
    mapping(address => uint256) public userPoints; // User address to points
    uint256 public totalPoints;

    event PointsAwarded(address user, uint256 points);

    constructor(address _taskBoard) {
        taskBoard = ITaskBoard(_taskBoard);
    }

    function awardPoints(uint256 _taskId) external {
        require(_taskId > 0 && _taskId <= taskBoard.taskCount(), "Invalid task ID");
        ITaskBoard.Task memory task = taskBoard.tasks(_taskId);
        require(task.completed, "Task not completed");
        require(task.completer != address(0), "No completer");
        require(userPoints[task.completer] == 0, "Points already awarded");

        uint256 points = task.reward / 10000000000000000; // 1 point per 0.01 ETH (adjust as needed)
        userPoints[task.completer] += points;
        totalPoints += points;
        emit PointsAwarded(task.completer, points);
    }

    function getUserPoints(address _user) external view returns (uint256) {
        return userPoints[_user];
    }
}
