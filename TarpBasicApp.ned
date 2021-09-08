//
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU Lesser General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
// 
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU Lesser General Public License for more details.
// 
// You should have received a copy of the GNU Lesser General Public License
// along with this program.  If not, see http://www.gnu.org/licenses/.
// 

//
// TODO auto-generated module
//

import inet.applications.contract.IApp;

simple TarpBasicApp like IApp
{
    parameters:
        string destAddr = default(""); // destination address, "*" means all
        string srcAddr = default(""); // source address 
        int packetSize @unit(B) = default(56B); // of message payload, in bytes
        int hopLimit = default(-1); // TTL or hopLimit for packets
        volatile double sendInterval @unit(s) = default(1s); // time to wait between messsages (can be random)
        double startTime @unit(s) = default(uniform(0s, this.sleepDuration + this.sendInterval)); // send first messsages at startTime
        double stopTime @unit(s) = default(-1s); // time to finish sending, negative values mean forever
        volatile double sleepDuration @unit(s) = default(0s); // time spent in sleep between switching destinations
        string networkProtocol = default("flooding");
        @display("i=block/app");
        
    gates:
        input socketIn;
        output socketOut;
}
