clear; clc;
close all;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% MAIN VARIABLES TO SET-UP THE GAME %

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

global rows cols foodLocs nFoods foodLoad foodLoadReward elseReward nJA;
global nAgents type2aux nActions nJointActions nStates nLocs foodLocsXY;

rows = 4; cols = 7; nLocs = rows*cols;

% Variables to hold the Gridmap
X = zeros(rows+1, cols+1); Y = zeros(rows+1, cols+1);
for i=0:rows
    for j=0:cols
        X(i+1,j+1)=j; Y(i+1,j+1)=i;
    end
end

% Define food locations
foodLocs = [12,15];
foodLocsXY = [5,1;1,2];

nFoods = length(foodLocs);

% Initialise foods as not loaded
foodLoad = [0,0];

%Set rewards of performing actions
foodLoadReward = 10;
elseReward = -0.03;

nAgents = 2; % Counting HBA
nActions = 5;
nJointActions = nActions^nAgents;
nJA = nJointActions;
nStates = ((nLocs)^nAgents)*(2^nFoods);

GridworldOn = 0; % Variable to draw the game
setStatesWithRewards; % Set rewards to states and joint action
adjacencyMatrixFiller; % Matrix mapping states and actions

type2aux = 0;

%%




