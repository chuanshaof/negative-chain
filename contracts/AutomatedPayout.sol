// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

import "./Voting.sol";

contract Escrow {
    enum State { AWAITING_VOTE, VOTE_DONE, COMPLETE }
    
    State public currState;

    Ballot public ballot;
    
    address public claimee;

    // Not sure how this works actually
    address payable public negative;

    constructor(address addr) {
        claimee = addr;
    }

    modifier onlyClaimee() {
        require(msg.sender == claimee);
        _;
    }

    function callVote() onlyClaimee() external {
        ballot = Ballot(claimee);
    }

    function voteCompleted() external {
        require(currState == State.VOTE_DONE, "Not yet completed voting");
        
        negative.transfer(address(this).balance);
        currState = State.COMPLETE;
    }
}