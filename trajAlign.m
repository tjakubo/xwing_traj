function trajAligned = trajAlign(traj)
    offset = -1.*traj(1, :);
    
    trajAligned = zeros(size(traj));
    for i=1:length(trajAligned)
       trajAligned(i, :) = traj(i,:) + offset;
    end
end