% Code used to fill in the adjacency matrix (matrix that maps transitions)

Adj = zeros(nStates, nJointActions);
fprintf('Computing adjacency matrix...\n');

for s = 1: nStates % For every state
    for i=1:nActions % For every action of HBA
        for j=1:nActions % For every action of Agent1            

            [tempHBAloc,tempAg1loc,tempFood] = getLocsFunction(s);
            
            newHBAloc = changeLoc(tempHBAloc,i);
            if newHBAloc == tempAg1loc || newHBAloc == foodLocs(1)...
                    || newHBAloc == foodLocs(2)
                newHBAloc = tempHBAloc;                
            end
            
            newAg1loc = changeLoc(tempAg1loc,j);
            if newAg1loc == newHBAloc || newAg1loc == foodLocs(1)...
                    || newAg1loc == foodLocs(2)
                newAg1loc = tempAg1loc;                
            end
                     
            if i*j == nJA && u(s,nJA) == foodLoadReward
                for f=1:nFoods
                   if newHBAloc + cols == foodLocs(f) || ...
                           newHBAloc - cols == foodLocs(f) || ...
                           newHBAloc + 1 == foodLocs(f) || ...
                           newHBAloc - 1 == foodLocs(f)
                       tempFood(f) = 1;
                   end
                end
            end
            
            newState = getSBGstate(newHBAloc,newAg1loc,tempFood);
            Adj(s,(i-1)*nActions+j) = newState;
        end
    end
end

