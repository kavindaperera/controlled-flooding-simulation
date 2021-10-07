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
        @display("bgb=500,500;bgg=100,1,1grey95");
        int numNodes @prompt("Number of nodes") = default(9);
        
       	@figure[title](type=label; pos=0,-1; anchor=sw; color=darkblue);
       	
//       	@figure[rcvdPkText](type=indicatorText; pos=510,60; anchor=w; font=,12; textFormat="packets received by A: %g"; initialValue=0);
//        @statistic[packetReceived](source=nodeA.app[0].packetReceived; record=figure(count); targetFigure=rcvdPkText);
//	    
//	    @figure[rcvdPkText2](type=indicatorText; pos=510,40; anchor=w; font=,12; textFormat="packets received by B: %g"; initialValue=0);
//        @statistic[packetSentBack](source=nodeB.app[0].packetReceived; record=figure(count); targetFigure=rcvdPkText2);
//        
        @figure[sntPkText](type=indicatorText; pos=510,20; anchor=w; font=,12; textFormat="packets sent: %g"; initialValue=0);
        @statistic[packetSent](source=node[17].app[0].packetSent; record=figure(count); targetFigure=sntPkText);


     
    submodules:
        visualizer: <default(firstAvailableOrEmpty("IntegratedCanvasVisualizer"))> like IIntegratedVisualizer if typename != "" {
            @display("p=460,100");
        }
        
        radioMedium: <default("UnitDiskRadioMedium")> like IRadioMedium {
	    	@display("p=460,300");
	    }
	    
//	    configurator: Ipv4NetworkConfigurator {
//            @display("p=460,200");
//        }
        
        node[numNodes]: <default("AdhocHost")> like INetworkNode {
	    	@display("i=device/pocketpc_s;r=,,#707070");
	    } 
	    
//	    nodeA: <default("AdhocHost")> like INetworkNode {
//	    	@display("p=100,400");
//	    }
//	    
//	    nodeB: <default("AdhocHost")> like INetworkNode {
//	    	@display("p=400,100");
//	    }
        
    connections allowunconnected:    
}
