#CCN assignment
#Chen Kai 1948361

class packet:
    def __init__(self,counter,message,lastnode=None):
        self.counter=counter    #counter=10; decremented on each hop, discard packet when counter=0
        self.message=message    #information of data
        self.lastnode=lastnode  #destination node
class node:                     #declare node class
    def __init__(self,n):
        self.No=n               #Using n to mark number of node,besides node0 is source node
        self.receiveBuffer=[]   #Receive buffer:Use list receiveBuffer to store the packet sent from the former node;
        self.sendBuffer=[]      #SendBuffer:Send packets to neighbour nodes
        self.neighbour_node=[]  #The node's other neighbour nodes
        self.lastBuffer=[]      #Store the data from destination node
    def addnode(self,*node):
        for n in node:
            self.neighbour_node.append(n)  #Add elements to the end of list.

    def sendPacket(self):       #Send packets from sendBuffer to other nodes
        for packet in self.sendBuffer:
            for node in self.neighbour_node:             #Get neighbour nodes of the node
                if packet not in node.receiveBuffer:        #The packet not in the receive buffer of neighbour_nodes
                    if packet.counter>0:                 #Determine value of counter
                       node.receiveBuffer.append(packet)    #Add element to receive buffer

    def receivePacket(self,n):
        self.sendBuffer.clear()
        for packet in self.receiveBuffer:
            if packet.lastnode==self:              #Determine if node is destination_node
                if packet not in self.lastBuffer:  #Determine if packet has not been sent to destination node
                    self.lastBuffer.append(packet) #Append packet to lastBuffer
            if packet.counter<=0:                  #Delete packet if counter<=0
                self.receiveBuffer.remove(packet)
            elif packet.counter>0 and packet.lastnode!=self: #Do not let packet sent to destination node
                self.sendBuffer=self.receiveBuffer[:]        #Send packet to sendBuffer
            else:
                pass
    def showsendBuffer(self):
        print( 'sendBuffer: There are %d items'%len(self.sendBuffer))   #Show sendBuffer information
        for packet in self.sendBuffer:
            print('packet_%d: counter %d'%(self.sendBuffer.index(packet)+1,packet.counter))


nodes=[]     #Defining other related nodes
for n in range(0,16):          #range from 0-15
    nodes.append(node(n))

packet_1=packet(10,"Practical python ",nodes[15])
nodes[0].sendBuffer.append(packet_1)  # Let packet_1 in buffer of node0
nodes[0].showsendBuffer()
nodes[0].addnode(nodes[1],nodes[4],nodes[5])   #Define neighbour nodes 1,4,5
nodes[1].addnode(nodes[2],nodes[5],nodes[0])   #Define neighbour nodes 0 2 5
nodes[4].addnode(nodes[0],nodes[8],nodes[5])
nodes[8].addnode(nodes[4],nodes[9],nodes[12])
nodes[12].addnode(nodes[8],nodes[13])
nodes[13].addnode(nodes[9],nodes[12],nodes[14])
nodes[5].addnode(nodes[0],nodes[1],nodes[4],nodes[6],nodes[9],nodes[10])
nodes[6].addnode(nodes[2],nodes[5],nodes[7],nodes[10])
nodes[9].addnode(nodes[5],nodes[8],nodes[10],nodes[13])
nodes[10].addnode(nodes[5],nodes[6],nodes[9],nodes[11],nodes[14],nodes[15])
nodes[2].addnode(nodes[1],nodes[3],nodes[6])
nodes[3].addnode(nodes[2],nodes[7])
nodes[7].addnode(nodes[3],nodes[6],nodes[11])
nodes[11].addnode(nodes[7],nodes[10],nodes[15])
nodes[14].addnode(nodes[10],nodes[13],nodes[15])
nodes[15].addnode(nodes[10],nodes[11],nodes[14])

for m in range(1,11):                   #Loop times is 10
    print('==================This is %dth time sending=================='%(m))
    for n in range(0,16):               #Every node will send packet between a cycle
        nodes[n].sendPacket()
    for n in range(0,16):
        nodes[n].receivePacket(n)
    for n in range(0,16):
        print('============node%d============'%n)
        nodes[n].showsendBuffer()       #After looping, show information
    packet_1.counter-=1                 #Decrease counter on each hop
print(nodes[15].lastBuffer[0].message)