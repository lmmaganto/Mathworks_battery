# **Modeling and Optimizing a Battery Charging Profile**

This is the work of _Marc Ajay Rajesh, Karthik Chennimalai Ganesh, Louise Marie Maganto, Atanacia Sanchez_ in applying our knowledge of electric circuits, energy transfers, and calculus to model charging behavior and evaluate efficiency in a Lithium Ion battery charging profile.
Our dataset comes from [dataset](Dataset/Lithium_Ion_Battery.pdf)


Within this project we 

## Model Battery Voltage Over time 
This first section of [code](Code/Model_battery_Voltage) visualizes the voltage response of a simple RC (resistor-capacitor) charging
circuit over time, using user-defined inputs for maximum voltage (Vmax1), resistance (R1), and
capacitance (C1). These inputs are intended to be controlled via sliders in an interactive environment. The
voltage is calculated using the standard charging equation V(t)=Vmax(1-e
-t/RC
), and the simulation time
spans from 0 to 10 hours. The computed voltage values are plotted as a smooth curve, showing how the
voltage rises and asymptotically approaches Vmax1 over time, depending on the RC time constant. The
resulting plot includes labeled axes, a title, a legend, and a grid for readability. This [visualization](Media/Figure_1.jpg) provides
a clear and interactive way to understand how RC circuits behave during the charging process.

 
## Fit the Voltage Curve
The next portion of [code](Code/Model_battery_Voltage) simulates and visualizes the voltage curve of a lithium battery charging through
an RC circuit, allowing users to select a target charge percentage (desired_pct) via a slider. The battery
parameters: maximum voltage (Vmax2), resistance (R2), and RC time constant (RC2) are used to
compute the capacitance (C2) and generate the voltage curve V(t)=Vmax(1-e
-t/RC
) over a time range of 0
to 5 hours. The user-specified charge percentage is validated to stay within realistic bounds (0–100%,
non-inclusive), and the time to reach that voltage is calculated analytically. The resulting plot displays the
charging curve and highlights the point in time where the battery reaches the desired percentage. See the plot at [80%](Media/RC_Battery.jpg) and [100%](Media/RC_Battery_100.jpg) respectively. Axis
labels, a title, grid lines, and a dynamic legend provide a clear and informative visualization. This block is
ideal for demonstrating how charging time varies with different target charge levels in lithium-ion battery
systems
## Compute Total Energy Delivered to the Battery
Our next block of [code](Code/Energy_delivered) calculates and visualizes the instantaneous power delivered to a battery during RC
charging over time. It defines a power function P(t) as the product of voltage and current in an RC circuit,
using the expressions for both as functions of time. The power values are evaluated across a time range
from 0 to 18,000 seconds and plotted to show how power delivery changes during the charging process.
The [graph](Media/Power_vs_Time.jpg) includes labeled axes, a title, grid, and legend for clarity. Additionally, the code computes the
total energy delivered to the battery by integrating the power function over the full charging period and
outputs the result in joules. This block provides insight into the dynamic power behavior and energy
transfer during RC-based battery charging
## Analyze the Rate of Voltage Change at Different Intervals 
This [code](Code/voltage_different_intervals) analyzes the rate of voltage change (dV/dt) during RC battery charging and breaks it down into
user-defined voltage intervals, controlled by a percentage slider (interval_pct). It computes the voltage
curve V(t) and its gradient dV/dt to approximate the charging current over time. The result is visualized in
a [plot] (Media/current_vs_time.jpg) that shows how the current decreases as the battery charges. The code then divides the voltage
range (0%–100% of Vmax) into equal intervals and calculates the average dV/dt within each range. These
averages are printed to the console, offering insight into how charging speed varies across different
voltage levels. This block is useful for understanding current behavior and efficiency throughout the
charge cycle.
## Analyze the Energy Lost Due to Resistance
The next section of [code](Code/Energy_lost_resistence) calculates and visualizes the power lost due to internal resistance during the
charging of an RC battery. It defines the time-dependent current I(t) and computes power loss as
P(t)=I(t)^2*R, representing resistive heating. The total energy lost over the entire charging duration
(T_end) is calculated using numerical integration and printed in joules. A [plot](Media/Power_lost_over_time.jpg) is then generated showing
how resistive power loss decreases over time, with labeled axes, a title, legend, and grid for clarity. This
block provides a clear view of inefficiencies in the charging process due to resistive losses in the circuit.
## Introduce Temperature Effects into the model

## Compare Constant Current-Constant Voltage (CC-CV)


<ins>To see the whole live script of our project make sure to have MatLab downloaded and click [view raw](Code/LiveScript_Matlab_Internship.mlx) </ins>
