%GAUSSIANTRANSFORM Summary of this function goes here
%   Detailed explanation goes here

function [ Z ] = gaussianTransform( n, mean, covar )
    mean_row = mean(:)';
    R = chol(covar);
    Z = repmat(mean,length(n),1) + n*R;
end
