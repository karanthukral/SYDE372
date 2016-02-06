%CONTOURCALCULATION Summary of this function goes here
%   Detailed explanation goes here
function [X, Y] = contourCalculation( mean, covar )
    [sigma, correlation] = cov2corr(covar);
    majorAxis = 2*sigma(1);
    minorAxis = 2*correlation(2);
    centerX = mean(1);
    centerY = mean(2);
    [V,D,W] = eig(covar);
    orientation = tan(W(2,1)/W(1,1))*360/(2*pi);

    theta = 0 : 0.05 : 2*pi;
    orientation=orientation*pi/180;
    xx = (majorAxis/2) * sin(theta) + centerX;
    yy = (minorAxis/2) * cos(theta) + centerY;

    X = (xx-centerX)*cos(orientation) - (yy-centerY)*sin(orientation) + centerX;
    Y = (xx-centerX)*sin(orientation) + (yy-centerY)*cos(orientation) + centerY;
end

