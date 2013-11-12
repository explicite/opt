function [ a b ] = Expansion( f, d, e )
import fun.Penalty
%EXPANSION Summary of this function goes here
%   f - uchwyt do funkcji; d,e - pocz¹tek i koniec przedzia³u

    eratio = 2;
    Nmax = 10000;
    
    if f(e) == f(d)
        a = d;
        b = e;
        return
    end
    
    if f(e) > f(d)
        e = -e;
        disp('zamiana');
        if f(e) >= f(d)
            disp('if wewnetrzny');
            a = e;
            b = -e;
            return;
        end
    end
    i = 1;
    
    old = e;
    new = eratio * e;
   
    while (f(old) + Penalty(old, d, e) >= f(new) + Penalty(new, d, e))
        if i > Nmax
            error('Przekroczono liczbe iteracji');
        end
        i = i + 1;

        old = new;
        new = eratio.^i * old;
    end
    
    if old < new
        a = d;
        b = new;
    else
        a = new;
        b = d;
    end

end