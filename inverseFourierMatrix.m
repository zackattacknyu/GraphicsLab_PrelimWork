function [ fData ] = inverseFourierMatrix( bigN )
%FOURIERMATRIX Takes in N and returns the 
%              base Fourier matrix used to reconstruct the signal
%When reconstructing the signal we know that 
%        x[t] = 1/N sum_{k=0}^{N-1} X_k exp(2*pi*i*t*k/N)
%    We will then make an NxN matrix where each column is a different t
%        and each row is a term in the summation
%    This will construct the exp(2*pi*i*t*k/N) entries

fData = [];
omega = exp(2*pi*1i/bigN);
for kVal = 0:(bigN-1),
    currentRow = [];
    for tVal = 0:(bigN-1),
        %value = exp(2*pi*1i*tVal*k/bigN);
        value = omega^(tVal*kVal);
        currentRow = [currentRow value];
    end
    fData = [fData;currentRow];
end

end

