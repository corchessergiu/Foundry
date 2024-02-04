pragma solidity 0.8.20;

import "@openzeppelin/contracts/access/Ownable.sol";

contract TestOz is Ownable {
    address public initialOwner;

    constructor(address _initialOwner) Ownable(_initialOwner) {
        initialOwner = _initialOwner;
    }
}
