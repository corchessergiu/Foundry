pragma solidity 0.8.20;

import "forge-std/Test.sol";

contract SignTest is Test {
    // private key = 123
    // public key = vm.addr(private key)
    // message = "secret message"
    // message hash = keccak256(message)
    // vm.sign(private key, message hash)

    function testSignature() public {
        uint256 privateKey = 123;
        // compute public key with vm.addr
        address pubKey = vm.addr(privateKey);
        bytes32 messaeHash = keccak256("Secret message");
        (uint8 v, bytes32 r, bytes32 s) = vm.sign(privateKey, messaeHash);

        address signer = ecrecover(messaeHash, v, r, s);
        assertEq(signer, pubKey);
    }
}
