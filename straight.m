function traj = straight(baseSize, resolution, speed)
    % initial straight part
    traj = init(baseSize, resolution);
    % trajectory path + final straight
    strLen = [40 80 120 160 200];
    len = strLen(speed)+baseSize;
    stepNum = ceil(len/resolution);
    step = len/stepNum;
    offset = length(traj);
    traj = traj; zeros(2, stepNum)];
    for k=1:1:stepNum
        
    end
end