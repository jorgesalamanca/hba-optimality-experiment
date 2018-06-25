% Learn expected pay-offs in each state of the game via RL
fprintf('Running Q-learning...\n');

Q = 0.01*rand(nStates,25);
V = max(Q,[],2);
cs = zeros(nStates,5);
ns = zeros(nStates,1);

eta = 0.2;
gamma = 0.95;
epsilon = 0.01;

nTrials = 20000;

setStatesWithRewards;

stepArray = zeros(nTrials,1);
initialStateArray = zeros(nTrials,1);
%%
for trial=1:nTrials
%%       
    rlHBAinitialLoc = randi(rows*cols)-1;
    for i=1:3
        if rlHBAinitialLoc == foodLocs(1) || rlHBAinitialLoc == foodLocs(2)
            rlHBAinitialLoc = randi(rows*cols)-1;
            i=1;
        end
    end
    
    rlAgent1initialLoc = randi(rows*cols)-1;
    for i=1:3
        if rlAgent1initialLoc == foodLocs(1) || rlAgent1initialLoc == ...
                foodLocs(2) || rlAgent1initialLoc == rlHBAinitialLoc
            rlAgent1initialLoc = randi(rows*cols)-1;
            i=1;
        end
    end
    
    
    st0 = getSBGstate(rlHBAinitialLoc, rlAgent1initialLoc, [0,0]);
    st1 = st0; % Just for entering the while
%%    
    % Start the game    
    step = 0;
    initialStateArray(trial) = st0;
    
    while st1 < 2353
        
        step = step+1;
 
        ns(st0) = ns(st0) + 1;
        
        csAux = zeros(1,5); 
        for i=1:5
            for j=1:5
                csAux(i)= csAux(i)+(cs(st0,j)/ns(st0))*Q(st0,(i-1)*5+j);            
            end
        end
        
        % Obtain max utility action
        [val,ai] = max(csAux);
                       
        % Exploration
        if (rand(1)<epsilon) 
            ai = randi(5); 
        end;
        
        % Get Agent1 action
        rlType = type2_closestFood_thenNextFood(st0);
        [unused,aj] = max(rlType);
        
        cs(st0,aj) = cs(st0,aj)+1;

        % Get joint action
        jointAction = (ai-1)*5 + aj;        
        
        % Get next state from adjacency matrix
        st1 = Adj(st0,jointAction);
        
        % Get reward from utility matrix
        r = u(st0,jointAction);
                      
        % Learning step
        Vst1Aux = zeros(1,5); 
        for i=1:5
            for j=1:5
                Vst1Aux(i)= Vst1Aux(i)+(cs(st1,j)/ns(st1))*Q(st1,(i-1)*5+j);            
            end
        end
        
        V(st1) = max(Vst1Aux);
        if V(st1) == 0 || isnan(V(st1))
            V(st1) = max(Q(st1,:)); 
        end
        
%        [currentHBALoc,currentAgent1Loc,foodLoad] = getLocsFunction(st0);
%        updateGridworld;
%        pause(0.1);
        
        Q(st0,jointAction)=(1-eta)*Q(st0,jointAction)+eta*(r+gamma*V(st1));       
        st0 = st1;
                
    end
%%    
    stepArray(trial) = step;
    
    % Define a decay for parameters epsilon and eta
%     eta = 0.2*0.999975^trial;
%     epsilon = 0.025*0.999975^trial;
    
    % Never allow epsilon to be lower than 0.01
    if epsilon < 0.01
        epsilon = 0.01;
    end
    
    
    
    % Tells us in which trial the algorithm is
    if mod(trial,1000) == 0
        trial
    end
    
end

figure;
plot(stepArray);
