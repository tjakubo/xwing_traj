function outFileHandle = encodeMove(outFileName, moveFun, moveName, speedTable, res_mm)
    gKey = 'MoveLUT';
    posKey = 'posXZ';
    rotKey = 'rotY';
    
    persistent outFile;
    if isempty(outFile)
       outFile = fopen(outFileName, 'w'); 
       encodeInit(outFile, gKey, res_mm);
    end
    
    for baseSize=[40 80]
        if baseSize == 40
            baseName = 'smallBase';
        else
            baseName = 'largeBase';
        end
        fprintf(outFile, [gKey '.' baseName '.' moveName ' = {}\n']);
        for speed=speedTable    
            fprintf(outFile, [gKey '.' baseName '.' moveName '[' num2str(speed) '] = {}\n']);
            [traj, len] = moveFun(baseSize, res_mm, speed);
            %traj = trajAlign(traj);
            [angTraj, posTraj] = shipTraj(traj, baseSize);
            dataNum = length(angTraj);
            fprintf(outFile, [gKey '.' baseName '.' moveName '[' num2str(speed) '].dataNum = %i\n'], dataNum);
            fprintf(outFile, [gKey '.' baseName '.' moveName '[' num2str(speed) '].length = %.3f\n'], len);
            fprintf(outFile, [gKey '.' baseName '.' moveName '[' num2str(speed) '].' posKey ' = {']);
            for j=1:length(posTraj)
                fprintf(outFile, '{%.3f, %.3f}, ', posTraj(j,1), posTraj(j,2));
            end
            fprintf(outFile, '}\n');
            fprintf(outFile, [gKey '.' baseName '.' moveName '[' num2str(speed) '].' rotKey ' = {']);
            for j=1:length(angTraj)
                fprintf(outFile, '%.3f, ', angTraj(j));
            end
            fprintf(outFile, '}\n');
        end
    end
    outFileHandle = outFile;
end

function encodeInit(outFile, gKey, res_mm)
    fprintf(outFile, [gKey ' = {}\n']);
    fprintf(outFile, [gKey '.smallBase = {}\n']);
    fprintf(outFile, [gKey '.largeBase = {}\n']);
    fprintf(outFile, [gKey '.resolution = %.3f\n'], res_mm);
end