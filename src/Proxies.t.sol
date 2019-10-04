pragma solidity ^0.5.10;

import "ds-test/test.sol";

import "./ProxyCode.sol";
import "./Factory.sol";
import "./Logic.sol";

contract ProxiesTest is DSTest, Factory, HuffProxies {

    address internal logic;
    address internal proxyConstant;
    address internal proxyStorage;
    address internal proxy2d;

    function setUp() public {
        logic = address(new Logic());
        proxyConstant = deploy(proxyConstant_init);
        proxyStorage = deploy(abi.encodePacked(proxyStorage_init, bytes32(uint256(logic))));
        // proxy2d = deploy(abi.encodePacked(proxy2d_init, bytes32(uint256(logic))));
    }

    function testDeployment() public {
        assertEq(proxyConstant_hash, codehash(proxyConstant));
        assertEq(proxyStorage_hash, codehash(proxyStorage));
        // assertEq(proxy2d_hash, codehash(proxy2d));
    }

    function codehash(address addr) internal view returns (bytes32 hash) {
        assembly { hash := extcodehash(addr) }
    }

}
