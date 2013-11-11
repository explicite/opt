%import from fun folder
import fun.fibonacciOpt


%fibonacci example
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