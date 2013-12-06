function [ xMin ] = NelderMead( fn, n, start )
%NELLDERMEAD Summary of this function goes here
%   Detailed explanation goes here
%   fn - funkcja dwóch zmiennych
%   n - liczba zmiennych
%   start(n) - wektor z punktami startowymi
%
%   xmin(n) - punkt minimum

reqmin = 10;
step = [0.5 1 1];
congvergence = 10000;
maxIter = 10000;

xMin = [];
yNew = [];
it = 0;
numres = 0;

ccoeff = 0.5;
ecoeff = 2.0;
eps = 0.001;
rcoeff = 1.0;

jcount = congvergence;
dn = n;
nn = n + 1;
dnn = nn;
del = 1.0;
rq = reqmin * dn;


while ( 1 )
    for i = 1 : n
        p(i,nn) = start(i);
    end
    
    y(nn) = fn ( start );
    it = it + 1;
    
    for j = 1 : n
        x = start(j);
        start(j) = start(j) + step(j) * del;
        for i = 1 : n
            p(i,j) = start(i);
        end
        y(j) = fn ( start );
        it = it + 1;
        start(j) = x;
    end
    
    ylo = y(1);
    ilo = 1;
    
    for i = 2 : nn
        if ( y(i) < ylo )
            ylo = y(i);
            ilo = i;
        end
    end
    
    while ( 1 )
        if ( maxIter <= it )
            break
        end
        
        yNew = y(1);
        ihi = 1;
        
        for i = 2 : nn
            if ( yNew < y(i) )
                yNew = y(i);
                ihi = i;
            end
        end

        for i = 1 : n
            z = 0.0;
            for j = 1 : nn
                z = z + p(i,j);
            end
            z = z - p(i,ihi);
            pbar(i) = z / dn;
        end
       
        % odbicie
        for i = 1 : n
            pstar(i) = pbar(i) + rcoeff * ( pbar(i) - p(i,ihi) );
        end
        
        ystar = fn ( pstar );
        it = it + 1;
        
        % rozszerzenie
        if ( ystar < ylo )
            for i = 1 : n
                p2star(i) = pbar(i) + ecoeff * ( pstar(i) - pbar(i) );
            end
            
            y2star = fn ( p2star );
            it = it + 1;
            if ( ystar < y2star )
                for i = 1 : n
                    p(i,ihi) = pstar(i);
                end
                
                y(ihi) = ystar;
            else
                
                for i = 1 : n
                    p(i,ihi) = p2star(i);
                end
                
                y(ihi) = y2star;
                
            end
           
        else
            l = 0;
            for i = 1 : nn
                if ( ystar < y(i) )
                    l = l + 1;
                end
            end
            
            if ( 1 < l )
               for i = 1 : n
                    p(i,ihi) = pstar(i);
                end
                
                y(ihi) = ystar;
                
                %  Kontrakcja
            elseif ( l == 0 )
                for i = 1 : n
                    p2star(i) = pbar(i) + ccoeff * ( p(i,ihi) - pbar(i) );
                end
                
                y2star = fn ( p2star );
                it = it + 1;
                if ( y(ihi) < y2star )
                    for j = 1 : nn
                        for i = 1 : n
                            p(i,j) = ( p(i,j) + p(i,ilo) ) * 0.5;
                            xMin(i) = p(i,j);
                        end
                        y(j) = fn ( xMin );
                        it = it + 1;
                    end
                    
                    ylo = y(1);
                    ilo = 1;
                    
                    for i = 2 : nn
                        if ( y(i) < ylo )
                            ylo = y(i);
                            ilo = i;
                        end
                    end
                    continue
                else
                    for i = 1 : n
                        p(i,ihi) = p2star(i);
                    end
                    y(ihi) = y2star;
                end
                %
                %  Kontrakcja na odbiciu
                %
            elseif ( l == 1 )
                for i = 1 : n
                    p2star(i) = pbar(i) + ccoeff * ( pstar(i) - pbar(i) );
                end
                
                y2star = fn ( p2star );
                it = it + 1;
                
                %  Utrzymanie odbicia
                if ( y2star <= ystar )
                    for i = 1 : n
                        p(i,ihi) = p2star(i);
                    end
                    y(ihi) = y2star;
                    
                else
                    
                    for i = 1 : n
                        p(i,ihi) = pstar(i);
                    end
                    y(ihi) = ystar;
                end
            end
        end
        
        % sprawdzenie czy znaleziono mniejsza wartoœæ funkcji
        if ( y(ihi) < ylo )
            ylo = y(ihi);
            ilo = ihi;
        end
        
        jcount = jcount - 1;
        
        if ( 0 < jcount )
            continue
        end
        
        % sprawdzenie cyz osiagnieto minimum
        if ( it <= maxIter )
            jcount = congvergence;
            
            z = 0.0;
            for i = 1 : nn
                z = z + y(i);
            end
            x = z / dnn;
            
            z = 0.0;
            for i = 1 : nn
                z = z + ( y(i) - x )^2;
            end
            
            if ( z <= rq )
                break
            end
        end
     end
    
    for i = 1 : n
        xMin(i) = p(i,ilo);
    end
    
    yNew = y(ilo);
    
    if ( maxIter < it )
        ifault = 2;
        break
    end
    
    ifault = 0;
    
    for i = 1 : n
        del = step(i) * eps;
        xMin(i) = xMin(i) + del;
        z = fn ( xMin );
        it = it + 1;
        if ( z < yNew )
            ifault = 2;
            break
        end
        xMin(i) = xMin(i) - del - del;
        z = fn ( xMin );
        it = it + 1;
        if ( z < yNew )
            ifault = 2;
            break
        end
        xMin(i) = xMin(i) + del;
    end
    
    if ( ifault == 0 )
        break
    end
    
    for i = 1 : n
        start(i) = xMin(i);
    end
    del = eps;
end

return


end

