% Change the state of the SBG given current game state and agents' action

function [s1] = transition(s0, actHBA, actAgent1, u)

global cols nLocs nFoods foodLocs foodLoadReward;

% Determine variables of the game based on the state passed
foodLoad_aux = [0,0];

% Depending on the state of the game, which foods are loaded?
if  s0<=784
    foodLoad_aux = [0,0]; y = 0;
elseif s0>784 && s0<=1568
    foodLoad_aux = [1,0]; y = ((nLocs)^2);
elseif s0>1568 && s0<= 2352
    foodLoad_aux = [0,1]; y = ((nLocs)^2)*2;
elseif s0>2352
    foodLoad_aux = [1,1]; y = ((nLocs)^2)*3;
end

% Variable to hold the state of the game (without) foods, to determine
% the agents' locations
x = s0-y;

HBAcurrentLoc = floor((x-1)/(nLocs));
Agent1currentLoc = mod((x-1),nLocs);

% If both agents are next to an unloaded food, and both of them load
if (actHBA == 5 && actAgent1 == 5 && u(s0,25) == foodLoadReward)
    
    for i=1:nFoods % Check which food is it, and load it
        if (HBAcurrentLoc+1 == foodLocs(i) || ...
            HBAcurrentLoc-1 == foodLocs(i) || ...
            HBAcurrentLoc+cols == foodLocs(i) || ...
            HBAcurrentLoc-cols == foodLocs(i) )                
        foodLoad_aux(i) = 1;
        end
    end
        
else
    
    % Update locations and compute next state
    HBApastLoc = HBAcurrentLoc;
    HBAcurrentLoc = changeLoc(HBAcurrentLoc,actHBA);
    
    % If HBA tries to move to where Agent1 is, stay in his old location
    if HBAcurrentLoc == Agent1currentLoc
        HBAcurrentLoc = HBApastLoc;
    end
    
    Agent1pastLoc = Agent1currentLoc;
    Agent1currentLoc = changeLoc(Agent1currentLoc,actAgent1);
    
    % If Agent1 tries to access the HBA location, stays in his old location
    if Agent1currentLoc == HBAcurrentLoc
        Agent1currentLoc = Agent1pastLoc;
    end
            
end

s1 = getSBGstate(HBAcurrentLoc, Agent1currentLoc, foodLoad_aux);



