function [ fData ] = baseFourierMatrix( bigN )
%FOURIERMATRIX Takes in N and returns the 
%              base Fourier matrix used to get the Fourier coefficients

fData = [];
%multiple = -2;
%omega = exp(-2*pi*multiple*1i/bigN);
for kVal = 0:((bigN-1)/2),
    currentRow = [];
    for tVal = 0:(bigN-2),
        %value = omega^(tVal*kVal);
        value = cos(tVal*kVal*2*pi/(bigN-1));
        currentRow = [currentRow value];
    end
    currentRow = currentRow/norm(currentRow);
    fData = [fData;currentRow];
end

for kVal = 1:((bigN-1)/2),
    currentRow = [];
    for tVal = 0:(bigN-2),
        %value = omega^(tVal*kVal);
        value = -1*cos(tVal*kVal*2*pi/(bigN-1) + pi/2);
        currentRow = [currentRow value];
    end
    currentRow = currentRow/norm(currentRow);
    fData = [fData;currentRow];
end

fData*transpose(fData)

end

