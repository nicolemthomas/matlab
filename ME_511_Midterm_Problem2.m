%%ME 511 Midterm Problem 2
%Nicole Thomas

clear all 
clc

% data_theta = zeros(0);
% data_r = zeros(0);
% theta = linspace(0,2*pi(),100);

data_x = zeros(0);
data_y = zeros(0);
theta = linspace(0,2*pi());

for i = 1:length(theta)
    normalized_r_y(i)=(6-(5/2)*(sin(theta(i)))^2)/(4*pi());
    x= normalized_r_y(i)*cos(theta(i));
    y = normalized_r_y(i)*sin(theta(i));
    data_x = [data_x; x];
    data_y = [data_y; y ];
%     data_theta = [data_theta; theta];
%     data_r = [data_r; normalized_r_y(i)];
%     
end

figure
plot(data_x,data_y,'b')
axis([-1 1 -1 1])
title('SDZ')
xlabel('length (in)') % x-axis label
ylabel('height from crack (in)') % y-axis label
