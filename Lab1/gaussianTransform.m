%GAUSSIANTRANSFORM Summary of this function goes here
%   Detailed explanation goes here
function [ Z ] = gaussianTransform( mean, covar )
    R = chol(covar);
    Z = repmat(mean,200,1) + randn(200,2)*R;
end

