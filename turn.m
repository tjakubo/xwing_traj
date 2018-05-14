function [traj, length] = turn(baseSize, resolution, speed)
    % initial straight part
    initTraj = init(baseSize, resolution); 
    % curved turn trajectory path
    turnRadius = [35 62.5 90];
    radius = turnRadius(speed); 
    len = (2*pi*radius)/4;     
    numSteps = ceil(len/resolution); 
    angleStep = (pi/2)/numSteps;
    offset = initTraj(end, :);
    moveTraj = zeros( numSteps,2);
    for k=1:(numSteps)
       angle = k*angleStep;
       moveTraj(k,:) = [((-1*cos(angle))+1) sin(angle)].*radius + offset;
    end
    % final straight path
    finishSteps = baseSize/resolution;
    offset = moveTraj(end, :);
    finTraj = zeros(finishSteps, 2);
    for k=1:(finishSteps)
        finTraj(k, :) = [k*resolution 0] + offset;
    end
    traj = [initTraj; moveTraj; finTraj];
    length = baseSize + len;
end