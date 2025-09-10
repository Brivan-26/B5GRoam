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
        a[0] = uint256(15882955061403184557037064208516227838016749838970878302289330773855532269110); // pi_a[0]
        a[1] = uint256(12613589666212600940116457561167867859361769994814728157547757410063755665769); // pi_a[1]

        uint256[2][2] memory b;
        b[0][0] = uint256(11634832880952742160669348568280358265703810743504973033095976180243860526109); // pi_b[0][1]
        b[0][1] = uint256(2532462282337364156503226862365378199287647545605120190230932773646667965516); // pi_b[0][0]
        b[1][0] = uint256(5748004839970732078434564493698044841939198774735484166522488084140817913654); // pi_b[1][1]
        b[1][1] = uint256(18014530795201672201185604184777358744277066564232057748775542625800722212099); // pi_b[1][0]

        uint256[2] memory c;
        c[0] = uint256(9610478808465771200807971884463129857661336495029251705428059492039137637403); // pi_c[0]
        c[1] = uint256(6374435096952530003141457434138259035117412629414780888639987816316260909280); // pi_c[1]

        // total is : 12e6(10 + 10240 + 60) = 123720e6
        uint totalCost = 123720e6;

        vm.startBroadcast(mno2PrivateKey);
        agreement.terminateRoamingSession(lastSession, a, b, c, totalCost);
        vm.stopBroadcast();

    }
}