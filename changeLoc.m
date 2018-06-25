% Function to compute the next location given an agent's previos
% state and action taken

function loc1 = changeLoc(loc0, action)

global foodLocs rows cols nFoods;

% NORTH
if action == 1
    if loc0 < cols*(rows-1)
        loc1 = loc0+cols;
    else
        loc1 = loc0;
    end
end

% WEST
if action == 2
    if mod(loc0,cols) ~= 0
        loc1 = loc0-1;
    else
        loc1 = loc0;
    end
end

% SOUTH
if action == 3
    if loc0 >= cols
        loc1 = loc0-cols;
    else
        loc1 = loc0;
    end
end

% EAST
if action == 4
    if mod(loc0,cols) ~= cols-1
        loc1 = loc0+1;
    else
        loc1 = loc0;
    end
end


% LOAD FOOD
if action == 5
    loc1 = loc0;
end


% If agent tries to move into a food space
for i = 1 : nFoods
    if loc1 == foodLocs(i)
        loc1 = loc0;
    end
end
