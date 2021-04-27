function [ n ] = normalDist( x,y,z )
%Normal distribution
%   normalDist(x,y,z)
%   Normal distribution on [x, y] with z elements

i = 1;
n = zeros(1, z);
while i <= z
    r = randn(1);
    if x < r && y > r
        n(i) = r;
        i = i + 1;
    end
end

end