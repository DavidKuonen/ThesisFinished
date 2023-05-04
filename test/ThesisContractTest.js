const ThesisContract = artifacts.require("ThesisContract");


contract("ThesisContract", function(accounts) {
    before(async () =>{
     ThesisContractInstance = await ThesisContract.deployed();
    } )

    it("Room 1 should be Vacant at the start", async () => {     
      const RoomInstance = await ThesisContractInstance.allRooms(0);
      const Status = RoomInstance.currentStatus;
      
        assert.equal(Status,0, 'Room 1 is not Vacant');     
    });

    it("Room 1 should be Occupied after booking it", async () => {
        await ThesisContractInstance.book(0, {from: accounts[0], value: web3.utils.toWei('2','ether')});

        const RoomInstance = await ThesisContractInstance.allRooms(0);
        const Status = RoomInstance.currentStatus;
        
          assert.equal(Status,1, 'Room 1 is not Occupied after booking');     
      });

    
  });