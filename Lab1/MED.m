% MED
% dataPoint = Sample to be classified
% classes = array/row matrix for all the classes (struct) to be considered
% Returns the index of the class to which the sample belongs
function [classNumber] = MED(dataPoint, classes)
    eucleadianDistances=[];
    for i=1:length(classes)
        currentClassMean = classes(i).mean;
        distance=((dataPoint-currentClassMean) * (dataPoint-currentClassMean).')^0.5;
        eucleadianDistances=[eucleadianDistances distance];
    end
    [minimumDist, classNumber]=min(eucleadianDistances);
end