%TEST CODE: makes a small array of data
%data = [2 4 7 8 3 4 9 10 23 12 3 9 10 12 13 1 3 4 2 9 10 12 13 5 4];
%data = [2 3 4 4 4 1 3 4 2 4 4 4 5 4];
start_data = [2 10 12 13 14 15 20 34 45 67 2 10 12 13 14 15 20];
%start_data = [2 3 4 8 2 3 4 5 9 6];
%start_data = [1 2 4 3 12 100 104 105 6 9 8 5 7 100 104 105 11 10];

data = start_data;

dataSize = size(data);
bigN = dataSize(2);

%test the effects of a gradient

gradient = 0:1:bigN-1;
data = start_data+gradient;


%test the low-pass filter
%{
data = conv(start_data,[0.5 0.5]);
dataSize = size(data);
bigN = dataSize(2);
%}

%convert the data to frequency space
baseFourierMatrixN = baseFourierMatrix(bigN+1);
freqSpaceData = baseFourierMatrixN*diag(data);

varianceMatrix = specMultiply(transpose(freqSpaceData),freqSpaceData);

%starting point: take each triplet (i, i+1, i+2) and find out the variances
%   var(i,i+1), var(i+1,i+2) and var(i+2,i)
tripletData = [];
tripletDataIndices = [];
for i = 1:bigN-2,
   val1 = varianceMatrix(i,i+1);
   val2 = varianceMatrix(i+1,i+2);
   val3 = varianceMatrix(i+2,i);
   tripletData = [tripletData;val1 val2 val3 i i+1 i+2];
   %tripletData = [tripletData;val3 val1 val2 i+2 i i+1];
   %tripletData = [tripletData;val2 val3 val1 i+1 i+2 i];
   tripletDataIndices = [tripletDataIndices; i i+1 i+2];
   %tripletDataIndices = [tripletDataIndices; i+2 i i+1];
   %tripletDataIndices = [tripletDataIndices; i+1 i+2 i];
end

plot3(tripletData(:,1),tripletData(:,2),tripletData(:,3),'o')
grid on
%we will take the freqSpaceData and consider each column
%   a point in N-dimensional space
%we will plot out the points and see what we find
%we should start by doing some clustering and seeing what happens

%we will also want to overlay a gradient and see the effects

%we will also put it through a low-pass filter and see what we find