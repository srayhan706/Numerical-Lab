% Data
time = [0, 6, 12, 18, 24];         % Hours
temperature = [15, 10, 20, 25, 18]; % Temperature in °C

% Number of data points
n = length(time);

% Step 1: Divided Differences Table
div_diff = zeros(n, n);
div_diff(:, 1) = temperature'; % First column is the temperatures

% Fill the divided differences table
for j = 2:n
    for i = 1:(n-j+1)
        div_diff(i, j) = (div_diff(i+1, j-1) - div_diff(i, j-1)) / (time(i+j-1) - time(i));
    end
end

% Extract the coefficients
coeff = div_diff(1, :);

% Step 2: Newton's Polynomial Function
function p = newton_poly(coeff, time, x)
    n = length(coeff);
    p = coeff(1);
    term = 1;
    for i = 2:n
        term = term .* (x - time(i-1));
        p = p + coeff(i) * term;
    end
end

% Evaluate the polynomial at specific times
eval_times = [3, 9, 21]; % Times at which we need temperature estimates
estimated_temps = arrayfun(@(x) newton_poly(coeff, time, x), eval_times);

% Display the estimated temperatures
disp('Estimated Temperatures:');
disp([eval_times; estimated_temps]);

% Step 3: Plot the Polynomial
x_range = 0:0.1:24; % Fine range for plotting
y_values = arrayfun(@(x) newton_poly(coeff, time, x), x_range);

% Plot
figure;
plot(time, temperature, 'ro', 'MarkerSize', 8, 'LineWidth', 2); hold on; % Original data points
plot(x_range, y_values, 'b-', 'LineWidth', 2); % Interpolated polynomial
xlabel('Time (hours)');
ylabel('Temperature (°C)');
title('Temperature Interpolation using Newton’s Divided-Difference Method');
legend('Data Points', 'Interpolated Polynomial');
grid on;

