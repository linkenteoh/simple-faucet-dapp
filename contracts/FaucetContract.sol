// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;
import "./Owned.sol";
import "./Logger.sol";
import "./IFaucet.sol";

contract Faucet is Owned, Logger, IFaucet{
    // External function are part of the contract interface
    // which means they can be called via contracts and other tx
    uint public numOfFunders;

    mapping(address => bool) private funders;
    mapping(uint => address) private lutFunders;

    modifier limitWithdraw(uint withdrawAmount) {
        require(withdrawAmount <= 100000000000000000, "Cannot withdraw more than 0.1 ether" );
        _;
    }

    receive() external payable {}

    function emitLog() public override pure returns(bytes32) {
        return "Hello World";
    }

    function addFunds() external override payable {
        // funders[index] = msg.sender;
        address funder = msg.sender;

        if (!funders[funder]) {
            uint index = numOfFunders++;
            funders[funder] = true;
            lutFunders[index] = funder;
        }
    }

    function test() external onlyOwner() {

    }

    function withdraw(uint withdrawAmount) external override limitWithdraw(withdrawAmount) {
        payable(msg.sender).transfer(withdrawAmount);
    }

    function getAllFunders() external view returns (address[] memory) {
        address[] memory _funders = new address[](numOfFunders);

        for (uint256 index = 0; index < numOfFunders; index++) {
            _funders[index] = lutFunders[index];
        }

        return _funders;
    }

    function getFunderAtIndex(uint8 index) external view returns (address){
        return lutFunders[index];
    }   
    
    // const instance = await Faucet.deployed()
    // instance.addFunds({from: accounts[0], value:"2000000000000000000"})
    // instance.addFunds({from: accounts[1], value:"2000000000000000000"})

    // instance.withdraw("100000000000000000", {from: accounts[1]})

    // Pure, view modifiers - read-only call, no gas fee
    // View - indicating that it won't alter the storage state
    // Pure - stricter, indicating that it won't even read the storage state
}