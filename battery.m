%modeling and optimizing a battery charging profile

%parameters
Vmax = 4.2;
R=.07;
I = .52; %CC current
RC = 3600;

% for step 2 using v(t) = vmax(1-e^(t/RC) to model battery over time

t_hours = 0:0.1:5;
t_seconds = t_hours *3600;

V = Vmax *(1-exp(-t_seconds/RC));
figure(1);
plot(t_hours,V, 'LineWidth',2);
hold on
yline(3.36,'--r','80%');
yline(4.2,'--g','99%');

xlabel('Time(Hours)')
ylabel('Voltage (V)')
title('Voltage Over time')
grid on;
legend('Voltage', '1.6 hours (80%)', '4.6 hours (99%)','Location','southeast');
hold off;

% step 3 finding voltage curve
dVdt= gradient(V,t_seconds);
figure(2);
plot(t_seconds/3600,dVdt*1000,'LineWidth',2);
xlabel('Time (Hours)')
ylabel('dV/dt (mV/s)')
title('Rate of Voltage Change')
grid on;

%step 4 compute energy delievered

P = V*I;

%cross validation
energy_trap = trapz(t_seconds,P);
fprintf('Total energy delivered to the battery (trapz): %.2f J\n', energy_trap);

%analystic integration
P_func = @(t) Vmax*I*(1-exp(-t/RC));
energy_integral= integral(P_func,0,5*3600);
fprintf('Total energy delivered to the battery (integral): %.2f J\n', energy_integral)

%step 5 part 1 rate of voltage change at different intervals

initial_rate = dVdt(1) *1000;  %at t=0 (mV/s)

mid_charge_time = 1.6*3600; %t = 1.6 hours
[~, mid_idx,] = min(abs(t_seconds-mid_charge_time));
mid_rate = dVdt(mid_idx) * 1000; %getting the rate

near_full_time = 4.6 * 3600; % t= 2.5 hours
[~,near_full_idx] = min(abs(t_seconds - near_full_time));
near_full_rate = dVdt(near_full_idx) * 1000;

fprintf('--- Rate of Voltage Change (dV/dt) ---\n');
fprintf('Initial dV/dt: %.4f mV/s\n', initial_rate);
fprintf('dV/dt at 1.6 hour: %.4f mV/s\n', mid_rate);
fprintf('dV/dt at 4.6 hours: %.4f mV/s\n', near_full_rate);

%step 5.2 time to reach 80% 10 100% charge
V_target_80 = 0.8 * Vmax;
V_target_100 = 0.99 * Vmax; % Practically, it never reaches 100%, so use 99%

[~, idx_80] = min(abs(V - V_target_80));
time_80_hours = t_seconds(idx_80) / 3600;

[~, idx_100] = min(abs(V - V_target_100));
time_100_hours = t_seconds(idx_100) / 3600;

fprintf('Time to reach 80%% charge: %.2f hours\n', time_80_hours);
fprintf('Time to reach 99%% charge: %.2f hours\n', time_100_hours);

%step 5.3 energy lost due to resistence
P_loss = I^2*R;
%total energy loss in the 5 hours
E_loss = P_loss*max(t_seconds);
%energy delivered analytic needs to fix these bottom two
E_delivered = trapz(t_seconds,P);
efficiency = E_delivered/(E_delivered + E_loss)*100;

fprintf('Power lost in resistance: %.4f W\n', P_loss);
fprintf('Energy lost due to resistance: %.2f J\n', E_loss);
fprintf('Energy delivered to battery: %.2f J\n', E_delivered);
fprintf('Charging efficiency: %.1f%%\n', efficiency);

%step 6 
%current vs time
I_CC= I * ones(size(t_hours));  % Always 0.52A
figure(3);
plot(t_hours, I_CC, 'r', 'LineWidth', 2);
xlabel('Time (Hours)');
ylabel('Current (A)');
title('Current vs. Time (Pure CC Charging)');
grid on;

%power vs time
figure(4);
plot(t_hours, P, 'k', 'LineWidth', 2);
hold on;
xlabel('Time (Hours)');
ylabel('Power (W)');
title('Power vs. Time (CC Charging)');
grid on;
legend('Power', '80% Charge', '99% Charge', 'Location', 'southeast');
hold off;