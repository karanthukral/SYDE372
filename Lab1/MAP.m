% MAP
% dataPoint = Sample to be classified
% classes = array/row matrix for all the classes (struct) to be considered
% Runs a conditional to check if 2 class or 3 class classifer
% Returns the index of the class to which the sample belongs
function [ class ] = MAP( dataPoint, classes)
    function dist = calculateDist(point, mean, covar)
        dist = ((point - mean) * inv(covar) * (point'-mean'));
    end

    distances = [];
    if length(classes) == 2
        for i=1:length(classes)
            class = classes(i);
            distances(i) = calculateDist(dataPoint, class.mean, class.covar);
        end

        rhs = 2*log(classes(2).n/classes(1).n) + log(det(classes(1).covar)/det(classes(2).covar));

        if distances(2)-distances(1) > rhs
            class=1;
        else
            class=2;
        end
    else
        pair_comparisions = [0 0 0];
        rhs = [];
        for i=1:length(classes)
            class = classes(i);
            distances(i) = calculateDist(dataPoint, class.mean, class.covar);
        end
        rhs(1) = 2*log(classes(2).n/classes(1).n) + log(det(classes(1).covar)/det(classes(2).covar));
        rhs(2) = 2*log(classes(2).n/classes(3).n) + log(det(classes(3).covar)/det(classes(2).covar));
        rhs(3) = 2*log(classes(3).n/classes(1).n) + log(det(classes(1).covar)/det(classes(3).covar));
        if distances(2)-distances(1) > rhs(1)
            pair_comparisions(1) = 1;
        elseif distances(2) - distances(3) > rhs(2)
            pair_comparisions(2) = 1;
        elseif distances(3) - distances(1) > rhs(3)
            pair_comparisions(3) = 1;
        end
        
        if pair_comparisions(1)==1 && pair_comparisions(3)==1
            class=1;
        elseif pair_comparisions(1)==0 && pair_comparisions(2)==0
            class=2;
        elseif pair_comparisions(2)==1 && pair_comparisions(3)==0
            class=3;
        else
            class=-1
        end
    end
end