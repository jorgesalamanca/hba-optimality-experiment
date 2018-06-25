% Code to get quickly agents' locations based on SBG_s (state of the game)

% Depending on the state of the game, which foods are loaded?
if  SBG_s<=784
    y = 0; foodLoad = [0,0];
elseif SBG_s>784 && SBG_s<=1568
    y = ((nLocs)^2); foodLoad = [1,0];
elseif SBG_s>1568 && SBG_s<= 2352
    y = ((nLocs)^2)*2; foodLoad = [0,1];
elseif SBG_s>2352
    y = ((nLocs)^2)*3; foodLoad = [1,1];
end

% Variable to hold the state of the game (without) foods, to determine
% the agents' locations
x = SBG_s-y;

currentHBALoc = floor((x-1)/(nLocs));
currentAgent1Loc = mod((x-1),nLocs);