startHBA = [25,26,27,20,13,19];
startAg1 = [14,7,0,1,2,8];
initEqClArr = 0; 

for HH = 1:length(startHBA)
    for AA = 1:length(startAg1)    
        initialHBALoc = startHBA(HH);
        initialAgent1Loc = startAg1(AA);
        playHBA;
        if initEqClArr == 0
            initEqClArr = initialEqClass;
        else
            initEqClArr(end+1) = initialEqClass;
        end
        HBAstArrX(:,1)==HBAstArrY(:,1)
        [eqClX,eqClY]
        if bisimilar ~= 1
            initialHBALoc
            initialAgent1Loc
            fprintf('Que pedo!!??');
            pause;
        end
        pause;
    end
end