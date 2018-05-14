clear variables;
clear functions;
close all;
res_mm = 1; % global resolution of moves
baseSize = 20; % 20mm - small base, 40mm - large base

encodeMove('out.txt', @straight, 'straight', [1 2 3 4 5], res_mm);
encodeMove('out.txt', @bank, 'bank', [1 2 3], res_mm);
outFile = encodeMove('out.txt', @turn, 'turn', [1 2 3], res_mm);

fclose(outFile);
% 
% traj = bank(baseSize, res_mm, 1);
% [angTraj, posTraj] = shipTraj(traj, baseSize);
% figure(1)
% scatter(traj(:,1), traj(:,2), '.'); hold on;
% scatter(posTraj(:,1), posTraj(:,2), 'o');
% axis equal;
% 
% 
% resV = trajRes(traj);
% figure(2);
% plot(resV);