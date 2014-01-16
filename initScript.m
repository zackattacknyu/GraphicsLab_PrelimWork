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
numEntries = dataSize(2);

%plot the original data
plot(data);

%{

Procedure to be used: 
1. Take the N coefficients from the FFT
2. Construct an NxN matrix A
    When reconstructing the signal we know that 
        x[t] = 1/N sum_{k=0}^{N-1} X_k exp(2*pi*i*t*k/N)
    We will then make an NxN matrix where each column is a different t
        and each row is a term in the summation
3. TODO: Plot the wave for each of the cofficients
4. Do a phase shift on the FFT
     Find the amplitude and phase array
     Adjust the values of the phase array to make array newPhase
     Use amplitude and newPhase to get new Fourier cofficients
        Do amplitude*exp(i*newPhase)
5. Repeat step 2 for the new Fourier coefficients to generate
    a new NxN matrix B
6. Compare matrix A and matrix B to see if there any line ups
    This means computing matrix C = abs(A-B) and counting the number of
        entries that are near zero (< 10^-3)
7. Repeat steps 4-6 for the different phase shifts
        

%}

%convert the data to frequency space
dataTransform = fft(data);

%find the amplitude, frequency, and phase of the fourier transform
%frequency = 0:1/numEntries:(1 - 1/numEntries);
amplitude = sqrt(real(dataTransform).^2 + imag(dataTransform).^2);
phase = atan2(imag(dataTransform),real(dataTransform));

%plot(frequency,phase)

%This will make the initial N x N matrix
originalData = fourierMatrix(dataTransform);

%this will do a phase shift and then make a new matrix
countArray = [];
for phaseShift = 1:(numEntries-1),
    
    newPhase = phase + phaseShift;
    innerExponent = i.*newPhase;
    multiplier = exp(innerExponent);
    
    newTransform = amplitude.*multiplier;
    
    shiftedData = fourierMatrix(newTransform);
    diffShifted = abs(shiftedData-originalData);
    
    count = 0;
    for row = 1:numEntries,
        for col = 1:numEntries,
            if(diffShifted(row,col) < 10^(-2))
                count = count + 1;
            end
        end
    end
    countArray = [countArray count];

end

plot(countArray)















