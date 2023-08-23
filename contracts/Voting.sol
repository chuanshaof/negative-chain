// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;
pragma abicoder v2;

/**
 * @title Ballot
 * @dev Implements voting process along with vote delegation
 */
contract Ballot {
    struct Voter {
        uint weight; // weight is accumulated by delegation
        bool voted; // if true, that person already voted
        uint vote; // index of the voted proposal
    }

    struct Claimee {
        address addr; // claimee address
        uint voteScore; // score on voting
    }

    uint256 public startTime;

    Claimee public claimee;

    mapping(address => Voter) public voters;

    enum State {
        Created,
        Voting,
        Ended
    } // State of voting period

    State public state;

    constructor() {
        state = State.Created;

        startTime = block.timestamp;

        // Initialize a claimee
        claimee = Claimee({ addr: msg.sender, voteScore: 0 });
    }

    // MODIFIERS
    modifier onlySmartContractOwner() {
        require(msg.sender == claimee.addr, "Only claimee can start and end the voting");
        _;
    }

    modifier CreatedState() {
        require(state == State.Created, "it must be in Started");
        _;
    }

    modifier VotingState() {
        require(state == State.Voting, "it must be in Voting Period");
        _;
    }

    modifier EndedState() {
        require(state == State.Ended, "it must be in Ended Period");
        _;
    }

    // 1 week for users to vote
    modifier EndedCondition() {
        require(((block.timestamp - startTime) / (60 * 60 * 24 * 7)) > 1);
        _;
    }

    // to start the voting period
    function startVote() public onlySmartContractOwner CreatedState {
        state = State.Voting;
    }

    /*
     * to end the voting period
     * can only end if the state in Voting period
     */
    function endVote() public EndedCondition() VotingState {
        state = State.Ended;
    }

    /**
     * @dev Give 'voter' the right to vote on this ballot
     * @param voter address of voter
     */
    function giveRightToVote(address voter) public view {
        require(!voters[voter].voted, "The voter already voted.");
        require(voters[voter].weight == 0);
    }

    /**
     * @dev Give your vote (including votes delegated to you) to candidate 'candidates[candidate].name'.
     * @param award indicate if the voter is in favor of paying out
     */
    function vote(bool award) public VotingState {
        Voter storage sender = voters[msg.sender];
        require(sender.weight != 0, "Has no right to vote");
        require(!sender.voted, "Already voted.");
        sender.voted = true;

        claimee.voteScore += (award ? 1 : 0) * sender.weight;
    }

    function payout() public view EndedState returns (bool payout_) {
        payout_ = (claimee.voteScore > 0) ? true : false;
    }
}
