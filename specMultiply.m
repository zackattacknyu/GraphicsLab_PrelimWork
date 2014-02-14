function [ C ] = specMultiply( A,B )
%SPECMULTIPLY This multplies matrices but with the product as follows:
%       If C = A*B for matrices A and B, then we have
%       C_{ij} = Sum_{k=1 to N} { (A_{ik}-B_{kj})^2 }
%   Detailed explanation goes here

sizeA = size(A);
sizeB = size(B);

bigI = sizeA(1);
bigJ = sizeB(2);

C = ones(bigI,bigJ);

for i = 1:bigI,
   for j = 1:bigJ,
       C(i,j) = sum( ( A(i,:)-transpose(B(:,j)) ).^2 );
   end
end

end

