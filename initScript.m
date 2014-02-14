%TEST CODE: makes a small array of data
%data = [2 4 7 8 3 4 9 10 23 12 3 9 10 12 13 1 3 4 2 9 10 12 13 5 4];
%data = [2 3 4 4 4 1 3 4 2 4 4 4 5 4];
%data = [2 10 12 13 14 15 20 34 45 67 2 10 12 13 14 15 20];
data = [2 3 15 2 3 4 5 5 6];

dataSize = size(data);
bigN = dataSize(2);

%convert the data to frequency space
baseFourierMatrixN = baseFourierMatrix(bigN+1);
freqSpaceData = baseFourierMatrixN*diag(data)