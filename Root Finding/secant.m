function secant_method()
    f = @(x) x^3 - 4*x^2 + x + 6;
    eps = 1e-6;
    x0 = 5;
    x1 = x0 - 1;
    [solution, no_iterations,x_values, delta_values] = secant(f, x0, x1, eps);

    if no_iterations > 0
        fprintf('Number of function calls: %d\n', 2 + no_iterations);
        fprintf('A solution is: %f\n', solution);

        figure;
        subplot(2,1,1);
        plot(1:no_iterations, delta_values, '-o');
        xlabel('Iteration');
        ylabel('f(x1)/denominator value');
        title('Values of f(x1)/denominator at Each Iteration in Secant Method');
        grid on;

    else
        fprintf('Abort execution.\n');
    end
end

function [solution, no_iterations,x_values, delta_values] = secant(f, x0, x1, eps)
    f_x0 = f(x0);
    f_x1 = f(x1);
    x_values = x0;
    x_values(end+1) = x1;
    iteration_counter = 0;
    delta_values = [];

    while abs(f_x1) > eps && iteration_counter < 100
        denominator = (f_x1 - f_x0) / (x1 - x0);
        if denominator == 0
            fprintf('Error! - denominator zero for x = %f\n', x1);
            break;
        end

        delta = f_x1 / denominator;
        x = x1 - delta;

        delta_values(end + 1) = delta;
        x_values(end+1) = x;

        x0 = x1;
        x1 = x;
        f_x0 = f_x1;
        f_x1 = f(x1);
        iteration_counter = iteration_counter + 1;
    end

    if abs(f_x1) > eps
        iteration_counter = -1;
    end

    solution = x1;
    no_iterations = iteration_counter;
end
