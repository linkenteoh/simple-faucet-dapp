// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

// cannot inherit from other smart contracts
// they can only inherit from other interfaces

// cannot declear constructor
// cannot declear state variables
// all functions have to be declared as external

interface IFaucet { 
    function addFunds() external payable;
    function withdraw(uint withdrawAmount) external;
}