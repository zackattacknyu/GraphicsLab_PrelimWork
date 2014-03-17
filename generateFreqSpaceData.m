function [ freqSpaceData,newTransform ] = generateFreqSpaceData( data )
%GENERATEFREQSPACEDATA Summary of this function goes here
%   Detailed explanation goes here

dataSize = size(data);
bigN = dataSize(2);


%convert the data to frequency space
baseFourierMatrixN = baseFourierMatrix(bigN+1);
freqSpaceData = baseFourierMatrixN*diag(data);
newTransform = baseFourierMatrixN*transpose(data);

end

