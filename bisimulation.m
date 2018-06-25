% Code to compute the bisimulation between 2 processes
% Returns sequence of equivalence classes visited for reference
function [eqClassX,eqClassY, bisim] = bisimulation(SBGstX,SBGstY,eqClass)

bisim = 1; % Value will change diff. transition is found
n = length(SBGstX);
m = length(SBGstY);
nm = max([n,m]);
eqClassX = zeros(nm,1);
eqClassY = zeros(nm,1);

% If processes are of a different size (terminate in a diferent amount of
% time, return 0
if n~=m
    for i=1:n
        eqClassX(i) = eqClass(SBGstX(i,1),2);
    end
    for i=1:m
        eqClassY(i) = eqClass(SBGstY(i,1),2);
    end    
    bisim = 0;
    return;
end

for i=1:n
    eqClassX(i) = eqClass(SBGstX(i,1),2);
    eqClassY(i) = eqClass(SBGstY(i,1),2);
end

% If a different transition is found, return 0.
for i=1:n
    if eqClassX(i) ~= eqClassY(i)
        bisim = 0;
    end
end

end
    
    
    