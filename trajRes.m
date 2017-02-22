function resVect = trajRes(traj)
    resVect = zeros(1,length(traj)-1);
    for k=1:1:length(resVect)
        resVect(k) = dist2D(traj(k,:), traj(k+1,:));
    end
end