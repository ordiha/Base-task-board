// Simple test script for TaskBoard interaction
const Web3 = require('web3');
const web3 = new Web3('https://sepolia.base.org');

async function testTaskCreation() {
    const account = '0xf618abf...'; // Your wallet address
    const taskBoardAddress = '0x47e3319...'; // TaskBoard address
    console.log(`Testing task creation for ${account} on ${taskBoardAddress}`);
    // Add more logic (e.g., call createTask) with Web3.js
}

testTaskCreation().catch(console.error);
