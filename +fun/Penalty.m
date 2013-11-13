function [ f ] = Penalty( x, a, b )
%PENALTY funkcja kary
%   Detailed explanation goes here
    if (x<a || x>b)
        f = (x-a)*(x-b);
    else
        f = 0;
    end
end

