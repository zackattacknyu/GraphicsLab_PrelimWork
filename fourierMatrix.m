function [ fData ] = fourierMatrix( dataTransform )
%FOURIERMATRIX Takes in fourier coefficients
%               and returns a matrix of the values
%When reconstructing the signal we know that 
%        x[t] = 1/N sum_{k=0}^{N-1} X_k exp(2*pi*i*t*k/N)
%    We will then make an NxN matrix where each column is a different t
%        and each row is a term in the summation

sizeTransform = size(dataTransform);
numEntries = sizeTransform(2);

%puts the coefficients into a diagonal matrix
fCoeffs = diag(dataTransform);

%makes the base matrix
baseFourier = baseFourierMatrix(numEntries);

%the matrix we desired is the diagonalMatrix*baseMatrix
fData = fCoeffs*baseFourier;
end

