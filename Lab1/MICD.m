% MICD
% dataPoint = Sample to be classified
% classes = array/row matrix for all the classes (struct) to be considered
% Returns the index of the class to which the sample belongs
function class = MICD(dataPoint, classes)
    distances = [];
    for i=1:length(classes)
        class = classes(i);
        dist = (dataPoint-class.mean) * inv(class.covar) * (dataPoint-class.mean)';
        distances = [distances dist];
    end
    [minDist, class] = min(distances);
end

