% Type 3: Try to get next to HBA

function piType3 = type3_goToHBA(stateOfGame)

global cols foodLocsXY nActions;

piType3 = ones(1,nActions);
piType3 = piType3*0.0025;

[HBA, Agent1, food] = getLocsFunction (stateOfGame);

% Get X and Y positions of HBA and Agent1
if HBA >= cols
    HBAx = mod(HBA,cols);
    HBAy = floor(HBA/cols);
else
    HBAx = mod(HBA,cols);
    HBAy = 0;
end

if Agent1 >= cols
    Agent1x = mod(Agent1,cols);
    Agent1y = floor(Agent1/cols);
else
    Agent1x = mod(Agent1,cols);
    Agent1y = 0;
end

% Compute euclidean distances and sum
distFood1x = abs(Agent1x - foodLocsXY(1,1));
distFood1y = abs(Agent1y - foodLocsXY(1,2));
distFood1Ag1 = sqrt(distFood1x^2 + distFood1y^2);

distFood2x = abs(Agent1x - foodLocsXY(2,1));
distFood2y = abs(Agent1y - foodLocsXY(2,2));
distFood2Ag1 = sqrt(distFood2x^2 + distFood2y^2);

distToHBAx = abs(Agent1x - HBAx);
distToHBAy = abs(Agent1y - HBAy);
distToHBA = sqrt(distToHBAx^2 + distToHBAy^2);

if (distFood1Ag1 == 1 && food(1) == 0) || (distFood2Ag1 == 1 && food(2) == 0)
    piType3(5) = 0.99;
    return;
else
if distToHBA == 1

    piType3(5) = 0.99;
    return;
else
    if distToHBAy >= distToHBAx
        x = Agent1y - HBAy;
        if x<0 y = 1; else y = 3; end            
        piType3(y) = 0.99;
        return;
    else
        x = Agent1x - HBAx;
        if x<0 y = 4; else y = 2; end            
        piType3(y) = 0.99;        
        return;
    end
end
end
        
end
