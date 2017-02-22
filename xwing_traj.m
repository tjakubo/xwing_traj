clear variables;
res_mm = 1; % global resolution of moves
baseSize = 40; % 20mm - small base, 40mm - large base

traj = init(baseSize, res_mm, []);
traj = bank(baseSize, res_mm, traj, 1);
scatter(traj(:,1), traj(:,2), '.');
axis equal;