% Type 4: Go to HBA or closest unloaded food

function piType4 = type4_goToHBAorFood(stateOfGame)

global cols foodLocsXY nActions;

piType4 = ones(1,nActions);
piType4 = piType4*0.0025;

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

if food(1) == 0 && food(2) == 0
    [dist,target] = min([distFood1Ag1, distFood2Ag1, distToHBA]);
elseif food(1) == 0
    [dist,target] = min([distFood1Ag1, 1000, distToHBA]);
elseif food(2) == 0
    [dist,target] = min([1000, distFood2Ag1, distToHBA]);
end

if target == 1 % Food 1
    if distFood1Ag1 == 1
        piType4(5) = 0.99;
        return;
    else
        if distFood1y >= distFood1x
            x = Agent1y - foodLocsXY(1,2);
            if x<0 y = 1; else y = 3; end            
            piType4(y) = 0.99;
            return;
        else
            x = Agent1x - foodLocsXY(1,1);
            if x<0 y = 4; else y = 2; end
            piType4(y) = 0.99;
            return;            
        end
    end
elseif target == 2 % Food 2
    if distFood2Ag1 == 1
        piType4(5) = 0.99;
        return;
    else    
        if distFood2y >= distFood2x
            x = Agent1y - foodLocsXY(2,2);
            if x<0 y = 1; else y = 3; end            
            piType4(y) = 0.99;
            return;
        else
            x = Agent1x - foodLocsXY(2,1);
            if x<0 y = 4; else y = 2; end
            piType4(y) = 0.99;
            return;            
        end
    end
elseif target == 3 % HBA
    if distToHBA == 1
        piType4(5) = 0.99;
        return;
    else
        if Agent1 ~= 14
            if distToHBAy >= distToHBAx
                x = Agent1y - HBAy;
                if x<0 y = 1; else y = 3; end            
                piType4(y) = 0.99;
                return;
            else
                x = Agent1x - HBAx;
                if x<0 y = 4; else y = 2; end            
                piType4(y) = 0.99;        
                return;
            end
        else
            piType4(3) = 0.99;
            return;
        end
    end
end

end        

