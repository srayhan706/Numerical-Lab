% Task 1: Find the interpolating polynomial using Newton's Divided-Difference method.

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

% Calculate the coefficients
coeff = divided_differences(time, temp);

% Display Results
disp('Divided Difference Coefficients:');
disp(coeff);
