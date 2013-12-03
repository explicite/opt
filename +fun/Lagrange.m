%Optimization unimodal function with Lagrange polynomial
function optLim = Lagrange( f, lim, epsilon, gamma, N )

a = lim(1);
b = lim(2);

ai = a;
bi = b;
ci = (a + b) / 2;

di = d();
i = 0;
disp(di);
flag = true;

while flag
    flag = condition();
    
    di = d();
    
    if(ai < di && di < ci)
        if(f(di) < f(ci))
            bi = ci;
            ci = di;
        else
            ai = di;
        end
    elseif(ci < d && d < bi)
        if(f(di) < f(ci))
            ai = ci;
            ci = di;
        else
            bi = di;
        end
    else
        throw((MException('MATLAB:error', 'algorithm converges')));
    end
    
    i = i + 1;
    if(i > N)
        throw((MException('MATLAB:error', 'cannot reach epsilon')));
    end
    
end

optLim = d;

    function flag = condition()
        flag = bi - ai < epsilon || abs(d - di) <= gamma;
    end

    function x = d()
        x =  0.5 * (f(ai) * ((ci * ci) - (bi * bi)) + f(ci) * ((bi * bi) - (ai * ai)) + f(bi) * ((ai * ai) - (ci * ci))) / ((f(ai) * (ci - bi)) + (f(ci) * (bi - ai)) + (f(bi) * (ai - ci)));
    end
end

