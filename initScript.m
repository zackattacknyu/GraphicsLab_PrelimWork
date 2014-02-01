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
dataSize = size(data);
bigN = dataSize(2);

%plot the original data
plot(data);

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
dataTransform = baseFourierMatrix(bigN)*transpose(data);

%This will make the initial N x N matrix
originalData = fourierMatrix(dataTransform);

%this will do a phase shift and then make a new matrix
countArray = [];
for phaseShift = 1:bigN,
    
    newData = circshift(data,[0 phaseShift]);
    
    newTransform = baseFourierMatrix(bigN)*transpose(newData);
    newData = fourierMatrix(newTransform);
    
    diffMatrix = originalData - newData;

    difference = 0;
    for col = 1:bigN,
       if(norm(diffMatrix(:,col)) < 10)
           difference = difference + 1;
       end
    end
    
    countArray = [countArray;difference];

end















