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

contract TaskFeedback {
    // Reference to the TaskBoard contract
    ITaskBoard public taskBoard;

    // Struct to store feedback details
    struct Feedback {
        address submitter; // Who submitted feedback
        uint8 rating; // Rating from 1 to 5
        string comment; // Optional comment
    }

    // Mapping to store feedback for each TaskBoard task ID
    mapping(uint256 => Feedback[]) public taskFeedbacks;

    // Event for tracking feedback submission
    event FeedbackSubmitted(uint256 taskId, address submitter, uint8 rating, string comment);

    // Constructor to set TaskBoard contract address
    constructor(address _taskBoard) {
        taskBoard = ITaskBoard(_taskBoard);
    }

    // Submit feedback for a completed task
    function submitFeedback(uint256 _taskId, uint8 _rating, string memory _comment) external {
        require(_rating >= 1 && _rating <= 5, "Rating must be between 1 and 5");
        ITaskBoard.Task memory task = taskBoard.tasks(_taskId);
        require(task.creator != address(0), "Task does not exist");
        require(task.completed, "Task not completed");

        taskFeedbacks[_taskId].push(Feedback(msg.sender, _rating, _comment));
        emit FeedbackSubmitted(_taskId, msg.sender, _rating, _comment);
    }

    // Get feedback count for a task
    function getFeedbackCount(uint256 _taskId) external view returns (uint256) {
        return taskFeedbacks[_taskId].length;
    }

    // Get specific feedback for a task by index
    function getFeedback(uint256 _taskId, uint256 _index) external view returns (address submitter, uint8 rating, string memory comment) {
        require(_index < taskFeedbacks[_taskId].length, "Feedback index out of bounds");
        Feedback memory feedback = taskFeedbacks[_taskId][_index];
        return (feedback.submitter, feedback.rating, feedback.comment);
    }
}
