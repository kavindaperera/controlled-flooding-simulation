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

#ifndef __TARP_SIM_TARPBASICAPP_H_
#define __TARP_SIM_TARPBASICAPP_H_

#include <omnetpp.h>

#include "inet/common/INETDefs.h"

#include "inet/applications/base/ApplicationBase.h"
#include "inet/networklayer/common/L3Address.h"
#include "inet/common/Protocol.h"
#include "inet/common/socket/SocketMap.h"
#include "inet/networklayer/common/L3Address.h"
#include "inet/networklayer/contract/INetworkSocket.h"
#include "inet/common/packet/Packet.h"
#include "inet/common/lifecycle/LifecycleOperation.h"

using namespace omnetpp;
using inet::Protocol;
using inet::SocketMap;
using inet::INetworkSocket;
using inet::Packet;
using inet::L3Address;
using inet::LifecycleOperation;
using inet::ApplicationBase;

/**
 * TODO - Generated class
 */
class TarpBasicApp : public ApplicationBase, public INetworkSocket::ICallback
{
    protected:

        // parameters
        L3Address destAddr;
        L3Address srcAddr;
        std::vector<L3Address> destAddresses;
        int packetSize = 0;
        cPar *sendIntervalPar = nullptr;
        cPar *sleepDurationPar = nullptr;
        int hopLimit = 0;
        int destAddrIdx = -1;
        simtime_t startTime;
        simtime_t stopTime;

        //state
        SocketMap socketMap;
        INetworkSocket *currentSocket = nullptr;   // current socket stored in socketMap, too
        int pid = 0;    // to determine which hosts are associated with the responses
        cMessage *event = nullptr;
        long sendSeqNo = 0;

        static const std::map<const Protocol *, const Protocol *> l3Echo;

        // statistics
        int numSent = 0;
        int numReceived = 0;

        // references


    protected:
        virtual void initialize(int stage) override;
        virtual void handleMessage(cMessage *msg) override;
        virtual void refreshDisplay() const override;
        virtual void handleMessageWhenUp(cMessage *msg) override;

        void handleSelfMessage(cMessage *msg);

        virtual void parseDestAddressesPar();
        virtual void startSendingMessages();

        //INetworkSocket::ICallback:
        virtual void socketDataArrived(INetworkSocket *socket, Packet *packet) override;
        virtual void socketClosed(INetworkSocket *socket) override;

        /* Lifecycle */
        virtual void handleStartOperation(LifecycleOperation *operation) override;
        virtual void handleStopOperation(LifecycleOperation *operation) override;
        virtual void handleCrashOperation(LifecycleOperation *operation) override;

    public:
        TarpBasicApp();
        virtual ~TarpBasicApp();

};


#endif
