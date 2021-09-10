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

#include "TarpBasicApp.h"

#include <iostream>

#include "inet/common/Protocol.h"
#include "inet/networklayer/contract/L3Socket.h"
#include "inet/networklayer/common/L3AddressResolver.h"
#include "inet/networklayer/common/L3AddressTag_m.h"
#include "inet/common/ProtocolTag_m.h"
#include "inet/common/packet/chunk/ByteCountChunk.h"
#include "inet/networklayer/common/EchoPacket_m.h"

using std::cout;
using inet::INITSTAGE_LOCAL;
using inet::Protocol;
using inet::L3Socket;
using inet::L3AddressResolver;
using inet::L3AddressReq;
using inet::PacketProtocolTag;
using inet::makeShared;
using inet::ByteCountChunk;
using inet::B;
using inet::EchoPacket;

Define_Module(TarpBasicApp);

const std::map<const Protocol*, const Protocol*> TarpBasicApp::l3Echo( {
{ &Protocol::flooding, &Protocol::echo },
{ &Protocol::tarpf, &Protocol::echo }
});

TarpBasicApp::TarpBasicApp() {
}

TarpBasicApp::~TarpBasicApp() {
    cancelAndDelete(event);
    socketMap.deleteSockets();
}

void TarpBasicApp::initialize(int stage) {

    // TODO - Generated method body

    ApplicationBase::initialize(stage);

    if (stage == INITSTAGE_LOCAL) {

        // read params
        packetSize = par("packetSize");
        sendIntervalPar = &par("sendInterval");
        sleepDurationPar = &par("sleepDuration");
        hopLimit = par("hopLimit");
        startTime = par("startTime");
        stopTime = par("stopTime");
        if (stopTime >= SIMTIME_ZERO && stopTime < startTime)
            throw cRuntimeError("Invalid startTime/stopTime parameters");

        //state
        pid = -1;

        // statistics
        numSent = 0;
        numReceived = 0;
        WATCH(numSent);
        WATCH(numReceived);

        // references
        event = new cMessage("event");

    }

}

void TarpBasicApp::parseDestAddressesPar() {
    srcAddr = L3AddressResolver().resolve(par("srcAddr"));
    const char *destAddrs = par("destAddr");
    if (!strcmp(destAddrs, "*")) {
//        destAddresses = getAllAddresses();
    } else {
        cStringTokenizer tokenizer(destAddrs);
        const char *token;

        while ((token = tokenizer.nextToken()) != nullptr) {
            L3Address addr = L3AddressResolver().resolve(token);
            destAddresses.push_back(addr);
        }
    }
}

void TarpBasicApp::handleSelfMessage(cMessage *msg) {

    if (msg == event) {

        srcAddr = L3AddressResolver().resolve(par("srcAddr"));
        parseDestAddressesPar();
        if (destAddresses.empty()) {
            return;
        }
        destAddrIdx = 0;

        if (destAddrIdx >= (int) destAddresses.size())
            return;
        destAddr = destAddresses[destAddrIdx];

        EV_INFO << "Starting up: dest=" << destAddr << "  src=" << srcAddr
                       << "seqNo=" << sendSeqNo << endl;

        ASSERT(!destAddr.isUnspecified());

        const Protocol *networkProtocol = nullptr;
        const char *networkProtocolAsString = par("networkProtocol");

        networkProtocol = Protocol::getProtocol(networkProtocolAsString);

        const Protocol *icmp = l3Echo.at(networkProtocol);

        for (auto socket : socketMap.getMap()) {
            socket.second->close();
        }

        currentSocket = nullptr;

        currentSocket = new L3Socket(networkProtocol, gate("socketOut"));

        currentSocket->bind(icmp, L3Address());
        currentSocket->setCallback(this);

        // send a message

        char name[32];
        sprintf(name, "TARP-%ld", sendSeqNo);

        Packet *outPacket = new Packet(name);
        auto payload = makeShared<ByteCountChunk>(B(packetSize));

        const auto& request = makeShared<EchoPacket>();
        request->setChunkLength(B(8));
        request->setType(inet::ECHO_PROTOCOL_REQUEST);
        request->setIdentifier(pid);
        request->setSeqNumber(sendSeqNo);
        outPacket->insertAtBack(payload);
        outPacket->insertAtFront(request);

        outPacket->addTag<PacketProtocolTag>()->setProtocol(&Protocol::echo);

        auto addressReq = outPacket->addTag<L3AddressReq>();
        addressReq->setSrcAddress(srcAddr);
        addressReq->setDestAddress(destAddr);

        currentSocket->send(outPacket);

        sendSeqNo++;

    }

}

void TarpBasicApp::handleMessage(cMessage *msg) {
    // TODO - Generated method body
    if (msg->isSelfMessage()) {
        handleSelfMessage(msg);
    }

}

void TarpBasicApp::refreshDisplay() const {
    char buf[100];
    sprintf(buf, "rcvd: %d pks\nsent: %d pks", numReceived, numSent);
    getDisplayString().setTagArg("t", 0, buf);
}

void TarpBasicApp::handleMessageWhenUp(cMessage *msg) {

    throw cRuntimeError("Debug::handleMessageWhenUp");

    if (msg->isSelfMessage()) {
        handleSelfMessage(msg);
    }

}

void TarpBasicApp::handleStartOperation(LifecycleOperation *operation) {
    startSendingMessages();
}

void TarpBasicApp::startSendingMessages() {
    scheduleAt(simTime(), event);
}

void TarpBasicApp::handleStopOperation(LifecycleOperation *operation) {
    if (socketMap.size() > 0) {
        for (auto socket : socketMap.getMap())
            socket.second->close();
    }
}

void TarpBasicApp::handleCrashOperation(LifecycleOperation *operation) {
    for (auto socket : socketMap.getMap())
        socket.second->destroy();
    socketMap.deleteSockets();
}

void TarpBasicApp::socketDataArrived(INetworkSocket *socket, Packet *packet) {

}

void TarpBasicApp::socketClosed(INetworkSocket *socket) {
    if (socket == currentSocket)
        currentSocket = nullptr;
    delete socketMap.removeSocket(socket);
}

