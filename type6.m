% Mirror

function piType6 = type6(pastHBAaction)

global nActions;

piType6 = ones(1,nActions);
piType6 = piType6*0.0025;

switch pastHBAaction
    case 1
        newAction = 3;
    case 2
        newAction = 4;
    case 3
        newAction = 1;
    case 4
        newAction = 2;
    case 5
        newAction = 5;
end

piType6(newAction) = 0.99;

end