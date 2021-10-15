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

network SimpleNetworkA
{
    parameters:
        @display("bgb=650,500;bgg=100,1,1grey95");
        
       	@figure[title](type=label; pos=0,-1; anchor=sw; color=darkblue);
       	
       	@figure[sntPkTextA](type=indicatorText; pos=280,20; anchor=w; font=,10; textFormat="msgs sent by A: %g"; initialValue=0);
        @statistic[packetSentA](source=nodeA.app[0].packetSent; record=figure(count); targetFigure=sntPkTextA);
       	@figure[sntPkTextB](type=indicatorText; pos=280,40; anchor=w; font=,10; textFormat="msgs received by B: %g"; initialValue=0);
        @statistic[packetSentB](source=nodeB.app[0].packetSent; record=figure(count); targetFigure=sntPkTextB); 
        @figure[rcvdPkTextA](type=indicatorText; pos=280,60; anchor=w; font=,10; textFormat="replys received from B: %g"; initialValue=0);
        @statistic[packetReceivedA](source=nodeA.app[0].packetReceived; record=figure(count); targetFigure=rcvdPkTextA);
        @figure[fwrdPkTextR1](type=indicatorText; pos=280,80; anchor=w; font=,10; textFormat="msgs forwarded by R1: %g"; initialValue=0);
        @statistic[packetsForwardedR1](source=nodeR1.generic.np.packetsForwarded; record=figure(count); targetFigure=fwrdPkTextR1);
     
    submodules:
        visualizer: <default(firstAvailableOrEmpty("IntegratedCanvasVisualizer"))> like IIntegratedVisualizer if typename != "" {
            @display("p=580,125");
        }
        
        radioMedium: <default("UnitDiskRadioMedium")> like IRadioMedium {
	    	@display("p=580,200");
	    }
        
	    
	    nodeA: <default("AdhocHost")> like INetworkNode {
	    	@display("p=50,325");
	    }
	    
	    nodeB: <default("AdhocHost")> like INetworkNode {
	    	@display("p=200,325");
	    }
	    
	    nodeR1: <default("AdhocHost")> like INetworkNode {
	    	@display("i=device/pocketpc_s;r=,,#707070");
	    	@display("p=125,385");
	    }
	     
//	    nodeR2: <default("AdhocHost")> like INetworkNode {
//	    	@display("i=device/pocketpc_s;r=,,#707070");
//	    	@display("p=100,200");
//	    } 
//	    nodeR3: <default("AdhocHost")> like INetworkNode {
//	    	@display("i=device/pocketpc_s;r=,,#707070");
//	    	@display("p=150,200");
//	    } 
        
    connections allowunconnected:    
}

network SimpleNetworkB
{
    parameters:
        @display("bgb=650,500;bgg=100,1,1grey95");
        
       	@figure[title](type=label; pos=0,-1; anchor=sw; color=darkblue);
       	
       	@figure[sntPkTextA](type=indicatorText; pos=280,20; anchor=w; font=,10; textFormat="msgs sent by A: %g"; initialValue=0);
        @statistic[packetSentA](source=nodeA.app[0].packetSent; record=figure(count); targetFigure=sntPkTextA);	
       	@figure[sntPkTextB](type=indicatorText; pos=280,40; anchor=w; font=,10; textFormat="msgs received by B: %g"; initialValue=0);
        @statistic[packetSentB](source=nodeB.app[0].packetSent; record=figure(count); targetFigure=sntPkTextB);
        @figure[rcvdPkTextA](type=indicatorText; pos=280,60; anchor=w; font=,10; textFormat="replys received from B: %g"; initialValue=0);
        @statistic[packetReceivedA](source=nodeA.app[0].packetReceived; record=figure(count); targetFigure=rcvdPkTextA);
        @figure[fwrdPkTextR1](type=indicatorText; pos=280,80; anchor=w; font=,10; textFormat="msgs forwarded by R1: %g"; initialValue=0);
        @statistic[packetsForwardedR1](source=nodeR1.generic.np.packetsForwarded; record=figure(count); targetFigure=fwrdPkTextR1);
		@figure[fwrdPkTextR2](type=indicatorText; pos=280,100; anchor=w; font=,10; textFormat="msgs forwarded by R2: %g"; initialValue=0);
        @statistic[packetsForwardedR2](source=nodeR2.generic.np.packetsForwarded; record=figure(count); targetFigure=fwrdPkTextR2);
     
    submodules:
        visualizer: <default(firstAvailableOrEmpty("IntegratedCanvasVisualizer"))> like IIntegratedVisualizer if typename != "" {
            @display("p=580,125");
        }
        
        radioMedium: <default("UnitDiskRadioMedium")> like IRadioMedium {
	    	@display("p=580,200");
	    }
        
	    
	    nodeA: <default("AdhocHost")> like INetworkNode {
	    	@display("p=50,325");
	    }
	    
	    nodeB: <default("AdhocHost")> like INetworkNode {
	    	@display("p=200,325");
	    }
	    
	    nodeR1: <default("AdhocHost")> like INetworkNode {
	    	@display("i=device/pocketpc_s;r=,,#707070");
	    	@display("p=125,385");
	    }
	     
	    nodeR2: <default("AdhocHost")> like INetworkNode {
	    	@display("i=device/pocketpc_s;r=,,#707070");
	    	@display("p=125,520");
	    } 
        
    connections allowunconnected:    
}

network SimpleNetworkC
{
    parameters:
        @display("bgb=650,500;bgg=100,1,1grey95");
        
       	@figure[title](type=label; pos=0,-1; anchor=sw; color=darkblue);
       	
       	@figure[sntPkTextA](type=indicatorText; pos=280,20; anchor=w; font=,10; textFormat="msgs sent by A: %g"; initialValue=0);
        @statistic[packetSentA](source=nodeA.app[0].packetSent; record=figure(count); targetFigure=sntPkTextA);	
       	@figure[sntPkTextB](type=indicatorText; pos=280,40; anchor=w; font=,10; textFormat="msgs received by B: %g"; initialValue=0);
        @statistic[packetSentB](source=nodeB.app[0].packetSent; record=figure(count); targetFigure=sntPkTextB);
        @figure[rcvdPkTextA](type=indicatorText; pos=280,60; anchor=w; font=,10; textFormat="replys received from B: %g"; initialValue=0);
        @statistic[packetReceivedA](source=nodeA.app[0].packetReceived; record=figure(count); targetFigure=rcvdPkTextA);

     
    submodules:
        visualizer: <default(firstAvailableOrEmpty("IntegratedCanvasVisualizer"))> like IIntegratedVisualizer if typename != "" {
            @display("p=580,125");
        }
        
        radioMedium: <default("UnitDiskRadioMedium")> like IRadioMedium {
	    	@display("p=580,200");
	    }
        
	    
	    nodeA: <default("AdhocHost")> like INetworkNode {
	    	@display("p=50,325");
	    }
	    
	    nodeB: <default("AdhocHost")> like INetworkNode {
	    	@display("p=200,325");
	    }
	    
	    nodeR1: <default("AdhocHost")> like INetworkNode {
	    	@display("i=device/pocketpc_s;r=,,#707070");
	    	@display("p=125,385");
	    }
	     
	    nodeR2: <default("AdhocHost")> like INetworkNode {
	    	@display("i=device/pocketpc_s;r=,,#707070");
	    	@display("p=85,550");
	    } 
	    nodeR3: <default("AdhocHost")> like INetworkNode {
	    	@display("i=device/pocketpc_s;r=,,#707070");
	    	@display("p=165,550");
	    } 
        
    connections allowunconnected:    
}
