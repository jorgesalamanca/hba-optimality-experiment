% Repeat

function piType8 = type8(actAgent1)

global nActions;

piType8 = ones(1,nActions);
piType8 = piType8*0.0025;

piType8(actAgent1) = 0.99;

end