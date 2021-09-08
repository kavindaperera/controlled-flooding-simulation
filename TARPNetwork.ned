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

import inet.networklayer.configurator.ipv4.Ipv4NetworkConfigurator;
import inet.physicallayer.contract.packetlevel.IRadioMedium;
import inet.visualizer.contract.IIntegratedVisualizer;
import inet.networklayer.ipv4.RoutingTableRecorder;
import inet.node.inet.INetworkNode;

network TARPNetwork
{
    parameters:
        @display("bgb=600,600;bgg=100,1,1grey95");
        int numNodes @prompt("Number of nodes") = default(9);
     
    submodules:
        visualizer: <default(firstAvailableOrEmpty("IntegratedCanvasVisualizer"))> like IIntegratedVisualizer if typename != "" {
            @display("p=580,100");
        }
        
        radioMedium: <default("UnitDiskRadioMedium")> like IRadioMedium {
	    	@display("p=580,300");
	    }
	    
	    configurator: Ipv4NetworkConfigurator {
            @display("p=580,200");
        }
        
        node[numNodes]: <default("AdhocHost")> like INetworkNode {
	    	@display("i=device/pocketpc_s;r=,,#707070");
	    } 
	    
	    nodeA: <default("AdhocHost")> like INetworkNode {
	    	@display("p=100,500");
	    }
	    
	    nodeB: <default("AdhocHost")> like INetworkNode {
	    	@display("p=500,100");
	    }
        
    connections allowunconnected:    
}
