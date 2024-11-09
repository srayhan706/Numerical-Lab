function bisection_method()
    f = @(x) x^3 - 4*x^2 + x + 6;
    eps = 1e-6;
    a = -2;
    b = 4;
    [solution, no_iterations, x_values] = bisection(f, a, b, eps);

    if solution <= b   % Solution found
        fprintf('Number of function calls: %d\n', 1 + 2 * no_iterations);
        fprintf('A solution is: %f\n', solution);

        % Plot x values vs iteration
        figure;
        plot(1:no_iterations, x_values, '-o');
        xlabel('Iteration');
        ylabel('x Value');
        title('Bisection Method: x Value vs Iteration');
        grid on;
    else
        fprintf('Abort execution.\n');
    end
end

function [result1, result2, x_values] = bisection(f, x_L, x_R, eps)
    if f(x_L) * f(x_R) > 0
        fprintf('Error! Function does not have opposite signs at interval endpoints!\n');
        return;
    end

    x_M = (x_L + x_R) / 2.0;
    f_M = f(x_M);
    iteration_counter = 1;
    x_values = x_M;  % Store initial midpoint

    while abs(f_M) > eps
        left_f = f(x_L);
        right_f = f(x_R);

        if left_f * f_M > 0   % Same sign
            x_L = x_M;
        else
            x_R = x_M;
        end

        x_M = (x_L + x_R) / 2;
        f_M = f(x_M);
        iteration_counter = iteration_counter + 1;

        % Store each midpoint x_M
        x_values = [x_values, x_M];
    end

    result1 = x_M;
    result2 = iteration_counter;
end
