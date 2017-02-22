function traj = bank(baseSize, resolution, speed)
    % initial straight part
    traj = init(baseSize, resolution); 
    % curved turn trajectory path
    bankRadius = [80 130 180];
    radius = bankRadius(speed); 
    len = (2*pi*radius)/8;     
    numSteps = ceil(len/resolution); 
    angleStep = (pi/4)/numSteps;
    offset = length(traj);
    traj = [traj; zeros( numSteps,2)];
    for k=1:1:(numSteps)
       angle = k*angleStep;
       traj(k+offset,:) = [((-1*cos(angle))+1) sin(angle)].*radius;
    end
    % final straight path
    finishSteps = baseSize/resolution;
    offset = length(traj);
    ref = traj(length(traj),:);
    traj = [traj; zeros(finishSteps, 2)];
    for k=1:1:(finishSteps)
        traj(k+offset, :) = [ref(1)+((k*resolution)/sqrt(2)) ref(2)+((k*resolution)/sqrt(2))];
    end
end