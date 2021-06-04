// SPDX-License-Identifier: MIT
pragma solidity 0.8.4;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract Fund {
       
    address payable public owner;
    address[] public managers;
    address[] internal trackedAssets;
    mapping(address => bool) internal addressIsManager;
    mapping(address => bool) internal assetToIsTracked;
    
    event Deposit(address sender, uint amount);
    event Withdrawal(address receiver, uint amount);
    event ManagerAdded(address manager);
    
    constructor(
        address payable _owner
    ) payable {
        owner = _owner;
    }
    
    modifier onlyOwner() {
        require(msg.sender == owner, "Ownly Owner");
        _;
    }

    modifier onlyManagers() {
        require(isFundManager(msg.sender), "Must be a fund manager");
        _;
    }

    function addManagers(address _manager) public onlyOwner {
        if (!isFundManager(_manager)) {
            addressIsManager[_manager] = true;
            managers.push(_manager);
            emit ManagerAdded(_manager);
        }
    }
    
    function depositAmount(uint256 amount) payable public {
        emit Deposit(msg.sender, amount);
        require(msg.value == amount);
     }
    
    function withdraw() payable public onlyManagers {
        emit Withdrawal(owner, address(this).balance);
        // require(remainingAmount == 0, "Funding Round not complete");
        owner.transfer(address(this).balance);
    }

    function addTrackedAsset(address _asset) external onlyManagers {
        if (!isTrackedAsset(_asset)) {
            assetToIsTracked[_asset] = true;
            trackedAssets.push(_asset);
        }
    }

    receive() external payable {}

    function isTrackedAsset(address _asset) public view returns (bool isTrackedAsset_) {
        return assetToIsTracked[_asset];
    }

    function isFundManager(address _manager) public view returns (bool isFundManager_) {
        return addressIsManager[_manager];
    }
}