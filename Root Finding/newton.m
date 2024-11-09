function Newtons_method()
    f = @(x) x^3 - 4*x^2 + x + 6;
    dfdx = @(x) 3*x^2 - 8*x + 1;
    eps = 1e-6;
    x0 = 5;
    [solution, no_iterations, x_values, delta_values] = Newton(f, dfdx, x0, eps);

    if no_iterations > 0
        fprintf('Number of function calls: %d\n', 1 + 2*no_iterations);
        fprintf('A solution is: %f\n', solution);

        figure;
        subplot(2,1,1);
        plot(0:no_iterations, x_values, '-o');
        xlabel('Iteration');
        ylabel('x value');
        title('Convergence of Newtons Method');
        grid on;

        subplot(2,1,2);
        plot(1:no_iterations, delta_values, '-o');
        xlabel('Iteration');
        ylabel('f(x)/dfdx(x) value');
        title('Values of f(x)/dfdx(x) at Each Iteration');
        grid on;
    else
        fprintf('Abort execution.\n');
    end
end

function [solution, no_iterations, x_values, delta_values] = Newton(f, dfdx, x0, eps)
    x = x0;
    f_value = f(x);
    iteration_counter = 0;
    x_values = x;
    delta_values = [];

    while abs(f_value) > eps && iteration_counter < 100
        delta = f_value / dfdx(x);
        x = x - delta;

        f_value = f(x);
        iteration_counter = iteration_counter + 1;
        x_values(end+1) = x;
        delta_values(end+1) = delta;
    end

    if abs(f_value) > eps
        iteration_counter = -1;
    end

    solution = x;
    no_iterations = iteration_counter;
end
