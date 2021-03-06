%TEST CODE: makes a small array of data
%data = [2 4 7 8 3 4 9 10 23 12 3 9 10 12 13 1 3 4 2 9 10 12 13 5 4];
%data = [2 3 4 4 4 1 3 4 2 4 4 4 5 4];
%start_data = [2 10 12 13 14 15 20 34 45 67 2 10 12 13 14 15 20];
%start_data = [2 10 12 13 67 2 10 12 13];
%start_data = [2 3 4 8 2 3 4 5 9 6];
start_data = [1 2 4 3 12 100 104 105 6 9 8 5 7 100 104 105 11 10];

startDataSize = size(start_data);
numInitEntries = startDataSize(2);

%we will take the freqSpaceData and consider each column
%   a point in N-dimensional space
%we will look at the components and see what we find



%test the low-pass filter and see the effects
%the matlab convolution function will use 0 as the first signal entry
%   so that the first entry in data will be (0+s_1)/2. That entry will be
%   taken out before the frequency space data is computed 
filter = [0.5 0.5];
filterSize = size(filter);
numEntriesFilter = filterSize(2);
data = conv(start_data,filter);
dataSize = size(data);
numColumns = dataSize(2);

%puts in padding for convolution theorem showing
paddedFilter = zeros(1,numColumns);
paddedFilter(1:numEntriesFilter) = filter;
paddedStartData = zeros(1,numColumns);
paddedStartData(1:numInitEntries) = start_data;

%shows the convolution theorem for our case
fftData = fft(data);
fftStartDataFilter = fft(paddedStartData).*fft(paddedFilter);
fftDiff = abs(fftData-fftStartDataFilter);

%data = data(2:numColumns); %take out first entry
midIndex = floor(numColumns/2) + 1;
nextMidIndex = midIndex + 1;
[freqSpaceLowPass,lowPassSignalTransformed] = generateFreqSpaceData(data);
lowPassTransformCosPart = lowPassSignalTransformed(2:midIndex);
lowPassTransformSinPart = lowPassSignalTransformed(nextMidIndex:numColumns);

%attempts a convolution theorem style thing for our case
[freqSpaceOriginal,origSignalTransformed] = generateFreqSpaceData(paddedStartData);
origTransformCosPart = origSignalTransformed(2:midIndex);
origTransformSinPart = origSignalTransformed(nextMidIndex:numColumns);

[filterData,filterTransformed] = generateFreqSpaceData(paddedFilter);
filterTransformCosPart = filterTransformed(2:midIndex);
filterTransformSinPart = filterTransformed(nextMidIndex:numColumns);

predictedCosPart = origTransformCosPart.*filterTransformCosPart -...
    origTransformSinPart.*filterTransformSinPart;
predictedSinPart = origTransformCosPart.*filterTransformSinPart +...
    origTransformSinPart.*filterTransformCosPart;


%test the effects of a gradient
dataSize = size(start_data);
bigN = dataSize(2);
gradient = 0:1:bigN-1;
data = start_data+gradient;
[freqSpaceGradient,gradientTransformed] = generateFreqSpaceData(data);

%{

The above phenomenon happens for the following reason:
    Let omega be the frequency matrix we multiply by
    Let V be the diagonal matrix of our signal
    Let V* be the diagonal matrix of our convoluted signal    
    Let alpha be the diagonal matrix for computing V* so that V* = V*alpha
    
    Let R and R* be such that
    (omega) (V) = (R)
    (omega) (V*) = (R*)

    Then since
    (omega) (V) (alpha) = (R) (alpha)
    
    It holds that (R*) = (R)(alpha)


%}