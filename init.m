function traj = init(baseSize, resolution)
    numPoints = baseSize/resolution;
    traj = zeros(numPoints,2);
    for k=1:1:(numPoints+1)
        traj(k,:) = [0 (-0.5*baseSize)+((k-1)*resolution)];
    end
end