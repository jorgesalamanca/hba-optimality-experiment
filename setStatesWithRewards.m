% Code used to determine and set the rewards of the states that involve 
% loading food. Currently, works only with 2 foods, 2 agents.

u = ones(nStates,nActions^nAgents);
u = u*elseReward; % Set rewards for other moves

for counter = 0:(2^nFoods)-2
    m = 0;
    
    for n=1:nFoods
        
        % When at least one food has already been loaded, prevent
        % assigning rewards for loading it again
        if counter == 1 && n == 1
            m = 0;
        end
        if counter == 1 && n == 2
            m = counter;
        end
        if counter == 2 && n == 1
            m = counter;
        end
        if counter == 2 && n == 2
            m = 0;
        end
        
        % HBA below
        for i=1:2 % Up and down spaces of the food
            for j=-1:2:1 % Left and right spaces of the food
                if i == 1
                    s_with_reward = (m*(rows*cols)^nAgents) + ...
                    (foodLocs(n)-cols)*(rows*cols)+foodLocs(n)-(cols*j)+1;
                else
                    s_with_reward = (m*(rows*cols)^nAgents) + ...
                    (foodLocs(n)-cols)*(rows*cols)+foodLocs(n)-(1*j)+1;
                end
                u(s_with_reward,25) = foodLoadReward;
            end
        end
        
        % HBA above
        for i=1:2 % Up and down spaces of the food
            for j=-1:2:1 % Left and right spaces of the food
                if i == 1
                    s_with_reward = (m*(rows*cols)^nAgents) + ...
                    (foodLocs(n)+cols)*(rows*cols)+foodLocs(n)-(cols*j)+1;
                else
                    s_with_reward = (m*(rows*cols)^nAgents) + ...
                    (foodLocs(n)+cols)*(rows*cols)+foodLocs(n)-(1*j)+1;
                end
                u(s_with_reward,25) = foodLoadReward;
            end
        end
        
        % HBA left
        for i=1:2 % Up and down spaces of the food
            for j=-1:2:1 % Left and right spaces of the food
                if i == 1
                    s_with_reward = (m*(rows*cols)^nAgents) + ...
                    (foodLocs(n)-1)*(rows*cols)+foodLocs(n)-(cols*j)+1;
                else
                    s_with_reward = (m*(rows*cols)^nAgents) + ...
                    (foodLocs(n)-1)*(rows*cols)+foodLocs(n)-(1*j)+1;
                end
                u(s_with_reward,25) = foodLoadReward;
            end
        end
        
        % HBA right
        for i=1:2 % Up and down spaces of the food
            for j=-1:2:1 % Left and right spaces of the food
                if i == 1
                    s_with_reward = (m*(rows*cols)^nAgents) + ...
                    (foodLocs(n)+1)*(rows*cols)+foodLocs(n)-(cols*j)+1;
                else
                    s_with_reward = (m*(rows*cols)^nAgents) + ...
                    (foodLocs(n)+1)*(rows*cols)+foodLocs(n)-(1*j)+1;
                end
                u(s_with_reward,25) = foodLoadReward;
            end
        end        
    end
end

