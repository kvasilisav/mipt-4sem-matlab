x = linspace(-pi/2, pi/2, 1000);
y = ( (sin(0.1 .* x) ./ x) .* (sin(20 .* x) ./ sin(x)) ) .^ 2;

figure;
hold on;
grid on;
plot(x, y, '.-');
