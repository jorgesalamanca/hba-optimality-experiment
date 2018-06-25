% Execute game with HBA controller. 
% Run startup and reinforcementLearning.m first!

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% INITIAL STATE OF THE GAME %

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Uncomment the following lines and comment the last 2 of this part to
% randomise an initial location

% initialHBALoc = randi(rows*cols)-1;
% for i=1:nFoods
%     if initialHBALoc == foodLocs(1) || initialHBALoc == foodLocs(2)
%         initialHBALoc = randi(rows*cols)-1;
%         i=1;
%     end
% end
% 
% initialAgent1Loc = randi(rows*cols)-1;
% for i=1:nFoods
%     if initialAgent1Loc == foodLocs(1) || ...
%             initialAgent1Loc == foodLocs(2) || initialAgent1Loc == initialHBALoc
%         initialAgent1Loc = randi(rows*cols)-1;
%         i=1;
%     end
% end

initialHBALoc = 27;
initialAgent1Loc = 0;

%%
for nProcess=1:2
if nProcess == 1
    Process = 'X';
else
    Process = 'Y';
end

Agent1pastLoc = initialAgent1Loc;
Agent1pastLoc2 = initialAgent1Loc;
foodLoad = [0,0];

SBG_s = getSBGstate(initialHBALoc, initialAgent1Loc, foodLoad);
initialSBG_s = SBG_s;
updateGridworld;

type2aux = 0; % Variable set to 1 when type 2 makes first contact

%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% SELECT PROCESS / TYPE SPACE %

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% How many types are in the user-defined type space?
switch Process
    case 'X'
        nTypes = 1;
    case 'Y'
        nTypes = 4;
        PrMatrix = zeros(nTypes,1);
end
      
% Likelihood aux. vector to furtherly compute posterior distribution
L1 = zeros(nTypes,1);

% Uniform prior distribution for the user-defined type space
Pr1 = ones(nTypes,1);
Pr1 = Pr1/nTypes;

% Declare a vector to store the expected payoffs of actions
E = zeros(1,5);

%%

%%%%%%%%%%%%%%%%%%

% START THE GAME %

%%%%%%%%%%%%%%%%%%

fprintf('Ready to run process %s. Press any key to continue\n',Process);
pause;

% Start time variable
t = 0;
discGamma = 0.95;
HBAstatesArray = [0,0];
SBGstatesArray = [0,0];
pastActAgent1 = 0;

while SBG_s < 2353 % 2353 to 3136 are the end states of the game
 
    t = t + 1;
    
    %%%%%%%%%%%%%%%%%%%%% UPDATE POSTERIOR %%%%%%%%%%%%%%%%%%%%%
    
    if t ~= 1
        % Calculate type likelihood values
        for i=1:nTypes
            L1(i) = UDTS1(i,actAgent1)*Pr1(i);
        end
        % Normalise and store posterior values
        for i=1:nTypes
            Pr1(i) = L1(i)/sum(L1);
        end    
    end

    % Prepare matrix to store action probabilities of types
    UDTS1 = zeros(nTypes,5);

    
%%   
    %%%%%%%%%%% GET ACTION PROBABILITIES FROM TYPES %%%%%%%%%%%%

    getLocs; % Updates currentHBALoc, currentAgent1Loc and foodLoad
        
    piType1 = type1_closestFood(SBG_s);
    piType2 = type2_closestFood_thenNextFood(SBG_s);
    piType3 = type3_goToHBA(SBG_s);
    piType4 = type4_goToHBAorFood(SBG_s);

    if t==1        
        piType5 = [1/5,1/5,1/5,1/5,1/5];
        piType6 = [1/5,1/5,1/5,1/5,1/5];
        piType7 = [1/5,1/5,1/5,1/5,1/5];
        piType8 = [1/5,1/5,1/5,1/5,1/5];
    else
        piType5 = type5(actHBA);
        piType6 = type6(actHBA);
        piType7 = type7(SBG_s,actAgent1);
        piType8 = type8(actAgent1);
    end

    %%%%%%%%%%% USER DEFINED TYPE SPACES %%%%%%%%%%%%
    
    % Process X    
    if Process == 'X'    
       UDTS1(1,:) = piType4; 
%        UDTS1(2,:) = piType5; 
%        UDTS1(3,:) = piType4; 
%        UDTS1(4,:) = piType8;     
    end
    
    % Process Y    
    if Process == 'Y';        
       UDTS1(1,:) = piType1; 
       UDTS1(2,:) = piType3; 
       UDTS1(3,:) = piType6; 
       UDTS1(4,:) = piType7; 
%       UDTS1(5,:) = piType7; 
    end
    
    
%%  
    
    if t~=1 pastActAgent1 = actAgent1; end
    [val,actAgent1] = max(piType4);

    %%%%%%%%%%%%%%%%%%%%%% COMPUTE HBA %%%%%%%%%%%%%%%%%%%%%%%%%    
        
    E = zeros(1,5); % Vector to hold action expected payoffs

    for ai = 1:5 % For every action of HBA        
        for typej = 1 : nTypes % For each type in the user def. type space       

            Qs_sum = 0;

            for aj = 1: 5 % For every action of agent 1

                jointActSim = (ai-1)*5 + aj;
                nextStateSim = Adj(SBG_s,jointActSim);

                Qs_jointAct = u(SBG_s,jointActSim) + ...
                                    discGamma*max(Q(nextStateSim,:));

                % Multiply by player j's strategy
                Qs_jointAct = Qs_jointAct*UDTS1(typej,aj);
                Qs_sum = Qs_jointAct + Qs_sum;

            end        
            E(ai) = E(ai) + Pr1(typej)*Qs_sum;
        end    
    end

%%

    % Get HBA's action
    [maxExpPayOff,actHBA] = max(E);
    
    SBG_jointAction = (actHBA-1)*5 + actAgent1;
    
    if  SBG_s<=784
        storeAux = 0;
    elseif SBG_s>784 && SBG_s<=1568
        storeAux = nLocs;
    elseif SBG_s>1568 && SBG_s<= 2352
        storeAux = nLocs*2;
    elseif SBG_s>2352
        storeAux = nLocs*3;
    end
    
    % Store states and edges (actions) in array
    if t==1
        SBGstatesArray(1,:) = [SBG_s,SBG_jointAction];
        HBAstatesArray(1,:) = [currentHBALoc+storeAux,actHBA];
    else
        SBGstatesArray(end+1,:) = [SBG_s,SBG_jointAction];
        HBAstatesArray(end+1,:) = [currentHBALoc+storeAux,actHBA];
    end
    
    % Transition the game via the adjacency matrix
    SBG_s = Adj(SBG_s,SBG_jointAction);
    [[1:nTypes]',Pr1]
    E
    t

    if Process == 'X'
        if t==1
            EmatrixX = E; 
        else
            EmatrixX(end+1,:) = E;
        end
    end
    
    if Process == 'Y'
        if t==1
            PrMatrix = Pr1;
            EmatrixY = E; 
        else
            PrMatrix(:,end+1) = Pr1;
            EmatrixY(end+1,:) = E;
        end
    end
       
    actHBAt_1 = actHBA;
    Agent1pastLoc2 = Agent1pastLoc;
    Agent1pastLoc = currentAgent1Loc;
    updateGridworld;
    pause;
    
end

Process
t % Print amount of steps taken to solve the game

if Process == 'X'
    SBGstArrX = SBGstatesArray;
    HBAstArrX = HBAstatesArray;
end

if Process == 'Y'
    SBGstArrY = SBGstatesArray;
    HBAstArrY = HBAstatesArray;
end

end

[eqClX,eqClY,bisimilar] = bisimulation(SBGstArrX,SBGstArrY,eqClass)
bisimilar;
initialHBALoc;
initialAgent1Loc;
initialEqClass = eqClX(1);


