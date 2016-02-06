% varagin = variable # of arguments (in this cae means - mean a, mean b,
% etc.)
% eucleadianDistances is a vector of distances to the mean
% calculated distance to each class mean for a point
% returns the minimum distance and class for the minimum

function [classNumber] = MED_Classifier(dataPoint, varargin)
    eucleadianDistances=[];
    for i = 1:length(varargin)
        currentClassMean=varargin{i};
        distance=((dataPoint-currentClassMean) * (dataPoint-currentClassMean).')^0.5;
        eucleadianDistances=[eucleadianDistances distance]
    end
    [minimumDist, classNumber]=min(eucleadianDistances);
end