// SPDX-License-Identifier: MIT

pragma solidity >=0.4.0 <0.9.0;

contract Nabo_Crowdfunding {
    address owner;
    uint256 deadline;
    uint256 goal;
    mapping(address => uint256) public pledgeOf;

    function Nabofund(uint256 numberOfDays, uint256 _goal) public {
        owner = msg.sender;
        deadline = block.timestamp + (numberOfDays * 1 days);
        goal = _goal;
    }

    function NaboPledge(uint256 amount) public payable {
        require(block.timestamp < deadline);  // in the fundraising period
        require(msg.value == amount);

        pledgeOf[msg.sender] += amount;
    }

    function claimFunds() public   {
        require(address(this).balance >= goal); // funding goal met
        require(block.timestamp >= deadline);  // in the withdrawal period
        require(msg.sender == owner);
        

       //msg.sender.transfer(address(this).balance);
    }

    function AskRefund() public {
        require(address(this).balance < goal); // funding goal not met
        require(block.timestamp >= deadline);  // in the withdrawal period

        uint256 amount = pledgeOf[msg.sender];
        pledgeOf[msg.sender] = 0;
      // msg.sender.transfer(amount);
    }
}