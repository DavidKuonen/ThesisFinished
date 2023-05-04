// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract ThesisContract {

    //Mapping of an address with a Room
    mapping(address => Room) public myRoom;

    //Enumeration for statuses that can be either Vacant or Occupied
    enum Statuses {
        Vacant,
        Occupied
    }

    //Structure Room that has an id and a status consisting of the enum
    struct Room {
        int id;
        Statuses currentStatus;
    }

    //An array of the struct Type "Room"
    Room[] public allRooms;

    //An address called owner that is payable, which means it can receive ETH
    address payable public owner;

    constructor() {
        //Set owner to the creater of the contract
        owner = payable(msg.sender);
        //You can add Rooms to the allRooms array with the "push()" method. 
        //It is added at the end of the existing array
        allRooms.push(Room(0, Statuses.Vacant));
        allRooms.push(Room(1, Statuses.Vacant));
        allRooms.push(Room(2, Statuses.Vacant));
        allRooms.push(Room(3, Statuses.Vacant));
    }

    //modifiers can be created and added to functions to make sure 
    //a certain condition is met
    modifier onlyWhileVacant(uint id) {
        require(
            allRooms[id].currentStatus == Statuses.Vacant,
            "Currently occupied."
        );
        //The placeholder statement("_") is used to denote where the body 
        //of the function being modified should be inserted
        _;
    }
    modifier costs(uint256 _amount) {
        require(msg.value >= _amount, "Not enough Ether provided.");
        _;
    }

    //The 2 previously defined modifiers are applied, Multiple modifiers
    // are applied to a function by specifying them in a whitespace-separated
    // list and are evaluated in the order presented
    function book(uint _id) public payable onlyWhileVacant(_id) costs(2 ether) {
        allRooms[_id].currentStatus = Statuses.Occupied;
        owner.transfer(msg.value);
        myRoom[msg.sender] = allRooms[_id];
    }
}
