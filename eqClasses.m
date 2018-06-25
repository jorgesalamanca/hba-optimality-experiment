% Code to compute the equivalence classes of a game run (graph form)
% Following the procedure of Dovier et. al. (2004)
% Works for two foods, two agents

% Compute the graph of the game (array containing the transitions as edges)
% as well as its strongly connected components
computeGameGraph;

% Once the strongly connected components of the game are known, relate each
% state to a component
nodeRank = zeros(nStates,2);
nodeRank(:,1) = [1:nStates]';
eqClass = nodeRank; % Same initialisation
n_scc = size(scc,2);

% Analysing the design and the scc array, we can determine the 
% corresponding rank of each scc column. Also, initialise the eq. classes
% array, with 0 for end states and high numbers (nStates) for other ranks.
for i=1:nStates
    for j=1:n_scc
        if any(scc(i,:),2) ~= 0
            if scc(i,j) == 1
                switch j
                    case 1
                        nodeRank(i,2) = 2;
                        eqClass(i,2) = nStates;
                    case 2
                        nodeRank(i,2) = 1;
                        eqClass(i,2) = nStates-1;
                    case 3
                        nodeRank(i,2) = 1;
                        eqClass(i,2) = nStates-1;
                    case 4
                        nodeRank(i,2) = 0;
                        eqClass(i,2) = 0;
                end
            end
        else
            % Not accesible state
            nodeRank(i,2) = -1;
            eqClass(i,2) = -1;
        end
    end
end

%% 
% Process rank 0 (end states)

% Colapse rank 0 (end states of the game)
endStateInd = nJA*((nLocs^nAgents*2^nFoods)-(nLocs^nAgents))+1;
firstEndSt = edgesArray(endStateInd,1); % First end state in the array

% Refine rank 1 (step 7c on Dovier et. al. (2004))
Bi = eqClass(nLocs^2+1:firstEndSt-1,:);

for i=(nLocs^2+1):(endStateInd/25)
    for j=1:nJA
        if edgesArray((i-1)*nJA+j,2)>=firstEndSt
            if nodeRank(i,2) ~= -1                
                Bi(i-(nLocs^2),2) = 1;
            end
        end
    end
end

Bi = sortrows(Bi,2);

%%
% Apply algorithm for ranks 1 and 2

for rank=1:2
    
    if rank == 1
        
        offset = (nLocs^2)*nJA;
        auxEdges = edgesArray(offset+1:endStateInd-1,:);
        
    elseif rank == 2
        
        auxEdges = edgesArray(1:(nLocs^2)*nJA,:);        
        Bi = eqClass(1:nLocs^2,:);
        
        % Refine rank 2 (step 7c on Dovier et. al. (2004))
        for i=1:nLocs^2
            for j=1:nJA
                if auxEdges((i-1)*nJA+j,2)>=nLocs^2
                    if nodeRank(i,2) ~= -1                
                        Bi(i,2) = nXi;
                    end
                end
            end
        end
        
        offset = 0;
        Bi = sortrows(Bi,2);
        nXi = nXi + 1;
        
    end
    
    % Remove edges of not accesible nodes
    nNotAccsNodes = sum(histc(Bi(:,2),-1,2));
    for r=1:nNotAccsNodes
        remNode = Bi(r,1);
        auxEdgeInd = (remNode*nJA)-offset-nJA+1;
        auxEdges(auxEdgeInd:auxEdgeInd-1+nJA,2)=0;
    end   
    
    if rank == 1 % Initialise number of blocks in rank i
        nXi = length(unique(Bi(:,2)))-1; % Minus the not accesible rank
    end
    
    nClassifiedNodes = 0;
    
    for i=1:length(Bi)
        if Bi(i,2)<nXi
            nClassifiedNodes=nClassifiedNodes+1;
        end
    end
    
    j = nXi-1;
    nNodesPastX = sum(histc(Bi(:,2),j,2));

    %%
    % While a refinement is still possible (Paige-Tarjan 1986)    
    while j ~= nXi 

        newX = 0; % Flag to check if a new block was found              
        totalNewNodes = 0; % Array to hold states leading to past block
        newNodesInNewBlock = 0; % Auxiliar array to past line
        
        % Remove edges of current block X
        for r=1:nNodesPastX
            remNode = Bi(r+nClassifiedNodes-nNodesPastX,1);
            auxEdgeInd = (remNode*nJA)-offset-nJA+1;
            auxEdges(auxEdgeInd:auxEdgeInd-1+nJA ,2)=0;
        end        
                
        for k=1:nNodesPastX % Check which edges lead to the last block
            
            % Search for an edge leading to current node
            currentN = Bi(k+nClassifiedNodes-nNodesPastX,1);             
            auxNewNodesInd = find(histc(auxEdges(:,2),currentN,2));
            
            for edg=1:length(auxNewNodesInd)
                newNode = auxEdges(auxNewNodesInd(edg),1);
                if edg == 1
                    newNodesInNewBlock = newNode;
                else
                    newNodesInNewBlock(end+1) = newNode;
                end
            end
            
            
            if isempty(auxNewNodesInd) == 0 % If at least one edge exists
                if newX == 0
                    nXi = nXi+1;
                    newX = 1; % Check the flag and update nXi
                end
                % Add indices to the future iteration
                if totalNewNodes == 0
                    totalNewNodes = newNodesInNewBlock;
                else
                    totalNewNodes = [totalNewNodes,newNodesInNewBlock];
                end                              
            end 
        end
                
        % Update indices (eq. classes) in current block       
        if isempty(totalNewNodes) == 0
            totalNewNodes = unique(totalNewNodes);
            for ind=1:length(totalNewNodes)
                aux1 = totalNewNodes(ind);
                aux2 = find(histc(Bi(:,1),aux1,2));
                Bi(aux2,2)=nXi-1;
            end
            Bi = sortrows(Bi,2);           
        end
        
        nNodesPastX = length(totalNewNodes);
        nClassifiedNodes = nClassifiedNodes + nNodesPastX;
        j=j+1;
        
    end
    
    % Update equivalence classes
    if rank == 1
        eqClass((nLocs^2)+1:firstEndSt-1,:) = sortrows(Bi,1);
    elseif rank == 2
        eqClass(1:(nLocs^2),:) = sortrows(Bi,1);
    end
        
end




