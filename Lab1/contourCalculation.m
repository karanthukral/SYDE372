%CONTOURCALCULATION Summary of this function goes here
%   Detailed explanation goes here
function [X, Y] = contourCalculation( mean, covar )
    [sigma] = cov2corr(covar);
    majorAxis = 2*sigma(1);
    minorAxis = 2*sigma(2);
    centerX = mean(1);
    centerY = mean(2);
    [V,D,W] = eig(covar);
    orientation = 0;
    if covar(1, 2) ~= 0
        orientation = tan(W(2,2)/W(1,2))*360/(2*pi);
    end

    theta = 0 : 0.05 : 2*pi;
    orientation=orientation*pi/180;
    xx = (majorAxis/2) * sin(theta) + centerX;
    yy = (minorAxis/2) * cos(theta) + centerY;

    X = (xx-centerX)*cos(orientation) - (yy-centerY)*sin(orientation) + centerX;
    Y = (xx-centerX)*sin(orientation) + (yy-centerY)*cos(orientation) + centerY;
end

