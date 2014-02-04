%TEST CODE: makes a small array of data
%   section 3,4,5 and 10,11,12 are the same
data = [2 3 10 12 13 1 3 4 2 10 12 13 5 4];
%data = [2 3 4 4 4 1 3 4 2 4 4 4 5 4];

dataSize = size(data);
bigN = dataSize(2);

%{

Procedure to be used: 
1. Multiply the signal by the Fourier Matrix to get the Fourier
Coefficients
2. Construct an NxN matrix A
    When reconstructing the signal we know that 
        x[t] = 1/N sum_{k=0}^{N-1} X_k exp(2*pi*i*t*k/N)
    We will then make an NxN matrix where each column is a different t
        and each row is a term in the summation
3. TODO: Plot the wave for each of the cofficients
4. Do a phase shift. Shift the signal by one and then obtain the Fourier
coefficients again
5. Repeat step 2 for the new Fourier coefficients to generate
    a new NxN matrix B
6. Compare matrix A and matrix B to see if there any line ups
    This means computing matrix C = abs(A-B) and counting the number of
        entries that are near zero (< 10^-3)
7. Repeat steps 4-6 for the different phase shifts
        

%}

%convert the data to frequency space
baseFourierMatrixN = baseFourierMatrix(bigN);
dataTransform = baseFourierMatrixN*transpose(data);
fCoeffsMatrix = diag(dataTransform);

%This will make the initial N x N matrix
originalDataFreqSpace = fCoeffsMatrix/baseFourierMatrixN;
originalDataFreqSpaceReal = real(originalDataFreqSpace);

%this will do a phase shift and then make a new matrix

countArray = [];
for phaseShift = 1:bigN,
    
    newData = circshift(data,[0 phaseShift]);
    
    shiftedOriginalData = circshift(originalDataFreqSpaceReal,[0 phaseShift]);
    
    diffMatrix = originalDataFreqSpaceReal - shiftedOriginalData;
    
    difference = 0;
    for col = 1:bigN,
       if(norm(diffMatrix(:,col)) < 1.5)
           difference = difference + 1;
       end
    end
    
    countArray = [countArray;difference];

end

plot(countArray);

xVector = 1:1:bigN;

for index = 1:bigN,
   plot(xVector,originalDataFreqSpaceReal(index,:));
   hold on;
end
plot(xVector,data);















