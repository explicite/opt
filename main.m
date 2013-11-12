%import from fun folder
import fun.fibonacciOpt
import fun.lagrangeOpt

%Examples

%Fibonacci
f = @(x) (6 * x - 2) * (6 * x - 2) * sin(12 * x - 4);
lim = [0 1];
eps = 0.001;
optLim = fibonacciOpt(f, lim, eps);

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
optLim = lagrangeOpt(f, lim, eps, gamm, N);

figure
ezplot(f)

xlim(lim)
ylim('auto')

f(optLim)

hold on
plot(optLim, f(optLim), 'ro')
hold off