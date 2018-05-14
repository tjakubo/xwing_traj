function [traj, length] = bank(baseSize, resolution, speed)
    % initial straight part
    initTraj = init(baseSize, resolution); 
    % curved turn trajectory path
    bankRadius = [80 130 180];
    radius = bankRadius(speed); 
    len = (2*pi*radius)/8;     
    numSteps = ceil(len/resolution); 
    angleStep = (pi/4)/numSteps;
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
        finTraj(k, :) = [((k*resolution)/sqrt(2)) ((k*resolution)/sqrt(2))] + offset;
    end
    traj = [initTraj; moveTraj; finTraj];
    length = baseSize + len;
end