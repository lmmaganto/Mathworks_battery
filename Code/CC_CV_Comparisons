%% 
% _Constant Current-Constant Voltage Comparisons_
% 
% The final section of this project compared Constant Current (CC) and Constant 
% Voltage (CV) charging models. The model illustrates how much energy is delivered, 
% and how long it takes to charge the same battery given CC or CV conditions.

Vmax = 4.2;       
R = 0.07;        
RC = 3200;      
C = RC / R;      
I_const = 2;      
T_end = 7200;    
t = linspace(0, T_end, 1000); 

V_target = 0.99 * Vmax;

V_CC = I_const * R + (I_const / C) * t;
V_CC(V_CC > Vmax) = Vmax;
I_CC = I_const * ones(size(t));

t_CC_end = min(C * (V_target - I_const * R) / I_const, T_end);

E_CC = integral(@(t) I_const .* (I_const * R + I_const * t / C), 0, t_CC_end);

I_CV = @(t) (Vmax / R) * exp(-t / (R * C));
V_CV = Vmax * ones(size(t));

I_threshold = 0.05;  
t_CV_end = -log(I_threshold * R / Vmax) * (R * C);
t_CV_end = min(t_CV_end, T_end); 

E_CV = integral(@(t) Vmax .* I_CV(t), 0, t_CV_end);

figure;
plot(t/60, V_CC, 'r', 'LineWidth', 2); hold on;
plot(t/60, V_CV, 'b--', 'LineWidth', 2);
xlabel('Time (minutes)');
ylabel('Voltage (V)');
title('Voltage vs. Time: CC vs. CV Charging');
legend('Constant Current (CC)', 'Constant Voltage (CV)');
grid on;

I_CV_vals = I_CV(t);
figure;
plot(t/60, I_CC, 'r', 'LineWidth', 2); hold on;
plot(t/60, I_CV_vals, 'b--', 'LineWidth', 2);
xlabel('Time (minutes)');
ylabel('Current (A)');
title('Current vs. Time: CC vs. CV Charging');
legend('Constant Current (CC)', 'Constant Voltage (CV)');
grid on;

fprintf('\nCharging Summary:\n');

fprintf('Constant Current (CC):\n');
fprintf('Charging Time: %.1f minutes\n', t_CC_end / 60);
fprintf('Energy Delivered: %.2f J\n', E_CC);

fprintf('\nConstant Voltage (CV):\n');
fprintf('Charging Time (to %.2f A): %.1f minutes\n', I_threshold, t_CV_end / 60);
fprintf('Energy Delivered: %.2f J\n', E_CV);
