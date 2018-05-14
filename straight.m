function [traj, length] = straight(baseSize, resolution, speed)
    % initial straight part
    initTraj = init(baseSize, resolution);
    % trajectory path + final straight
    strLen = [40 80 120 160 200];
    len = strLen(speed)+baseSize;
    stepNum = ceil(len/resolution);
    step = len/stepNum;
    offset = initTraj(end, :);
    moveTraj = zeros(stepNum, 2);
    for k=1:stepNum
       moveTraj(k,:) = offset + [0 step*k];
    end
    traj = [initTraj; moveTraj];
    length = len + baseSize;
end