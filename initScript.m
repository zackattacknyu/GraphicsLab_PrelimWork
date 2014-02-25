%TEST CODE: makes a small array of data
%data = [2 4 7 8 3 4 9 10 23 12 3 9 10 12 13 1 3 4 2 9 10 12 13 5 4];
%data = [2 3 4 4 4 1 3 4 2 4 4 4 5 4];
%start_data = [2 10 12 13 14 15 20 34 45 67 2 10 12 13 14 15 20];
%start_data = [2 10 12 13 67 2 10 12 13];
%start_data = [2 3 4 8 2 3 4 5 9 6];
start_data = [1 2 4 3 12 100 104 105 6 9 8 5 7 100 104 105 11 10];

%we will take the freqSpaceData and consider each column
%   a point in N-dimensional space
%we will look at the components and see what we find

freqSpaceOriginal = generateFreqSpaceData(start_data);

%test the low-pass filter and see the effects
%the matlab convolution function will use 0 as the first signal entry
%   so that the first entry in data will be (0+s_1)/2. That entry will be
%   taken out before the frequency space data is computed
data = conv(start_data,[0.5 0.5]);
dataSize = size(data);
numColumns = dataSize(2);
data = data(2:numColumns); %take out first entry
freqSpaceLowPass = generateFreqSpaceData(data);

%test the effects of a gradient
dataSize = size(start_data);
bigN = dataSize(2);
gradient = 0:1:bigN-1;
data = start_data+gradient;
freqSpaceGradient = generateFreqSpaceData(data);

%see if frequency space will be multiplied under low-pass filter
divisionMatrix = abs(freqSpaceOriginal./freqSpaceLowPass)

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