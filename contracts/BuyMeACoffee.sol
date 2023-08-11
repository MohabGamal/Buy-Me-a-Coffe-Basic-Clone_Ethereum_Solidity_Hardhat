// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

// Import this file to use console.log
import "hardhat/console.sol";

contract BuyMeACoffee {
    // event when memo is created
    event NewMemo (
        address from,
        uint timestamp,
        string name,
        string message
    );

    // Memo struct
    struct Memo {
        address from;
        uint timestamp;
        string  name;
        string  message;
    }
    Memo[] memos;

    address payable owner;
    constructor() {
        owner = payable(msg.sender);
    }

    /**
    * @dev buy a coffee for contract owner
    * @param _name name of coffe buyer
    * @param _message message fro coffee buyer
    **/
    function buycoffee (string memory _name, string memory _message) public payable
    {
        require(msg.value > 0, "Cannot buy a coffee for free COUNTERINTUTIVE");
        
        memos.push(Memo(
            msg.sender,
            block.timestamp,
            _name,
            _message
        ));

        emit NewMemo(msg.sender,
        block.timestamp,
        _name,
        _message
        );
    }
    /**
    * @dev send the contract balance to the owner
    **/
    function withdrawTips() public
    {
        require(owner.send(address(this).balance));
    }
    
    function getMemos() public view returns(Memo[] memory) 
    {
        return memos;
    }

}
