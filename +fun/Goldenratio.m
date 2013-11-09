function [ x ] = Goldenratio( f, a, b )
%GOLDENRATIO Summary of this function goes here
%   Detailed explanation goes here
    precision = 0.01;
    Nmax = 10000;
    
    i = 0;
    alfa = (sqrt(5) - 1)/2;
    
    c = b - alfa * (b - a);
    d = a + alfa * (b - a);

    while((b - a) > precision)
        if f(c) < f(d)
            b = d;
            d = c;
            c = b - alfa * (b - a);
        else
            a = c;
            c = d;
            d = a + alfa * (b - a);
        end
        
        i = i + 1;
        if i > Nmax
            error('Przekroczono limit iteracji');
        end
    end
    
    x = (a + b) / 2;

end

