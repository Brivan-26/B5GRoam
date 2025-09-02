// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Script.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "../src/Agreement.sol";
import {Vm} from "forge-std/Vm.sol";
import {console} from "forge-std/console.sol";
import "../test/Poseidon.sol";

contract SettleRoamingSession is Script {
    function run() external {
        Agreement agreement = Agreement(0x420a1bC7AA832E2521389c618bC7D309b8F4F1df);
        uint lastSession = agreement.sessionCounter();

        uint256 mno2PrivateKey = 0x8b506681f432e9d3765c7452a37b063010939cc388784fee99a896e827338f32;
        
        uint256[2] memory a;
        a[0] = uint256(0x11a0df597d890ebb2e588ac6bfba02078ac074ee8ad81f77feb34dc954b00d18);
        a[1] = uint256(0x1fb8bd8136e118504767335412f96fdf0cf63b9d469b84a31237d021b27ad26a);

        uint256[2][2] memory b;
        b[0][0] = uint256(0x25811037df60e0fbce5c8cf5cae576205127786468212240e4209607d6f366a1);
        b[0][1] = uint256(0x244c2ae874a7734bc3b342af86032fd4c51de9f6018d3b7006330f55fc747e89);
        b[1][0] = uint256(0x20f82fe49897c4f2837d7c11ba69b143a6029e59dc95ae34b7cbda59cbd979bd);
        b[1][1] = uint256(0x16f04b36ebc70d12d6dc9278b37416b76760e2ecfe41280421feaec9703f45b6);

        uint256[2] memory c;
        c[0] = uint256(0x14929aadecb4cc91451ce9976c8f9c725547f81bead40e4b32ae7e1f23240c36);
        c[1] = uint256(0x09fce74ff52f64556f90c99bbf9e2a5998d1739456cd097e9a19f76f00fc90ae);

        // total is : 12e6(10 + 10240 + 60) = 123720e6
        uint totalCost = 123720e6;

        vm.startBroadcast(mno2PrivateKey);
        agreement.terminateRoamingSession(lastSession, a, b, c, totalCost);
        vm.stopBroadcast();

    }
}