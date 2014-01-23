%{

This block of code does a phase shift in a way that I think is incorrect

%this shifts the fourier coefficients in order and then generates
%   the N by N matrix
for phaseShift = 1:numEntries,

    shiftedTransform = circshift(dataTransform,[0,phaseShift]);
    shifted_fData = [];
    for k = 0:(numEntries-1),
        currentRow = [];
        for tVal = 0:(numEntries-1),
            index = k+1;
            value = shiftedTransform(index)*exp(2*pi*1i*tVal*k/numEntries);
            currentRow = [currentRow value];
        end
        shifted_fData = [shifted_fData;currentRow];
    end
    
    diffShifted = shifted_fData-fData;
    diffShifted = abs(diffShifted);
    count = 0;
    for row = 1:numEntries,
        for col = 1:numEntries,
            if(diffShifted(row,col) < 10^(-3))
                count = count + 1;
            end
        end
    end


end


%}

%{

%This reconstructs the signal from that matrix for verification
origSignal = [];
for tVal = 1:numEntries,
    currentSum = 0;
    for k = 1:numEntries,
        index = k+1;
        currentSum = currentSum + fData(k,tVal);
    end
    origSignal = [origSignal currentSum];
end

%}

%{

%this will shift the NxN matrix generated
countArray = [];
for phaseShift = 1:(numEntries-1),
    shiftedData = circshift(fData,[0,phaseShift]);
    
    diffShifted = shiftedData-fData;
    diffShifted = abs(diffShifted);
    count = 0;
    for row = 1:numEntries,
        for col = 1:numEntries,
            if(diffShifted(row,col) < 10^(-3))
                count = count + 1;
            end
        end
    end
    countArray = [countArray count];

end

%}

%{
    
    One idea for comparison: 
    diffShifted = abs(shiftedData-originalData);
    
    count = 0;
    for row = 1:numEntries,
        for col = 1:numEntries,
            if(diffShifted(row,col) < 10^(-2))
                count = count + 1;
            end
        end
    end
    %}
    
    %{
    Another comparison idea:
    xVectorShifted = [];
    for col = 1:numEntries,
        xVectorShifted = [xVectorShifted sum(shiftedData(:,col))]; 
    end
    
    diffVector = xVectorShifted - xVectorOriginal;
    if(phaseShift < pi/4)
       diffVectorToSave = diffVector; 
    end
    meanDifference = mean(abs(diffVector));
    %}
    
    %countArray = [countArray meanDifference];