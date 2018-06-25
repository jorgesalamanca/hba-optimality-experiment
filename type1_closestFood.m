% Type 1: Go to the closest unloaded food betw agents and try to load it.

function piType1 = type1_closestFood(stateOfGame)

global cols foodLocsXY nActions;

piType1 = ones(1,nActions);
piType1 = piType1*0.0025;

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
distFood1HBA = sqrt((HBAx - foodLocsXY(1,1))^2 + (HBAy - foodLocsXY(1,2))^2);
distFood1 = distFood1Ag1 + distFood1HBA;

distFood2x = abs(Agent1x - foodLocsXY(2,1));
distFood2y = abs(Agent1y - foodLocsXY(2,2));
distFood2Ag1 = sqrt(distFood2x^2 + distFood2y^2);
distFood2HBA = sqrt((HBAx - foodLocsXY(2,1))^2 + (HBAy - foodLocsXY(2,2))^2);
distFood2 = distFood2Ag1 + distFood2HBA;

if food(1) == 0 && food(2) == 0
    if distFood1 <= distFood2
        if distFood1Ag1 == 1
            piType1(5) = 0.99;
            return;
        end
        if distFood1y >= distFood1x
            x = Agent1y - foodLocsXY(1,2);
            if x<0 y = 1; else y = 3; end            
            piType1(y) = 0.99;
            return;
        else
            x = Agent1x - foodLocsXY(1,1);
            if x<0 y = 4; else y = 2; end
            piType1(y) = 0.99;
            return;            
        end        
    else
        if distFood2Ag1 == 1
            piType1(5) = 0.99;
            return;
        end
        if distFood2y >= distFood2x
            x = Agent1y - foodLocsXY(2,2);
            if x<0 y = 1; else y = 3; end            
            piType1(y) = 0.99;
            return;
        else
            x = Agent1x - foodLocsXY(2,1);
            if x<0 y = 4; else y = 2; end
            piType1(y) = 0.99;
            return;            
        end        
    end
    
elseif food(1) == 1 && food(2) == 0
    if Agent1 ~= 13
        if distFood2Ag1 == 1
            piType1(5) = 0.99;
            return;
        end
        if distFood2y >= distFood2x
            x = Agent1y - foodLocsXY(2,2);
            if x<0 y = 1; else y = 3; end            
            piType1(y) = 0.99;
            return;
        else
            x = Agent1x - foodLocsXY(2,1);
            if x<0 y = 4; else y = 2; end
            piType1(y) = 0.99;
            return;            
        end
    else
        piType1(1) = 0.99;
    end
        
elseif food(1) == 0 && food(2) == 1
    if Agent1 ~=14
        if distFood1Ag1 == 1
            piType1(5) = 0.99;
            return;
        end
        if distFood1y >= distFood1x
            x = Agent1y - foodLocsXY(1,2);
            if x<0 y = 1; else y = 3; end            
            piType1(y) = 0.99;
            return;
        else
            x = Agent1x - foodLocsXY(1,1);
            if x<0 y = 4; else y = 2; end
            piType1(y) = 0.99;
            return;            
        end    
    else
        piType1(3) = 0.99;
    end
        
end

end


