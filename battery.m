%modeling and optimizing a battery charging profile

%parameters 
Vmax = 4.2;
R=.07;
I = .52;
RC = 2237; %derived from the v(t) equation and used v(t) = 3.36 80% charged


% for step 2 using v(t) = vmax(1-e^(t/RC) to model battery over time

t_hours = 0:0.1:3; %found that it took 2.86 hours for battery to reach 99%
t_seconds = t_hours *3600;

V = Vmax *(1-exp(-t_seconds/RC));
figure(1);
plot(t_hours,V, 'LineWidth',2);
hold on 
yline(3.36,'--r', '80% charge') %took 1 hour
yline(4.2,'--g', '100% charge') %took 2.86 hour
xlabel('Time(Hours)')
ylabel('Voltage (V)')
title('Voltage Over time')
grid on;
hold off;

% step 3 finding voltage curve
dVdt= gradient(V,t_seconds);
figure(2);
plot(t_seconds,dVdt*1000,'LineWidth',2);
xlabel('Time (seconds)')
ylabel('dV/dt (mV/s)')
title('Rate of Voltage Change')
grid on;

%step 5 part 1 rate of voltage change at different intervals 

initial_rate = dVdt(1) *1000; 
mid_charge_time = 1*3600; %t = 1 hour
[~, mid_idx,] = min(abs(t_seconds-mid_charge_time));
mid_rate = dVdt(mid_idx) * 1000; %getting the rate

near_full_time = 2.5 * 3600; % t= 2.5 hours
[~,near_full_idx] = min(abs(t_seconds - near_full_time));
near_full_rate = dVdt(near_full_idx) * 1000;

fprintf('Initial dV/dt: %.4f mV/s\n', initial_rate);
fprintf('dV/dt at 1 hour: %.4f mV/s\n', mid_rate);
fprintf('dV/dt at 2.5 hours: %.4f mV/s\n', near_full_rate);
fprintf('The ')

%step 4 compute energy delievered 

P = V*I;

%cross validation 
energy_trap = trapz(t_seconds,P);
fprintf('Energy (trapz): %.2f J\n', energy_trap);

P_func = @(t) Vmax*I*(1-exp(-t/RC));
energy_integral= integral(P_func,0,3*3600);
fprintf('Energy(integral): %.2f J\n', energy_integral)


%step 5.2 time to reach 80% 10 100% charge
% Find time when V reaches 80% and 100% of Vmax
V_target_80 = 0.8 * Vmax;
V_target_100 = 0.99 * Vmax; % Practically, it never reaches 100%, so use 99%

[~, idx_80] = min(abs(V - V_target_80));
time_80_hours = t_seconds(idx_80) / 3600;

[~, idx_100] = min(abs(V - V_target_100));
time_100_hours = t_seconds(idx_100) / 3600;

fprintf('Time to reach 80%% charge: %.2f hours\n', time_80_hours);
fprintf('Time to reach 99%% charge: %.2f hours\n', time_100_hours);

%step 5.3 energy lost due to resistence



%isnt right fix this
%energy vs time
figure(4);
plot(t_hours, P, 'k-', 'LineWidth',2);
xlabel('Time(hours)')
ylabel('Power (W)')
title('Power Delivered vs Time')
grid on;



