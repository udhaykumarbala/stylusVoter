// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract VotingSystem {
    struct Candidate {
        uint id;
        string name;
        uint voteCount;
    }

    mapping(address => bool) public voters;
    mapping(uint => Candidate) public candidates;
    uint public candidatesCount;

    event votedEvent(uint indexed candidateId);

    constructor() {
        addCandidate("Candidate 1");
        addCandidate("Candidate 2");
    }

    function addCandidate(string memory name) private {
        candidatesCount++;
        candidates[candidatesCount] = Candidate(candidatesCount, name, 0);
    }

    function vote(uint candidateId) public {
        require(!voters[msg.sender], "You have already voted");
        require(candidateId > 0 && candidateId <= candidatesCount, "Invalid candidate");

        voters[msg.sender] = true;
        candidates[candidateId].voteCount++;

        emit votedEvent(candidateId);
    }
}
