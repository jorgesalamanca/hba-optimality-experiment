# An experiment to empirically evaluate a model for learning to interact

Developed and tested in Matlab.

This project is a game-theoretic experiment in which an agent has to learn to interact with others without any previous information about them. This is achieved thanks to the Harsanyi-Bellman Ad-hoc Coordination model, or in short, HBA (as defined by Albrecht and Ramamoorthy in 2013, [original paper]( https://arxiv.org/abs/1506.01170), [convergence and optimality](https://dslpitt.org/uai/papers/14/p12-albrecht.pdf).

The experiment consists of our main agent controlled by HBA, "the ad-hoc agent", another agent(s) which may have any sort of behaviour, and food(s), which the agents must coordinate and "attack/eat" at the same time in order to gain a reward. It is set in a grid-like world, in which agents and foods may occupy only one square at a time, and may not overlap. At every iteration, the agents may move up, down, left or right or try to attack/eat a food. Attack/eat action may be performed at any time, but will only work if there are 2 agents adjacent to a food and they both attack/eat.

The goal of HBA is to provide the agent with a series of actions as it knew before-hand what the others will do, which would be considered the optimal solution. In order to verify this, the Markov chains of the ad-hoc agent in both scenarios are generated (knowing what the others will do vs. the prediction). If a bisimulation equivalence exists between these two chains, the experiment is indeed providing empirical evidence supporting the claim that HBA is able to plan as if it knew what the others would do.

* by Jorge Salamanca, July 2015.