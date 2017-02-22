function traj = turn(baseSize, resolution, currTraj, speed)
    turnRadius = [35 62.5 90];
    radius = turnRadius(speed);
    len = (2*pi*radius)/4;
    numSteps = ceil(len/resolution);
    angleStep = (pi/2)/numSteps;
    traj = zeros(numSteps,2);
    for k=1:1:(numSteps+1)
       angle = (k-1)*angleStep;
       traj(k,:) = [((-1*cos(angle))+1) sin(angle)].*radius;
    end
    finishSteps = baseSize/resolution;
    offset = length(traj);
    traj = [traj; zeros(finishSteps, 2)];
    for k=1:1:(finishSteps)
        traj(offset+k, :) = [radius+(k*resolution) radius];
    end
    traj = [currTraj; traj];
end