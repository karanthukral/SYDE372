function class = NN(dataPoint, k, classes)
    if k == 1
        class = 1;
        minDist = 9999;
        for i=1:length(classes)
            currentClass = classes(i);
            [rows, cols] = size(currentClass.gauss);
            for row = 1:rows
                classPt = currentClass.gauss(row, :);
                distance =((dataPoint-classPt) * (dataPoint-classPt)')^0.5;
                if distance < minDist
                    minDist = distance;
                    class = i;
                end
            end
        end
    else
        distances = [];
        allDistances = [];
        class1Pts = [];
        class2Pts = [];
        class3Pts = [];
        for i=1:length(classes)
            currentClass = classes(i);
            [rows, cols] = size(currentClass.gauss);
            for row = 1:rows
                classPt = currentClass.gauss(row, :);
                distance =((dataPoint-classPt) * (dataPoint-classPt)')^0.5;
                distances = [distances; distance];
            end
            currentClass.gauss = [currentClass.gauss distances];
            [values, order] = sort(currentClass.gauss(:, 3));
            sortedMatrix = currentClass.gauss(order, :);
            sortedMatrix(:, 3) = [];
            for j=1:k
                if i == 1
                    class1Pts = [class1Pts; sortedMatrix];
                elseif i == 2
                    class2Pts = [class2Pts; sortedMatrix];
                else
                    class3Pts = [class3Pts; sortedMatrix];
                end
            end
            distances = [];
        end
        mean1 = mean(class1Pts(:,1:2));
        mean2 = mean(class2Pts(:,1:2));
        mean3 = [];
        if length(classes) == 3
            mean3 = mean(class3Pts(:,1:2));
        end
        means = [mean1; mean2; mean3];
        
        eDistances = [];
        for i=1:length(classes)
          meanPt = means(i);
          distance =((dataPoint-meanPt) * (dataPoint-meanPt)')^0.5;  
          eDistances = [eDistances distance];
        end
        [minimumDist, class]=min(eDistances);
    end
end