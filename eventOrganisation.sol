//SPDX-License-Identifier:UNLICENSED
pragma solidity >=0.7.0 <0.9.0;
contract eventOrganise
{

struct Event 
{   
    address organisor;
    string name;
    uint date;
    uint price;
    uint ticketCount;
    uint ticketRemain;
}
    

    mapping(uint=>Event) public events;
    mapping(address=>mapping(uint => uint)) public tickets;  //2D type table 
    uint nextId;

    function createEvent(string memory name,uint price , uint date ,uint ticketCount) external{
        require(date>block.timestamp,"Now you can register for future");
        require(ticketCount>0,"You can organise an event only if you have more than 0 tickets");
        events[nextId]=
        Event(msg.sender,name,date,price,ticketCount,ticketCount);
        nextId++;
    }

    function buyTicket(uint id,uint quantity) external payable
    {   
        require(events[id].date!=0,"Event does not exist");
        require(events[id].date>block.timestamp,"Event has already been occured");
        Event storage _event= events[id];
        require(msg.value==(_event.price*quantity),"Insufficient Ether");
        _event.ticketRemain-=quantity;
        tickets[msg.sender][id]+=quantity;
    }

    function transferTicket(uint id,uint quantity,address to) external{
        require(events[id].date!=0,"Event does not exist");
        require(events[id].date>block.timestamp,"Event has already been occured");
        require(tickets[msg.sender][id]>=quantity,"Insufficient Quantity");
        tickets[msg.sender][id]-=quantity;
        tickets[to][id]+=quantity;
    } 

}





