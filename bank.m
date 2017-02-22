function traj = bank(baseSize, resolution, currTraj, speed)
    bankRadius = [80 130 180];
    radius = bankRadius(speed);
    len = (2*pi*radius)/8;
    numSteps = ceil(len/resolution);
    angleStep = (pi/4)/numSteps;
    traj = zeros(numSteps,2);
    for k=1:1:(numSteps+1)
       angle = (k-1)*angleStep;
       traj(k,:) = [((-1*cos(angle))+1) sin(angle)].*radius;
    end
    finishSteps = baseSize/resolution;
    offset = length(traj);
    lastData = traj(offset, :);
    step = [resolution/sqrt(2) resolution/sqrt(2)];
    traj = [traj; zeros(finishSteps, 2)];
    for k=1:1:(finishSteps)
        traj(offset+k, :) = lastData + step.*k;
    end
    traj = [currTraj; traj];
end