function class = MICD(dataPoint, classes)
    distances = [];
    for i=1:length(classes)
        class = classes(i);
        dist = (dataPoint-class.mean) * inv(class.covar) * (dataPoint-class.mean)';
        distances = [distances dist];
    end
    [minDist, class] = min(distances);
end

