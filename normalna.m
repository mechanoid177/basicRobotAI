function [ n ] = normalna( x,y,z )
%Normalna raspodela
%   normalna(x,y,z)
%   Normalna distribucija u intervalu od x do y. z je broj clanova


i=1;
while i <= z
    r = randn(1);
    if x<r && y>r
        n(i) = r;
        i=i+1;
    end
end
end