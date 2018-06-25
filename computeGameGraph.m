% Compute graph to furtherly determine the equivalence classes of the game

% Form array with the edges of the graph of the game (25*3136=78400 rows)
edgesArray = zeros(nStates*(nActions^nAgents),2);
for i = 1 : nStates
   for j = 1: nJointActions
       edgesArray(((i-1)*nJointActions+j),:) = [i, Adj(i,j)];
   end
end

[Dec,Ord]=grDecOrd(edgesArray); % Compute strongly connected components
notAccesibleStates; % Computes "notStates", array with non-accesible states
scc = Dec; % Store previous matrix with scc

% Remove not accesible states from scc
for j = 1 : length(notStates)
    x = notStates(j);
    scc(x,:) = 0;
end

% Remove columns without values (corresponding to the not accesible states
% of the game)
scc = scc(:,any(scc,1)); 
