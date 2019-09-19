# -*- coding: utf-8 -*-
"""
Created on Mon Mar 18 22:38:30 2019

@author: dell
"""

import math
import random

random.seed(0)

# Make a matrix
def makeMatrix(I, J, fill=0.0):
    m = []
    for i in range(I):
        m.append([fill]*J)
    return m

# Sigmoid Function
def sigmoid(net):
    return 1.0/(1.0 + math.exp(-net))

# Derivative of Sigmoid Function
def dsigmoid(y):
    return y*(1.0 - y) 

class NeuralNetwork:
    def __init__(self, ni, nh, no):
        # ni,nh,no are the number of input, hidden, and output nodes separately
        self.ni = ni + 1   # +1 for bias node
        self.nh = nh + 1   # +1 for bias node
        self.no = no

        # Activations for nodes
        self.ai = [1.0]*self.ni
        self.ah = [1.0]*self.nh
        self.ao = [1.0]*self.no
        
        # Create weights
        self.wi = makeMatrix(self.ni, self.nh)
        self.wo = makeMatrix(self.nh, self.no)
        # Set them to random vaules
        for i in range(self.ni):
            for j in range(self.nh):
                self.wi[i][j] = random.gauss(0,0.2)
        for j in range(self.nh):
            for k in range(self.no):
                self.wo[j][k] = random.gauss(0,0.2)
        # Last change in weights for momentum   
        self.ci = makeMatrix(self.ni, self.nh)
        self.co = makeMatrix(self.nh, self.no)

    def update(self, inputs):
        if len(inputs) != self.ni-1:
            raise ValueError('Wrong number of inputs')

        # Input activations
        for i in range(self.ni-1):
            self.ai[i] = inputs[i]

        # Hidden activations
        for j in range(self.nh-1):
            sum = 0.0
            for i in range(self.ni):
                sum = sum + self.ai[i] * self.wi[i][j]
            self.ah[j] = sigmoid(sum)

        # Output activations
        for k in range(self.no):
            sum = 0.0
            for j in range(self.nh):
                sum = sum + self.ah[j] * self.wo[j][k]
            self.ao[k] = sigmoid(sum)

        return self.ao[:]


    def EBP(self, targets, N, M):
        if len(targets) != self.no:
            raise ValueError('Wrong number of target values')

        # Calculate error terms for output
        output_deltas = [0.0] * self.no
        for k in range(self.no):
            error = targets[k]-self.ao[k]
            output_deltas[k] = dsigmoid(self.ao[k]) * error

        # Calculate error terms for hidden
        hidden_deltas = [0.0] * self.nh
        for j in range(self.nh):
            error = 0.0
            for k in range(self.no):
                error = error + output_deltas[k]*self.wo[j][k]
            hidden_deltas[j] = dsigmoid(self.ah[j]) * error

        # Update output weights
        for j in range(self.nh):
            for k in range(self.no):
                change = output_deltas[k]*self.ah[j]
                self.wo[j][k] = self.wo[j][k] + N*change + M*self.co[j][k]
                self.co[j][k] = N*change + M*self.co[j][k]

        # Update input weights
        for i in range(self.ni):
            for j in range(self.nh):
                change = hidden_deltas[j]*self.ai[i]
                self.wi[i][j] = self.wi[i][j] + N*change + M*self.ci[i][j]
                self.ci[i][j] = N*change + M*self.ci[i][j]

        # Calculate error
        error = 0.0
        for k in range(len(targets)):
            error = error + 0.5*(targets[k]-self.ao[k])**2
        return error


    def test(self, patterns):
        for p in patterns:
            print(p[0], '->', self.update(p[0]))

    def weights(self):
        print('Input weights:')
        for i in range(self.ni):
            print(self.wi[i])
        print()
        print('Output weights:')
        for j in range(self.nh):
            print(self.wo[j])
    def train(self, patterns, N=0.1, M=0.9):
   # N is learning rate, and M is momentum factor
        for i in range(1000):  # iterations=1000
            error = 0.0
            for p in patterns:
                inputs = p[0]
                targets = p[1]
                self.update(inputs)
                error = error + self.EBP(targets, N, M)            

def demo():
    # Teach network XOR function
    pat = [ [[0.9,0.1,0.1,0.1], [0.9,0.1,0.1,0.1]],
        [[0.9,0.1,0.1,0.1], [0.9,0.1,0.1,0.1]],
        [[0.9,0.1,0.1,0.1], [0.9,0.1,0.1,0.1]],
        [[0.9,0.1,0.1,0.1], [0.9,0.1,0.1,0.1]] ]

    # Create a network with four input, two hidden, and four output nodes
    n = NeuralNetwork(4, 2, 4)
    # Train it with some patterns
    n.train(pat)
    # Test it
    n.test(pat)


if __name__ == '__main__':
    demo()
