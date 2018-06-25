function [HBA, Agent1, food] = getLocsFunction (SBG_s)

global rows cols;

if  SBG_s<=784
    y = 0; food = [0,0];
elseif SBG_s>784 && SBG_s<=1568
    y = ((rows*cols)^2); food = [1,0];
elseif SBG_s>1568 && SBG_s<= 2352
    y = ((rows*cols)^2)*2; food = [0,1];
elseif SBG_s>2352
    y = ((rows*cols)^2)*3; food = [1,1];
end

% Variable to hold the state of the game (without) foods, to determine
% the agents' locations
x = SBG_s-y;

HBA = floor((x-1)/(rows*cols));
Agent1 = mod((x-1),rows*cols);

end