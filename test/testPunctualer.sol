pragma solidity ^0.4.21;

import "truffle/Assert.sol";
import "truffle/DeployedAddresses.sol";
import "../contracts/Punctualer.sol";

contract TestPunctualer {
    Punctualer p = Punctualer(DeployedAddresses.Punctualer());

    function testParticipate() public {
        /* p.participate.value(1).gas(100)("18511092920");
        Assert.equal(p.balanceOf(address(this)), 1, "participate value is 1."); */
    }
}
