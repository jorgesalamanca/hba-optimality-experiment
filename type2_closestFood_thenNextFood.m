% Type 1: Go to the closest food, load, go to the other one

function piType2 = type2_closestFood_thenNextFood(stateOfGame)

global cols foodLocsXY nActions type2aux;

piType2 = ones(1,nActions);
piType2 = piType2*0.0025;

[HBA, Agent1, food] = getLocsFunction (stateOfGame);

% Get X and Y positions of HBA and Agent1
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

if type2aux == 0
    if distFood1Ag1 <= distFood2Ag1
        if distFood1Ag1 == 1
            piType2(5) = 0.99;
            type2aux = 2;
            return;
        end
        if distFood1y >= distFood1x
            x = Agent1y - foodLocsXY(1,2);
            if x<0 y = 1; else y = 3; end            
            piType2(y) = 0.99;
            return;
        else
            x = Agent1x - foodLocsXY(1,1);
            if x<0 y = 4; else y = 2; end
            piType2(y) = 0.99;
            return;            
        end        
    else
        if distFood2Ag1 == 1
            piType2(5) = 0.99;
            type2aux = 1;
            return;
        end
        if distFood2y >= distFood2x
            x = Agent1y - foodLocsXY(2,2);
            if x<0 y = 1; else y = 3; end            
            piType2(y) = 0.99;
            return;
        else
            x = Agent1x - foodLocsXY(2,1);
            if x<0 y = 4; else y = 2; end
            piType2(y) = 0.99;
            return;            
        end        
    end
end

if type2aux == 1
    if Agent1 ~= 14    
        if distFood1Ag1 == 1
            piType2(5) = 0.99;
            type2aux = 2;
            return;
        end
        if distFood1y >= distFood1x
            x = Agent1y - foodLocsXY(1,2);
            if x<0 y = 1; else y = 3; end            
            piType2(y) = 0.99;
            return;
        else
            x = Agent1x - foodLocsXY(1,1);
            if x<0 y = 4; else y = 2; end
            piType2(y) = 0.99;
            return;            
        end
    else
        piType2(3) = 0.99;
    end    
end

if type2aux == 2
    if Agent1 ~=13
        if distFood2Ag1 == 1
            piType2(5) = 0.99;
            type2aux = 1;
            return;
        end
        if distFood2y >= distFood2x
            x = Agent1y - foodLocsXY(2,2);
            if x<0 y = 1; else y = 3; end            
            piType2(y) = 0.99;
            return;
        else
            x = Agent1x - foodLocsXY(2,1);
            if x<0 y = 4; else y = 2; end
            piType2(y) = 0.99;
            return;            
        end
    else
        piType2(1) = 0.99;
    end   
end
    
end


