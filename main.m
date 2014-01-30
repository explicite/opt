%import from fun folder
import fun.Fibonacci
import fun.Lagrange
import fun.NelderMead
import fun.Powell


%Examples

%Nelder - Mead
f = @(x) 100*(x(2) - x(1).^2).^2 + (1-x(1)).^2;

opt = zeros(100, 2);
param  = zeros(100, 2);
for i=1:100,
    v1 = 2* rand;
    v2 = 2* rand;
    param(i, 1) = v1;
    param(i, 2) = v2;
    topt = NelderMead(f, 2, [v1 v2]);
    opt(i, 1) = topt(1);
    opt(i, 2) = topt(2);
end
%figure
%ezsurf('100*(y-x^2)^2+(1-x)^2')

%hold on
%plot(opt(1), opt(2), 'ro')
%hold off



%Powell

%Fibonacci
f = @(x) (6 * x - 2) * (6 * x - 2) * sin(12 * x - 4);
lim = [0 1];
eps = 0.001;
optLim = Fibonacci(f, lim, eps);

figure
ezplot(f)

xlim(lim)
ylim([-10 20])

f(optLim(1))
f(optLim(2))

hold on
plot(optLim(1), f(optLim(1)), 'ro')
plot(optLim(2), f(optLim(2)), 'ro')
hold off

%Lagrange
f = @(x) (x + (1 / (x * x)));
lim = [1 2];
eps = 0.01;
gamm = 0.0001;
N = 100;
optLim = Lagrange(f, lim, eps, gamm, N);

figure
ezplot(f)

xlim(lim)
ylim('auto')

f(optLim)

hold on
plot(optLim, f(optLim), 'ro')
hold off