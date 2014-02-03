%the range of randomly generated values will be 0 to range
range = 50; 

%the number of points generated between two instances of the sequence
%   will be a random number between 
%   minNumPoints and (minNumPoints + rangeNumPoints)
minNumPoints = 10;
rangeNumPoints = 20;
endNumPoints = 40; %number of points added to end

numPointsVector = floor(rand(1,3)*rangeNumPoints + minNumPoints);
firstNumPoints = numPointsVector(1,1);
secondNumPoints = numPointsVector(1,2);
thirdNumPoints = numPointsVector(1,3);

%generates the random data
data1 = floor(rand(1,firstNumPoints)*range);
data2 = floor(rand(1,secondNumPoints)*range);
data3 = floor(rand(1,thirdNumPoints + endNumPoints)*range); 

%the sequence seqToFind will be inserted in two different places
seqToFind = [234 201 198 255];
sizeSeq = size(seqToFind);
numPointsSeq = sizeSeq(2); %number of points in seqToFind

firstInstance = firstNumPoints
secondInstance = firstInstance + numPointsSeq + secondNumPoints

%this creates the signal that will be analyzed
data = [data1 seqToFind data2 seqToFind data3];

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
    
    %{
    Shifting the matrix over is equivalent to these commands:
    
    
    newTransform = baseFourierMatrix(bigN)*transpose(newData);
    new_fCoeffsMatrix = diag(newTransform);
    newDataFreqSpace = new_fCoeffsMatrix/baseFourierMatrixN;
    newDataFreqSpaceReal = real(newDataFreqSpace);
    %}
    shiftedOriginalData = circshift(originalDataFreqSpaceReal,[0 phaseShift]);
    
    %diffMatrix = originalDataFreqSpaceReal - newDataFreqSpaceReal;
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
plot(xVector,originalDataFreqSpaceReal(1,:),...
xVector,originalDataFreqSpaceReal(2,:),...
xVector,originalDataFreqSpaceReal(3,:),...
xVector,originalDataFreqSpaceReal(4,:),...
xVector,originalDataFreqSpaceReal(5,:),...
xVector,originalDataFreqSpaceReal(6,:),...
xVector,originalDataFreqSpaceReal(7,:),...
xVector,originalDataFreqSpaceReal(8,:),...
xVector,originalDataFreqSpaceReal(9,:),...
xVector,originalDataFreqSpaceReal(10,:),...
xVector,originalDataFreqSpaceReal(11,:),...
xVector,originalDataFreqSpaceReal(12,:),...
xVector,originalDataFreqSpaceReal(13,:),...
xVector,originalDataFreqSpaceReal(14,:),...
xVector,data);
















