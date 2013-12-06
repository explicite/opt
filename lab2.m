import fun.NelderMead

f = @(x) 100*(x(2) - x(1).^2).^2 + (1-x(1)).^2;
NelderMead(f, 2, [0 0])