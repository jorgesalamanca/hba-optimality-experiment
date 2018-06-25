% Copycat

function piType5 = type5(pastHBAaction)

global nActions;

piType5 = ones(1,nActions);
piType5 = piType5*0.0025;

piType5(pastHBAaction) = 0.99;

end