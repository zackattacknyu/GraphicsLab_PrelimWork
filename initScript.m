%the range of randomly generated values will be 0 to range
range = 50; 

%the number of points generated between two instances of the sequence
%   will be a random number between 
%   minNumPoints and (minNumPoints + rangeNumPoints)
minNumPoints = 10;
rangeNumPoints = 20;

numPointsVector = floor(rand(1,3)*rangeNumPoints + minNumPoints);
firstNumPoints = numPointsVector(1,1);
secondNumPoints = numPointsVector(1,2);
thirdNumPoints = numPointsVector(1,3);

%generates the random data
data1 = floor(rand(1,firstNumPoints)*range);
data2 = floor(rand(1,secondNumPoints)*range);
data3 = floor(rand(1,thirdNumPoints)*range);

%the sequence seqToFind will be inserted in two different places
seqToFind = [234 201 198 255];
sizeSeq = size(seqToFind);
numPointsSeq = sizeSeq(2); %number of points in seqToFind

firstInstance = firstNumPoints
secondInstance = firstInstance + numPointsSeq + secondNumPoints

%this creates the signal that will be analyzed
data = [data1 seqToFind data2 seqToFind data3];
dataSize = size(data);
numEntries = dataSize(2);

%plot the original data
plot(data);

%convert the data to frequency space
dataTransform = fft(data);

%find the amplitude, frequency, and phase of the fourier transform
amplitude = sqrt(real(dataTransform).^2 + imag(dataTransform).^2)/numEntries;
frequency = 0:1/numEntries:(1 - 1/numEntries);
phase = atan2(imag(dataTransform),real(dataTransform));

plot(frequency,phase)

%Take the N coefficients from the FFT
%1. Make an N x N matrix
%2. For each coefficient X_i, plot the sine wave from the cofficient
%   For each of the N times from the sample, find the value of the sine
%   wave and put the values into row i of the N x N matrix
%Repeat 1 and 2 for different phase shifts of the FFT
%Do a search on the matrices to find a place where they line up