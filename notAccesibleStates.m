% Code to compute array when an agent is on a food
notStates = 1;
y = 0;

for i=1:nStates

    if  i<=784
        y = 0;
    elseif i>784 && i<=1568
        y = ((rows*cols)^2);
    elseif i>1568 && i<= 2352
        y = ((rows*cols)^2)*2;
    elseif i>2352
        y = ((rows*cols)^2)*3;
    end

    x = i-y;

    notStatesHBAloc = floor((x-1)/(rows*cols));
    notStatesAgent1loc = mod((x-1),rows*cols);
    notStatesAux = 0;
    
    for f=1:nFoods
        if notStatesAux == 0        
            if notStatesHBAloc == foodLocs(f) || ...
                                    notStatesAgent1loc == foodLocs(f)
                if notStates == 0
                    notStates = i;
                    notStatesAux = 1;
                else
                    notStates(end+1) = i;
                    notStatesAux = 1;
                end
            end        
        end
    end
    
    % If we don't allow agents to be in the same location
    if length(notStates) ~= 1
        if notStatesHBAloc == notStatesAgent1loc
            notStates(end+1) = i;
        end
    end
    
end

