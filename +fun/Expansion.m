function [ a b ] = Expansion( f, d, e )
%EXPANSION Summary of this function goes here
%   Detailed explanation goes here

    eratio = 2;
    Nmax = 10000;
    
    if f(e) == f(d)
        a = d;
        b = e;
        return
    end
    
    if f(e) > f(d)
        e = -e;
        if f(e) >= f(d)
            a = e;
            b = -e;
            return;
        end
    end
    i = 0;
    
    old = e;
    new = eratio * e;
   
    while f(old) >= f(new)
        if i > Nmax
            error('Przekroczono liczbe iteracji');
        end
        i = i + 1;

        old = new;
        new = eratio * old;
    end
    
    if old < new
        a = d;
        b = new;
    else
        a = new;
        b = d;
    end

end

