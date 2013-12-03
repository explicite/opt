%Optimization unimodal function with Fibonacci numbers
function optLim = Fibonacci(f, lim, eps)
    a = lim(1);
    b = lim(2);
    
    k = find((b - a) / eps);        
    ai = a;
    bi = b;
    ci = bi - B(k) * (bi - ai);
    di = ai + bi - ci;
    
    for i = 0:(k-3)
        
        if f(ci) < f(di)
            bi = di;
        else
            ai = ci;
        end
        
        ci = bi - B(k - i) * (bi - ai);
        di = ai + bi - ci;
     
    end
    
    %Optimized lim for f - function
    optLim = [ai bi];

    function b = B(k)
        b = fibs(k - 1) / fibs(k);
    end

    function x = find(d)
        x = findFrom(d,0);
    end

    function x = findFrom(d, k)
        if fibs(k) < d
            x = findFrom(d, k + 1);
        else
            x = k;    
        end
    end

    function x1 = fibs(n)
        m = zeros(n, 1);
        m(1) = 1;
        m(2) = 1;
        for ff = 3:n
            m(ff) = m(ff - 1)+m(ff - 2);
        end
        x1 = m(end);
    end

end

