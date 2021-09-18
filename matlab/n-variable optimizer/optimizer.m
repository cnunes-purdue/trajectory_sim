function [points, optimal] = optimizer(initial_guess, step_size)
disp('test1')
persistent isSetup
persistent in
global motor1
global stage2IgnitionAlt
global motor2
if isempty(isSetup)
    isSetup = true;
    modelName = 'optimizeTest1Sim';
    load_system(modelName)
    mdl = modelName;
    in = Simulink.SimulationInput(mdl);
end
disp('test2')
% points(1, 1) = initial_guess(1);
% points(1, 2) = initial_guess(2);
% points(1, 3) = testfunc_single(points(1, 1), points(1, 2));

var_count = length(initial_guess);

points = zeros(1, var_count + 1);
for i = 1:var_count
    points(1, i) = initial_guess(i);
end

motor1.nozzle.exit = points(1, 1);
stage2IgnitionAlt = points(1, 2);
motor2.nozzle.exit = points(1, 3);
disp('test3')
out = sim(in);

points(1, var_count + 1) = max(out.position);
disp(max(out.position))
disp('test4')

% 
% hx = step_size(1);
% hy = step_size(2);
% h = sqrt(hx^2 + hy^2);

h = sqrt(sum(step_size.^2));
z_change = 10;
counter = 1;
disp('test5')

scale_vect = [1e5, 10, 1e5];
while abs(z_change) > 1
    
%     xi_n = points(counter, 1);
%     yi_n = points(counter, 2);
%     
%     diff_x = testfunc_single(xi_n + hx, yi_n) - testfunc_single(xi_n, yi_n);
%     diff_y = testfunc_single(xi_n, yi_n + hy) - testfunc_single(xi_n, yi_n);
    
    diff_vect = zeros(1,var_count);
    current_val = points(counter, end);
    time_scale = [(floor(counter/4) + 1)^(1/4), sqrt(floor(counter/4) + 1),(floor(counter/4) + 1)^(1/4)];
    
    disp('test6')
    for i = 1:var_count
        temp_step = zeros(1,var_count);
        temp_step(i) = step_size(i);
        stepped_vect = zeros(1,var_count);
        for j = 1:var_count
            stepped_vect(j) = points(counter, j) + temp_step(j);
        end
        disp(step_size(i))
        disp(stepped_vect(i))
        motor1.nozzle.exit = stepped_vect(1);
        stage2IgnitionAlt = stepped_vect(2);
        motor2.nozzle.exit = stepped_vect(3);
        out = sim(in);
        disp(max(out.position))
        disp(max(out.position) - current_val)
        diff_vect(i) = (max(out.position) - current_val)/(scale_vect(i) * time_scale(i));
    end
    disp('test7')
%   
%     xi_n1 = xi_n + diff_x / (h * counter);
%     yi_n1 = yi_n + diff_y / (h * counter);
% 
%     z_change = testfunc_single(xi_n1, yi_n1) - testfunc_single(xi_n, yi_n);
%     counter = counter + 1;
%     points(counter, 1) = xi_n1;
%     points(counter, 2) = yi_n1;
%     points(counter, 3) = testfunc_single(points(counter, 1), points(counter, 2));

    counter = counter + 1;
    points(counter, 1:end-1) = points(counter - 1,1:end-1) + diff_vect;
    motor1.nozzle.exit = points(counter, 1);
    stage2IgnitionAlt = points(counter, 2);
    motor2.nozzle.exit = points(counter, 3);
    disp('test8')
    out = sim(in);
    disp('test9')
    disp(max(out.position))
    points(counter, end) = max(out.position);
    z_change = points(counter, end) - points(counter - 1, end);
    disp('test10')
    disp(z_change)
    writematrix(points, 'points.csv');
    
end

optimal = points(end, :);
end

