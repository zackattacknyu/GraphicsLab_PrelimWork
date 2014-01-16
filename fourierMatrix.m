function [ fData ] = fourierMatrix( dataTransform )
%FOURIERMATRIX Takes in fourier coefficients
%               and returns a matrix of the values
%When reconstructing the signal we know that 
%        x[t] = 1/N sum_{k=0}^{N-1} X_k exp(2*pi*i*t*k/N)
%    We will then make an NxN matrix where each column is a different t
%        and each row is a term in the summation

fData = [];
sizeVector = size(dataTransform);
numEntries = sizeVector(2);
for k = 0:(numEntries-1),
    currentRow = [];
    for tVal = 0:(numEntries-1),
        index = k+1;
        value = dataTransform(index)*exp(2*pi*1i*tVal*k/numEntries);
        currentRow = [currentRow value];
    end
    fData = [fData;currentRow];
end

end

