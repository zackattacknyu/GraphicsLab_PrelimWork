%{
Code to be used later for putting points together:

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

%}