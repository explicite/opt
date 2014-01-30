function [ vec ] = Powell(f, vec, lim)
%POWELL Summary of this function goes here
%   Detailde explanation goes here
%   f - funnction for optimalization
%   vec - start vector
%   lim - bounds for search
%
%   [vec] - min

i = 1;
n = 2;
N = 100;
p = zeros(N,n);
p(1,:) = vec;
d = [-0.9, 0; 0, -0.7];
E = 0.0001;

syms alfa;
A = [0 0];
while (i < N)
    p(1,:) = vec;
    for j = 1:n
        
        b = @(alf)(p(1,1)+alf*d(j,1));
        c = @(alf)(p(1,2)+alf*d(j,2));
        
        t_fun = @(arg) (f( b(arg), c(arg)));
        limx = 0;
        limx_temp = 0;
        limy = 0;
    
        if(d(j,1) ~= 0)
            limx = solve(subs(sym(p(i,1)+alf1*d(j,1)== lim(1,1))), alfa);
            limx_temp = solve(subs(sym(p(i,1)+alf1*d(j,1) == lim(1,2))), alfa);
        end;
        if(d(j,2) ~= 0)
            limy = solve(subs(sym(p(i,2)+alf1*d(j,2) == lim(2,1))), alfa);       
            limy_temp = solve(subs(sym(p(i,2)+alf1*d(j,2) == lim(2,2))), alfa);
        end;
        if(limx <= 0)
            limx = limx_temp;
        end;
        if(limy <= 0)
            limy = double(limy_temp);
        end;
        
        if(limy < limx)
            limy = double(limx);        
        end;
        
        limx = 0;
        
        A(j) = Fibonnaci(t_fun, double(limx), double(limy));      
        p(j+1,:) = p(j,:) + A(j) * d(j,:);
        
    end
   
    if(abs(f(p(n+1,1),p(n+1,2)) - f(vec(1),vec(2))) < E)
        vec = p(n+1,:);
        break;
    end
    
    for j=1:n-1
        d(j,:) = d(j+1,:);
    end;
    
    d(n,:) = p(n+1,:) - p(1,:);
    b = @(a)(p(n,1)+a*(d(n,1)));
    c = @(a)(p(n,2)+a*(d(n,2)));
    t_fun = @(arg) (f( b(arg), c(arg)));
    
    limx = solve(subs(sym(p(n,1)+alf1*d(j,1)== lim(1,1))), alfa);
    limx_temp = solve(subs(sym(p(n,1)+alf1*d(j,1) == lim(1,2))), alfa);
    limy = solve(subs(sym(p(n,2)+alf1*d(j,2) == lim(2,1))), alfa);
    limy_temp = solve(subs(sym(p(n,2)+alf1*d(j,2) == lim(2,2))), alfa);
    
    if(limx <= 0)
        limx = limx_temp;
    end;
    
    if(limy <= 0)
        limy = double(limy_temp);
    end;
        
    if(limy < limx)
        limy = double(limx);        
    end;
        
    limx = 0;
        
    fun = fminbnd(t_fun, double(limx), double(limy));     
    
    vec = p(n+1,:) + fun * d(n,:);
    i = i + 1;
end