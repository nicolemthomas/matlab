%%MEGN 412 - Extended Homework 1 - Problem 1
% Nicole Thomas
% March 1, 2018
%
clear all
clear
clc

%% part A: Plot stress variation components as a function of the rotation angle about the y axis
A = 30; %A is the 5th and 6th digits of my CWID
B = 88; %B is the 7th and 8th digits of my CWID
Theta = linspace(0, pi/2); 
Stress = [3*A, -2*A, 2*A; -2*A, B, A; 2*A, A, 2*(A+B)]; %MPa

%%Initialize stress component matrices
stress_11_y=[];
stress_22_y=[];
stress_33_y=[];
stress_12_y=[];
stress_13_y=[];
stress_23_y=[];

trace_stress = zeros(1,100);
I_stress = zeros(100,1);
II_stress = zeros(100,1);
III_stress = zeros(100,1);

%%Run through all the theta values and put the components into the
%%individual matrices 
for i= 1:length(Theta)
    Rotation_tensor_y= [cos(Theta(i)), 0, sin(Theta(i)); 0 , 1, 0;-sin(Theta(i)), 0, cos(Theta(i))]; %page 2 of coordinate system notes
    Rotation_tensor_transpose_y = Rotation_tensor_y.';
    Rotated_stress_y = Rotation_tensor_y*Stress*Rotation_tensor_transpose_y;
    stress_11_y = [stress_11_y; Rotated_stress_y(1,1)];
    stress_22_y = [stress_22_y; Rotated_stress_y(2,2)];
    stress_33_y = [stress_33_y; Rotated_stress_y(3,3)];
    stress_12_y = [stress_12_y; Rotated_stress_y(1,2)];
    stress_13_y = [stress_13_y; Rotated_stress_y(1,3)];
    stress_23_y = [stress_23_y; Rotated_stress_y(2,3)];
    
    I_stress(i) = Rotated_stress_y(1,1) + Rotated_stress_y(2,2) + Rotated_stress_y(3,3);
    II_stress(i) = Rotated_stress_y(1,1)*Rotated_stress_y(2,2) + Rotated_stress_y(1,1)*Rotated_stress_y(3,3) + ...
    Rotated_stress_y(2,2)*Rotated_stress_y(3,3) - Rotated_stress_y(1,2)^2 - Rotated_stress_y(2,3)^2 - Rotated_stress_y(1,3)^2;
    III_stress(i) = det(Rotated_stress_y);
    
    %trace_stress(i) =  Rotated_stress_y(1,1)+Rotated_stress_y(2,2)+Rotated_stress_y(3,3);
%     I_stress = [I_stress; trace_stress];
%     II_stress = [];
%     III_stress = [];

end
%Plots the 3 normal stresses
figure
plot(Theta, stress_11_y, Theta, stress_22_y, Theta, stress_33_y) 
legend('Normal stress in 1-1 direction','Normal stress in 2-2 direction','Normal stress in 3-3 direction')
title('Normal Stresses when Rotated About the y-axis')
xlabel('Theta (radians)')
ylabel('Normal Stress (MPa)')
%Plot the 3 shear stresses
figure
plot(Theta, stress_12_y, Theta, stress_13_y, Theta, stress_23_y) 
legend('Shear stress in 1-2 direction','Shear stress in 1-3 direction','Shear stress in 2-3 direction')
title('Shear Stresses when Rotated About the y-axis')
xlabel('Theta (radians)')
ylabel('Shear Stress (MPa)')

%% part B:
[Max_11,I] = max(stress_11_y)
Theta_at_max = Theta(I)

%find unit normal traction vector to the max_11 value

%% part C: Plot the values of I, II, and III as a function of theta
% this is in the for loop above

%%Prob 2: 
Stress2 = [-2*A, -A, A; -A, B, A; A, A, 2*B]; %MPa
Max_stresses2 = eig(Stress2)

figure
plot(Theta, I_stress, Theta, II_stress, Theta, III_stress) 
legend('I','II','III')
axis([0 pi/2 -1*10^5 5*10^5])
title('Stress Invariants when Rotated About the y-axis')
xlabel('Theta (radians)')
ylabel('Stress Invariants')

