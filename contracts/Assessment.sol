// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

//import "hardhat/console.sol";

contract RatingSystem {
    address payable public owner;
    uint256 public Rating;

    event PositiveRating(uint256 Grade);
    event NegativeRating(uint256 Grade);

    constructor(uint initBalance) payable {
        owner = payable(msg.sender);
         Rating= initBalance;
    }

    function getBalance() public view returns(uint256){
        return Rating;
    }

    function PositiveRating(uint256 _Grade) public payable {
        uint _PreviousRating = Rating;

        // make sure this is the owner
        require(msg.sender == owner, "You are not the owner of this account");

        // perform transaction
        Rating += _Grade;

        // assert transaction completed successfully
        assert(Rating == _PreviousRating + _Grade);

        // emit the event
        emit PositiveRating(_Grade);
    }

    // custom error
    error InsufficientRating(uint256 Rating, uint256 NegativeRatingGrade);

    function NegativeRating(uint256 _NegativeRatingGrade) public {
        require(msg.sender == owner, "You are not the owner of this account");
        uint _PreviousRating = Rating;
        if (Rating < _NegativeRatingGrade) {
            revert InsufficientBalance({
                Rating: Rating,
                NegativeRatingGrade: _NegativeRatingGrade
            });
        }

        // NegativeRating the given Grade
        Rating -= _NegativeRatingGrade;

        // assert the Rating is correct
        assert(Rating == (_PreviousRating - _NegativeRatingGrade));

        // emit the event
        emit NegativeRating(_NegativeRatingGrade);
    }
}
