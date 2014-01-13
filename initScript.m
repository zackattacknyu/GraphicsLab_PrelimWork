numPoints = 20; %number of rows
range = 256; %the range of values will be integers from 0 to range
data1 = floor(rand(1,numPoints)*range);

%the sequence [234 134 89 78] will be inserted in two different places
nextNumPoints = floor(rand(1,3)*10);
seqToFind = [234 134 89 78];

data2 = floor(rand(1,nextNumPoints(1,1))*range);
data3 = floor(rand(1,nextNumPoints(1,2))*range);
data4 = floor(rand(1,nextNumPoints(1,3))*range);

data5 = floor(rand(1,numPoints)*range);

data = [data1 data2 seqToFind data3 seqToFind data4 data5]