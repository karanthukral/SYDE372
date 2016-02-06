% varagin = variable # of arguments (in this cae means - mean a, mean b,
% etc.)
% eucleadianDistances is a vector of distances to the mean
% calculated distance to each class mean for a point
% returns the minimum distance and class for the minimum

function [classNumber] = MED(point, classes)
    eucleadianDistances=[];
    for i=1:length(classes)
        currentClassMean = classes(i).mean;
        distance=((point-currentClassMean) * (point-currentClassMean).')^0.5;
        eucleadianDistances=[eucleadianDistances distance]
    end
    [minimumDist, classNumber]=min(eucleadianDistances);
end