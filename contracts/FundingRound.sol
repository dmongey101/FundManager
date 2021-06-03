// SPDX-License-Identifier: MIT
pragma solidity 0.8.4;

contract FundingRound {
       
    address payable public owner;
    address payable public receiver;
    uint public price;
    uint public remainingAmount;
    
    event Deposit(address sender, uint amount);
    event Withdrawal(address receiver, uint amount);
    
    constructor(
        address payable _owner,
        address payable _receiver,
        uint _price
    ) payable {
        owner = _owner;
        receiver = _receiver;
        price = _price;
        remainingAmount = _price;
        
    }
    
    modifier onlyOwner() {
        require(msg.sender == owner, "Ownly Owner");
        _;
    }
    
    function deposit() public payable {
        
    }

    function depositAmount(uint256 amount) payable public {
        emit Deposit(msg.sender, amount);
        require(msg.value == amount);
     }
    
    function withdraw() payable public onlyOwner {
        emit Withdrawal(owner, address(this).balance);
        // require(remainingAmount == 0, "Funding Round not complete");
        owner.transfer(address(this).balance);
    }

    receive() external payable {
        
    }
}