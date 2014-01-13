numPoints = 20; %number of rows
range = 50; %the range of values will be integers from 0 to range
data1 = floor(rand(1,numPoints)*range);

%the sequence [234 134 89 78] will be inserted in two different places
nextNumPoints = floor(rand(1,3)*10);
seqToFind = [234 201 198 255];
data2 = floor(rand(1,nextNumPoints(1,1))*range);
data3 = floor(rand(1,nextNumPoints(1,2))*range);
data4 = floor(rand(1,nextNumPoints(1,3))*range);
data5 = floor(rand(1,numPoints)*range);

firstInstance = numPoints + nextNumPoints(1,1)
secondInstance = firstInstance + 4 + nextNumPoints(1,2)

%this is the created signal to analyze
data = [data1 data2 seqToFind data3 seqToFind data4 data5];
dataSize = size(data);
numEntries = dataSize(2);

corrs = [];

for timeShift = 1:numEntries,

    endIndex = numEntries - timeShift;
    originalData = data(timeShift:numEntries);
    shiftedData = data(1:endIndex);

    %originalDataFFT = fft(originalData);
    %shiftedDataFFT = fft(shiftedData);
    %currentCorrelation = sum( xcorr(originalDataFFT,shiftedDataFFT) );

    currentCorrelation = sum( xcorr(originalData,shiftedData) );

    corrs = [corrs currentCorrelation];
end

plot(corrs,'r.')
