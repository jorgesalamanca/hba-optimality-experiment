% Get the state of the game given the agents' locs and food states
% To simplify, currently works only with 2 agents, 2 foods

function s1 = getSBGstate(HBAloc, Agent1loc, foodLoad)

global nLocs;

if foodLoad(1) == 0 && foodLoad(2) == 0
   y = 0;
end    
if foodLoad(1) == 1 && foodLoad(2) == 0
   y = ((nLocs)^2);
end
if foodLoad(1) == 0 && foodLoad(2) == 1
   y = ((nLocs)^2)*2;
end         
if foodLoad(1) == 1 && foodLoad(2) == 1
   y = ((nLocs)^2)*3;
end

s1 = y + (HBAloc)*(nLocs) + Agent1loc + 1;
