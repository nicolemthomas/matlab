%%MEGN 412 - Homework 1 - Problem 3
% Nicole Thomas
% March 1, 2018
%
clear all
clear
clc
%Plots contours of the max principal stress in the region defined below for
%x1 and x2
L = 1.0;
c = 0.1;
P = 1;
%
x1 = linspace(0,1);
x2 = linspace(-c,c);

% sigma_1 = (3*P/4*c^3)*(-x1*x2 + sqrt((c^2-x2^2)^2 + x1^2*x2^2));
% sigma_2 = (3*P/4*c^3)*(-x1*x2 - sqrt((c^2-x2^2)^2 + x1^2*x2^2));


for i = 1:length(x1)
    for j = 1:length(x2)
        sigma_1(i,j) = (3*P/(4*c^3))*(-x1(i)*x2(j) + sqrt((c^2-x2(j)^2)^2 + x1(i)^2*x2(j)^2));
    end
end
figure
contourf(x1,x2,sigma_1,50)
title('Contour Plot of Max Principal Stress')
xlabel('x1')
ylabel('x2')

%%Part c: Plots contours of the von Mises stress in the region 0<=x1<=L,
%%-c<=x2<=c

for i = 1:length(x1)
    for j = 1:length(x2)
        sigma_1(i,j) = (3*P/(4*c^3))*(-x1(i)*x2(j) + sqrt((c^2-x2(j)^2)^2 + x1(i)^2*x2(j)^2));
        sigma_2(i,j) = (3*P/(4*c^3))*(-x1(i)*x2(j) - sqrt((c^2-x2(j)^2)^2 + x1(i)^2*x2(j)^2));
        sigma_12(i,j) = (3*P/(4*c^3))*(sqrt((c^2-x2(j)^2)^2 + x1(i)^2*x2(j)^2));
        
        sigma_v(i,j) = sqrt(sigma_1(i,j)^2 - sigma_1(i,j)*sigma_2(i,j) +...
            sigma_2(i,j)^2 + 3*sigma_12(i,j));
    end
end

figure
contourf(x1,x2,sigma_v,50)
title('Contour Plot of Von Mises Stress')
xlabel('x1')
ylabel('x2')