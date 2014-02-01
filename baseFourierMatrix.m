function [ fData ] = baseFourierMatrix( bigN )
%FOURIERMATRIX Takes in N and returns the 
%              base Fourier matrix used to get the Fourier coefficients

fData = [];
omega = exp(-2*pi*1i/bigN);
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

