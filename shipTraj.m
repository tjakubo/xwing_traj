function [angTraj, posTraj] = shipTraj(path, baseSize)
    angTraj = zeros(0, 1);
    posTraj = zeros(0, 2);

    backIndex = 1;
    maxRes = max(trajRes(path));
    frontIndex = backIndex + floor((baseSize)/maxRes) - 1;
    overshoot = false;
    
    while overshoot ~= true
        backPoint = path(backIndex, :);
        frontPoint = path(frontIndex, :);

        while pdist([backPoint; frontPoint], 'Euclidean') < baseSize && frontIndex < length(path)
            frontIndex = frontIndex + 1;
            frontPoint = path(frontIndex, :);
        end

        if pdist([backPoint; frontPoint], 'Euclidean') >= baseSize
            beforePoint = path(frontIndex-1, :);
            slope = (frontPoint(2)-beforePoint(2))/(frontPoint(1)-beforePoint(1));
            if slope ~= Inf 
                intc = beforePoint(2) - slope*(beforePoint(1));
            else
                intc = beforePoint(1);
            end
            [ptX, ptY] = linecirc(slope, intc, backPoint(1), backPoint(2), baseSize);
            pt1 = [ptX(1) ptY(1)];
            pt2 = [ptX(2) ptY(2)];
            if (pdist([pt1; frontPoint], 'Euclidean') <= maxRes) 
                frontExPoint = pt1;
            else
                frontExPoint = pt2;
            end
            
            midPoint = [(backPoint(1)+frontExPoint(1))/2 (backPoint(2)+frontExPoint(2))/2];
            angle = atan((frontExPoint(2)-backPoint(2))/(frontExPoint(1)-backPoint(1)));
            posTraj = [posTraj; midPoint];
            angTraj = [angTraj; -1*(angle*180/pi)+90];
            
        else
            overshoot = true;
            frontIndex = length(path);
            frontPoint = path(frontIndex, :);
            backIndex = frontIndex - floor((baseSize)/maxRes) + 1;
            backPoint = path(backIndex, :);

            while pdist([backPoint; frontPoint], 'Euclidean') < baseSize
                backIndex = backIndex - 1;
                backPoint = path(backIndex, :);
            end

            beforePoint = path(backIndex+1, :);
            slope = (backPoint(2)-beforePoint(2))/(backPoint(1)-beforePoint(1));
            if slope ~= Inf && slope ~= -Inf
                intc = beforePoint(2) - slope*(beforePoint(1));
            else
                intc = beforePoint(1);
            end
            [ptX, ptY] = linecirc(slope, intc, frontPoint(1), frontPoint(2), baseSize);
            pt1 = [ptX(1) ptY(1)];
            pt2 = [ptX(2) ptY(2)];
            if (pdist([pt1; backPoint], 'Euclidean') <= maxRes) 
                backExPoint = pt1;
            else
                backExPoint = pt2;
            end

            midPoint = [(frontPoint(1)+backExPoint(1))/2 (frontPoint(2)+backExPoint(2))/2];
            angle = atan((backExPoint(2)-frontPoint(2))/(backExPoint(1)-frontPoint(1)));
            posTraj = [posTraj; midPoint];
            angTraj = [angTraj; -1*(angle*180/pi)-90];
        end  
        backIndex = backIndex + 1;
    end
    
    
%      figure(1)
%      scatter(path(:,1), path(:,2), 'r.'); hold on;
%      %scatter([path(backIndex, 1); path(frontIndex, 1)], [path(backIndex, 2); path(frontIndex, 2)], 'g*');
% %      scatter([path(backIndex, 1); pt1(1)], [path(backIndex, 2); pt1(2)], 'g*'); hold on;
% %      scatter([path(backIndex, 1); pt2(1)], [path(backIndex, 2); pt2(2)], 'g*'); hold on;
% %      scatter([path(frontIndex-1, 1); path(frontIndex, 1)], [path(frontIndex-1, 2); path(frontIndex, 2)], 'bo');
%      axis equal;
end