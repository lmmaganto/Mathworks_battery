Adding Temperature Constraints and Non-Ideal Behaviour
    This section of our project incorporates temperature into the battery charging profile, and shows how a temperature difference can inhibit charging, and cause things like thermal runaway.
    Input a temperature (in Celcius) below, which changes the Temperature-Adjusted Charging Curve
user_temp_C = 25; 

if user_temp_C < 0
    warning('Temperature too low! Battery charging may be unsafe or ineffective.');
elseif user_temp_C > 60
    warning('Temperature too high! Risk of battery degradation or thermal runaway!');
end

R_base = 0.07;    
temp_coeff = 0.004;  

delta_T = user_temp_C - 25;
R_temp = R_base * (1 + temp_coeff * delta_T);

RC0 = 2237;     
C_temp = RC0 / R_temp;

T_end = 18000;   
t = linspace(0, T_end, 1000);

Vmax = 4.2; 
V_temp = Vmax * (1 - exp(-t / (R_temp * C_temp)));

I0_temp = Vmax / R_temp;

figure;
plot(t / 60, V_temp, 'b-', 'LineWidth', 2);
xlabel('Time (minutes)');
ylabel('Voltage (V)');
title(sprintf('Temperature-Adjusted Charging Curve at %.1f°C', user_temp_C));
grid on;
legend(sprintf('R = %.4f Ω, I(0) = %.2f A', R_temp, I0_temp), 'Location', 'southeast');

fprintf('\nAdjusted Resistance: %.4f Ω\n', R_temp);
fprintf('Initial Current at %.1f°C: %.2f A\n', user_temp_C, I0_temp);
fprintf('Charging Time Constant: %.2f s\n', R_temp * C_temp);