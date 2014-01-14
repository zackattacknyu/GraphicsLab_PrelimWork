%the range of randomly generated values will be 0 to range
range = 50; 

%the number of points generated between two instances of the sequence
%   will be a random number between 
%   minNumPoints and (minNumPoints + rangeNumPoints)
minNumPoints = 30;
rangeNumPoints = 50;

numPointsVector = rand(1,3)*rangeNumPoints + minNumPoints;

%generates the random data
data1 = floor(rand(1,numPointsVector(1,1))*range);
data2 = floor(rand(1,numPointsVector(1,2))*range);
data3 = floor(rand(1,numPointsVector(1,3))*range);

%the sequence [234 134 89 78] will be inserted in two different places
seqToFind = [234 201 198 255];
sizeSeq = size(seqToFind);
numPointsSeq = sizeSeq(2); %number of points in seqToFind

firstInstance = numPointsVector(1,1)
secondInstance = firstInstance + numPointsSeq + numPointsVector(1,2)

%this creates the signal that will be analyzed
data = [data1 seqToFind data2 seqToFind data3]
dataSize = size(data);
numEntries = dataSize(2);

%originalDataFFT = fft(originalData);

