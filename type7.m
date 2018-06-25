% Run east or west

function piType7 = type7(stateOfGame,actAgent1)

global cols nActions;

piType7 = ones(1,nActions);
piType7 = piType7*0.0025;

[HBA, CAL, food] = getLocsFunction (stateOfGame);

if actAgent1 == 5
    w = mod(CAL,cols);
    if w<floor(cols/2)
        piType7(4) = 0.99;
    elseif w>floor(cols/2)
        piType7(2) = 0.99;
    end                                
else
    if CAL==5||CAL==8||CAL==11||CAL==13||CAL==14||CAL==16||CAL==19||CAL==22
        piType7(5) = 0.99;
    else
    y = 1 + mod(actAgent1,4);
    piType7(y) = 0.99;          
    end
end

end