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

#include "App.h"

Define_Module(App);

void App::initialize()
{
    // TODO - Generated method body
    myAddress = par("address");

    numSent = 0;
    numReceived = 0;

    WATCH(numSent);
    WATCH(numReceived);


    throw cRuntimeError("myAddress \"%i\"", myAddress);

}

void UdpBasicApp::finish()
{
    recordScalar("packets sent", numSent);
    recordScalar("packets received", numReceived);
}

void App::handleMessage(cMessage *msg)
{
    // TODO - Generated method body
}
