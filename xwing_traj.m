clear variables;
res_mm = 1; % global resolution of moves
baseSize = 40; % 20mm - small base, 40mm - large base

traj = bank(baseSize, res_mm, 1);
figure(1)
scatter(traj(:,1), traj(:,2), '.');
axis equal;

resV = trajRes(traj);
figure(2);
plot(resV);