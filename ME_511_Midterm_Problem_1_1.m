%ME 511 Midterm Problem 1 Function 
%Nicole Thomas
clear all 
close all
clc

b = 8;
x= 1;
sigma_ys = 40 + 2*x; %yield stress in ksi

data_x = [];
data_y = [];
data_x_p = [];
data_y_p = [];
theta = linspace(0,2*pi()); 
P = 335; %Applied load in kips

for i=1:length(theta)
    fun = @(r) f(theta(i),r); % function
    r0 = 1; % initial point
    r = fzero(fun,r0);
    x= r*cos(theta(i));
    y = r*sin(theta(i));
    data_x = [data_x; x];
    data_y = [data_y; y];
    
    r_p = (1/(2*b))*((P/(pi()*sigma_ys))^2)*(1+cos(theta(i))+1.5*(sin(theta(i)))^2);
    x_p= r_p*cos(theta(i));
    y_p = r_p*sin(theta(i));
    data_x_p = [data_x_p; x_p];
    data_y_p = [data_y_p; y_p];
end

figure
hold all
plot(data_x,data_y,'b')
plot(data_x_p,data_y_p, 'r')
axis([-2 2 -2 2])
title('SDZ & Plastic Zone Around a Crack Tip')
xlabel('length (in)') % x-axis label
ylabel('height from crack (in)') % y-axis label
legend('SDZ','Plastic Zone')
