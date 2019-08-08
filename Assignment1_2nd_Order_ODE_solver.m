function [SHM] = MEGN502_ODE_Assignment1_F2017
%
%%  MEGN502 ODE Assignment 1 Fall 2017: 
%        Simple harmonic motion of a mass suspended by a spring.
%        by Nicole Thomas -- September 5, 2017
%
%  A mass is suspended from a spring which is fixed on the other end. This
%    differential equation governs the position (x) of the mass as a 
%    function of the time (t).

%A large capacitor in series with a resistive and inductive feed line is charged
%     by a voltage with a DC voltage that has oscillatory noise at 60 Hz.
%     Solve a differential equation that governs the current (i)
%     as a function of time (t) and then calculate the voltage as a 
%     function of time.  Assume that the resistance (R) and the 
%     capacitance (C) are constant.  The excitation voltage can be
%     written as E (t) = E_0 + E_1*sin(omega*t).  The initial current 
%     i_0 = E_0/R
%%
%Set up the differential equation for how the position varies with time.
%    
%   mass*d^2x/dt^2 + k*x =0

%  The analytical solution can be derived from the characteristics as shown
%  in the analytical function below
%
%%
%  Set the circuit properties
%
SHM.mass = 5.0;                   % mass of the object (kg)
SHM.k = 1;                        % spring constant (N/m)
SHM.omega = sqrt(SHM.k/SHM.mass)    %omega 
%%
%  Set the initial conditions for the spring/mass system
%
SHM.x_0 = -0.01;               % initial position (m)
%SHM.E_1 = 0.5;                 % amplitude of oscillatory voltage in V
%SHM.omega = 2*pi()*60;    % angular frequency in 1/s
%SHM.i_0  = SHM.E_0/SHM.R;  % initial current in A
%%
%  Establish initial condition at t = 0 for x = -0.01 and dx/dt = 0
x_0(1,1) = -0.01;
x_0(2,1) = 0;

%%
%  Set up the time span ode solver tolerances, and max timestep to capture sinusoid.
t_span =(0:0.0001:1);
options = odeset('RelTol',1e-5,'AbsTol',1e-5);
%options.MaxTimeStep = 0.0001/SHM.omega;
%%
%   Run the numerical ode integrator for a numerical differential equation
%      and set numerical solution in x_numerical 
[t, x] = ode23(@(t, x) dxdt_numerical(t, x, SHM), t_span, x_0, options);
SHM.x_numerical = x(:,1);
%%
%  For the analytical solution, first calculate the particular solution 
%      to the non-homogeneous equation which has the form,
%
%         x_p = alpha*cos(omega*t))+beta*omega^-1*sin(omega*t)
%
%       where alpha = A_p(1) and beta*omega^-1 = A_p(2)
%
%      Since we set up the homogeneous solution to satisfy the initial
%      conditions we should set i_p_0 = 0 and didt_p = 0 so that the combined
%      condition satisfies the boundary conditions/
%      The two constants A_1 & A_2 must satisfy the following equations
%         sin(omega*t) terms:   -A_2*omega^2*L - A_1*R*omega + A_2/C = 0
%         cos(omega*t) terms:   -A_1*omega^2*L + A_2*R*omega + A_1/C = E_1*omega
%
%  These equations are solved in a matrix equatiion of the form A =inv(M)*b.

M_p = [0,  (SHM.k/SHM.mass - SHM.omega^2); ...
     (SHM.k/SHM.mass - SHM.omega^2), 0];
b_p = [0; 0];
A_p = M_p\b_p;
x_analytical_p = A_p(1)*cos(SHM.omega*t) + A_p(2)*sin(SHM.omega*t);
x_p_0(1,1) = A_p(1);
x_p_0(2,1) = A_p(2)*SHM.omega;
%%
%  Call function to calculate the analytical solution to the homogeneous
%     equation and add it to the particular solution to get the whole
%     solution.  The initial conditions for the homogeneous solution 
%     should be the total solution initial conditions minus the initial conditions
%     for the particular solution.

x_analytical_h =  x_analytical(t, (x_0(1,1)-x_p_0(1,1)), (x_0(2,1)-x_p_0(2,1)), ...
                                  SHM.mass, 0, SHM.k);
SHM.x_analytical = x_analytical_h;          

%x_analytical_h =  i_analytical(t, (x_0(1,1)-i_p_0(1,1)), (x_0(2,1)-i_p_0(2,1)), ...
 %                                 SHM.L, SHM.R, 1/SHM.C);
%SHM.x_analytical = i_analytical_p + x_analytical_h;                            
%
%
%% Plot the numerical and analytical position profile as a function of x for all times
close all
SHM.t = t;
p = plot (SHM.t, SHM.x_numerical,SHM.t, SHM.x_analytical);
hold on
xlabel('time (s)');
ylabel('position (m)');
set(p(1),'linewidth',2);
set(p(2),'linewidth',2);
legend('x_{numerical}','x_{analytical}')

figure   
p = plot (SHM.t, SHM.x_numerical - SHM.x_analytical);
xlabel('time (s)');
ylabel('position difference (m)');
p.LineWidth = 2;
legend('x_{numerical} - x_{analytical}')
end
%%
% This function sets up equations for the first derivative of current
%  for an RC circuit.
%
function dx_dt = dxdt_numerical(t, y, SHM)
%
% dV/dt balance is a basis for establishing the equation for dx/dt
%
%  didt = -i(t)/(circuit.RC) + circuit.E_1*circuit.omega*cos(circuit.omega*t);
%
dx_dt(1,1) = y(2,1);
dx_dt(2,1) = y(2,1) - SHM.k*y(1,1)/(SHM.mass) ...
    + SHM.omega*cos(SHM.omega*t);
%
end
%%
%  This function gets the analytical solution for homogeneous equation of the form
%              a*d^2y/dt^2 + b*dy/dt + c*y = 0 
%       with the.initial conditions y(t=0) = y_0 and dy/dt(t=0) = dydt_0.
%     
function y_h = x_analytical(t, y_0, dydt_0, a, b, c)
%%
%  Calculate the analytical solution for the non-homogeneous ODE that governs RLC circuit
%  by first determining the discriminant (b^2-4ac) of the characteristic
%  polynomial.
%
discrim = b^2-4*a*c;
%%
%   Find the roots for overdamped case which has the solution to the
%   homogenous equation of the form i(t) = c_1*exp(lambda_1*t) +
%   c_2*exp(lambda_2*t))
if discrim > 0
    lambda_1 = (- b + sqrt(discrim))/(2*a);
    lambda_2 = (- b - sqrt(discrim))/(2*a);
    c_1 = (dydt_0 - y_0*lambda_2)/(lambda_1 - lambda_2);
    c_2 = (dydt_0 - y_0*lambda_1)/(lambda_2 - lambda_1);
    y_h = c_1*exp(lambda_1*t) + c_2*exp(lambda_2*t);
%%
%   Find the roots for underdamped case which has the solution to the
%   homogenous equation of the form i(t) = exp(u_1*t)*(c_1*cos(v_1*t) + c_2*sin(v_1*t))
elseif discrim < 0
    u_1 = - b/(2*a);
    v_1 = sqrt(-discrim)/(2*a);
    c_1 = y_0;
    c_2 = (dydt_0 - y_0*u_1)/v_1;
    y_h = exp(u_1*t).*(c_1*cos(v_1*t)+ c_2*sin(v_1*t));
%%
%   Find the roots for the critically damped case which has the solution to the
%   homogenous equation of the form i(t) = exp(lambda_1*t)*(c_1 + c_2*t)
else
    lambda_1 = - b/(2*a);
    c_1 = y_0;
    c_2 = (didt_0 - y_0*lambda_1);
    y_h = exp(lambda_1*t).*(c_1 + c_2*t);
end
end