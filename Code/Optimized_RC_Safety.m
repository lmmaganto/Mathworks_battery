Optimized Charging With Safety Limits
    This section opens up further user input to optimize the previous battery charging profile.  
    Change the sliders for Resistance and the TIme Constant (RC0) to see how the charging ccurve changes. Get feedback as to how optimized your values are. 
    (Hint: To optimize battery charging, try setting resistance at around 2 Ohms, and RC0 at around 1000 seconds)
R = 2.1;    
RC0 = 1000;   

Vmax = 4.2;          
C = RC0 / R;         
T_end = 18000;       

t = linspace(0, T_end, 1000);
V = Vmax * (1 - exp(-t / (R * C)));

figure;
plot(t / 60, V, 'b', 'LineWidth', 2);
xlabel('Time (minutes)');
ylabel('Voltage (V)');
title('Voltage vs. Time for Chosen R and RC0');
grid on;

V_target = 0.90 * Vmax;  
I_max = 2.6;              

charging_time = @(RC) -log(1 - V_target / Vmax) * RC;
obj = @(RC) charging_time(RC);

if Vmax / R > I_max
    fprintf('Current exceeds safety limit at t=0: %.2f A > %.2f A\n', Vmax/R, I_max);
    feasible = false;
else
    feasible = true;
end

if feasible
    options = optimoptions('fmincon', 'Display', 'off');
    [RC_opt, T_opt] = fmincon(obj, RC0, [], [], [], [], 1000, 20000, [], options);
    
    fprintf('Optimized RC: %.2f seconds\n', RC_opt);
    fprintf('Time to reach 90%% of Vmax: %.2f seconds (%.2f min)\n', T_opt, T_opt/60);

    user_time = charging_time(RC0);
    efficiency_ratio = T_opt / user_time;
    
    if abs(efficiency_ratio - 1) < 0.05
        fprintf('Your chosen RC (%.0f) is near-optimal for fast charging.\n', RC0);
    elseif efficiency_ratio < 1
        fprintf('Your RC0 is higher than optimal. Try reducing RC0 for faster charging.\n');
    else
        fprintf('Your RC0 is lower than optimal. Try increasing RC0 for better battery protection.\n');
    end
end