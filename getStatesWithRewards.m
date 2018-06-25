% Code to check which states have rewards and store them in an array

x_indx = 0;
statesWithRewardsArray = zeros(64,1);
for i = 1 : size(u,1)
    if u(i,nJointActions) == foodLoadReward
        x_indx = x_indx+1;
        statesWithRewardsArray(x_indx) = i;
    end
end

for i = 1 : 32
    u(statesWithRewardsArray(32+i),25) = foodLoadReward;
end