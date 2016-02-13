% NN
% dataPoint = Sample to be classified
% k = nearest neighbour factor, k=1 for NN classifer.
% classes = array/row matrix for all the classes (struct) to be considered
% Returns the index of the class to which the sample belongs
function class = NN(dataPoint, k, classes)
    if k == 1
        class = 1;
        minDist = 9999; % Arbituary large number
        for classIndex=1:length(classes)
            currentClass = classes(classIndex);
            [rows, cols] = size(currentClass.gauss);
            for row = 1:rows
                classPt = currentClass.gauss(row, :);
                distance =((dataPoint-classPt) * (dataPoint-classPt)')^0.5;
                if distance < minDist
                    minDist = distance; % Keep reference to the min distance
                    class = classIndex; % Keep reference to the closest class index 
                end
            end
        end
    else
        distances = [];
        class1Pts = [];
        class2Pts = [];
        class3Pts = [];
        % Loop through each class and calculate the distance of each point
        % to the sample
        for classIndex=1:length(classes)
            currentClass = classes(classIndex);
            [rows, cols] = size(currentClass.gauss);
            for row = 1:rows
                classPt = currentClass.gauss(row, :);
                distance =((dataPoint-classPt) * (dataPoint-classPt)')^0.5;
                distances = [distances; distance]; % Distances between sample and points
            end
            % Sort the Class's gaussian distribution according to distances
            % to find the k closest points
            currentClass.gauss = [currentClass.gauss distances];
            [values, order] = sort(currentClass.gauss(:, 3));
            sortedMatrix = currentClass.gauss(order, :);
            sortedMatrix(:, 3) = []; % Don't need the distances anymore
            % Copy the k closest points over for each class
            for rowIndex=1:k
                if classIndex == 1
                    class1Pts = [class1Pts; sortedMatrix(rowIndex,:)];
                elseif classIndex == 2
                    class2Pts = [class2Pts; sortedMatrix(rowIndex,:)];
                else
                    class3Pts = [class3Pts; sortedMatrix(rowIndex,:)];
                end
            end
            distances = [];
        end
        
        % Take the mean of the k closest points for each class
        mean1 = mean(class1Pts(:,1:2));
        mean2 = mean(class2Pts(:,1:2));
        mean3 = [];
        if length(classes) == 3
            mean3 = mean(class3Pts(:,1:2));
        end
        means = [mean1; mean2; mean3];
        
        % Run a simple MED Classifer with the new prototype
        distances = [];
        for classIndex=1:length(classes)
          prototype = means(classIndex);
          distance =((dataPoint-prototype) * (dataPoint-prototype)')^0.5;  
          distances = [distances distance];
        end
        [minimumDist, class]=min(distances);
    end
end