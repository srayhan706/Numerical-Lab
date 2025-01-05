% Task 3: Plot the polynomial and overlay the original data points.

% Given Data
time = [0, 6, 12, 18, 24]; % Time in hours
temp = [15, 10, 20, 25, 18]; % Temperature in °C

% Function to calculate the divided differences
function coeff = divided_differences(x, y)
    n = length(x);
    table = zeros(n, n);
    table(:, 1) = y(:); % First column is y
    for j = 2:n
        for i = 1:n-j+1
            table(i, j) = (table(i+1, j-1) - table(i, j-1)) / (x(i+j-1) - x(i));
        end
    end
    coeff = table(1, :); % Extracting the coefficients
end

% Function to evaluate Newton's Polynomial
function y = newton_polynomial(coeff, x_data, x_eval)
    n = length(coeff);
    y = coeff(1) * ones(size(x_eval));
    for i = 2:n
        term = coeff(i);
        for j = 1:i-1
            term = term .* (x_eval - x_data(j));
        end
        y = y + term;
    end
end

% Step 1: Compute Divided Difference Coefficients
coeff = divided_differences(time, temp);

% Step 2: Generate Data for Plotting
t_range = linspace(0, 24, 100); % Fine range for plotting
interp_temps = newton_polynomial(coeff, time, t_range);

% Step 3: Plot the Results
figure;
plot(t_range, interp_temps, 'b-', 'LineWidth', 2); % Polynomial curve
hold on;
plot(time, temp, 'ro', 'MarkerSize', 8, 'MarkerFaceColor', 'r'); % Original points
title('Interpolating Polynomial for Temperature Data');
xlabel('Time (hours)');
ylabel('Temperature (°C)');
legend('Interpolating Polynomial', 'Original Data Points');
grid on;

% Display Coefficients for Reference
disp('Divided Difference Coefficients:');
disp(coeff);
