function traj = turn(baseSize, resolution, speed)
    % initial straight part
    traj = init(baseSize, resolution); 
    % curved turn trajectory path
    turnRadius = [35 62.5 90];
    radius = turnRadius(speed); 
    len = (2*pi*radius)/4;     
    numSteps = ceil(len/resolution); 
    angleStep = (pi/2)/numSteps;
    offset = length(traj);
    traj = [traj; zeros( numSteps,2)];
    for k=1:1:(numSteps)
       angle = k*angleStep;
       traj(k+offset,:) = [((-1*cos(angle))+1) sin(angle)].*radius;
    end
    % final straight path
    finishSteps = baseSize/resolution;
    offset = length(traj);
    traj = [traj; zeros(finishSteps, 2)];
    for k=1:1:(finishSteps)
        traj(k+offset, :) = [radius+(k*resolution) radius];
    end
end