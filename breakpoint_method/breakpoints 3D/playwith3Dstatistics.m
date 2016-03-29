LL=bwlabeln(FracsNeg3D)


BW=FracsNeg3D;
conn = 26;
CC = bwconncomp(BW, conn);
S = regionprops(CC);

% CHI = imEuler3d(IMG, CONN)
% Specify the connectivity to use. Can be either 6 (the default) or 26.
CHI = imEuler3d(BW, conn)
%   Specify the connectivity to use. Can be either 6 (the default) or 26.
%
%   [CHI LABELS] = imEuler3d(IMG, ...)
%   When IMG is a label image, the Euler-Poincar characteristic of each
%   label is computed and returned in CHI. LABELS is the array of unique
%   labels in image.
%
%   [CHI LABELS] = imEuler3d(IMG, ...)
%   When IMG is a label image, the Euler-Poincar characteristic of each
%   label is computed and returned in CHI. LABELS is the array of unique
%   labels in image.

function [breadth, labels] = imMeanBreadth(img, varargin)
%IMMEANBREADTH Mean breadth of a 3D binary or label image
%
%   B = imMeanBreadth(IMG)
%   Computes the mean breadth of the binary structure in IMG, or of each
%   particle in the label image IMG.
%
%   B = imMeanBreadth(IMG, NDIRS)
%   Specifies the number of directions used for estimating the mean breadth
%   from the Crofton formula. Can be either 3 (the default) or 13.
%
%   B = imMeanBreadth(..., DELTA)
%   Specifies the resolution of the image as a 1-by-3 row vector containing
%   pixel spacing in X, Y and Z directions respectively.
%
%   [B LABELS]= imMeanBreadth(LBL, ...)
%   Also returns the set of labels for which the mean breadth was computed.
