% Plot to have a visual representation of the state of the game
% NOTE: Works (in its current version) for 2 agents and 2 foods

% Create the plot of the Gridworld
if GridworldOn == 0
    figure (1);
    title('Gridworld');
    hold on;
    plot (X,Y,'k');
    plot (X',Y','k');
end

if GridworldOn == 1
 %   delete([hfood1,hfood2, hHBA, hAgent1]);
end

% Code to get agents' locations and update foods
getLocs


% Draw food 1
if foodLoad(1) == 0 % Check if food 1 is loaded, fill if it is
    f1 = 'w';
else if foodLoad(1) == 1
        f1 = 'r';
    end
end
foodLoc1_x = mod(foodLocs(1),cols) + 0.5;
foodLoc1_y = floor(foodLocs(1)/cols) + 0.5;

hfood1 = plot (foodLoc1_x, foodLoc1_y, '-rs','LineWidth',8,...
                       'MarkerEdgeColor','r',...
                       'MarkerFaceColor',f1 ,...
                       'MarkerSize',39);
% Draw food 2
if foodLoad(2) == 0 % Check if food 2 is loaded, fill if it is
    f2 = 'w';
else if foodLoad(2) == 1
        f2 = 'r';
    end
end
foodLoc2_x = mod(foodLocs(2),cols) + 0.5;
foodLoc2_y = floor(foodLocs(2)/cols) + 0.5;

hfood2 = plot (foodLoc2_x, foodLoc2_y, '-rs','LineWidth',8,...
                       'MarkerEdgeColor','r',...
                       'MarkerFaceColor',f2 ,...
                       'MarkerSize',39);
                   
% Draw HBA
HBA_x = mod(currentHBALoc,cols) + 0.5;
HBA_y = floor(currentHBALoc/cols) + 0.5;

hHBA = plot (HBA_x, HBA_y, '-bp','LineWidth',2,...
                       'MarkerEdgeColor','g',...
                       'MarkerFaceColor','g',...
                       'MarkerSize',42);
                   
% Draw Agent1
Agent1_x = mod(currentAgent1Loc,cols) + 0.5;
Agent1_y = floor(currentAgent1Loc/cols) + 0.5;

hAgent1 = plot (Agent1_x, Agent1_y, '-bo','LineWidth',2,...
                       'MarkerEdgeColor','b',...
                       'MarkerFaceColor','b',...
                       'MarkerSize',33);
                   
GridworldOn = 1;
                   
axis equal tight;