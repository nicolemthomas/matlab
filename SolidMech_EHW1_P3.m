%% MEGN 517 A Extended Homework Problem 3 - Rachel Gregg
clear all
clc

%%
% *Part b*
% Plot countours of the maximum principal stresses \sigma_1 in the region
% 0<= x_1 <= L, -c <=x_2<=c
% Given:
LL = 1.0;
cc = 0.1;
PP = 1;

%\sigma_1 eqn
x1=linspace(0,LL);
x2=linspace(-cc,cc);

for i = 1:length(x1)
    for j = 1:length(x2)
   sigma_1(i,j)= (3*PP/(4*cc^3))*(-x1(i)*x2(j) + sqrt(((cc^2+x2(j)^2)^2)+(x1(i)^2)*(x2(j)^2)));     
    end
end
figure(1)
contourf(x1,x2,sigma_1,50)
title('Max Principal Stress Contour Plot')
xlabel('x1')
ylabel('x2')

%%
% *Plot the von Mises stress in the region 0<=x1<=L, -c <=x2 <=c

x_1=linspace(0,LL);
x_2=linspace(-cc,cc);

for u = 1:length(x_1)
    for v = 1:length(x_2)
        sigma_11(u,v) = -(3*PP/(2*cc^3))*x_1(u)*x_2(v);
        sigma_22(u,v)= 0;
        sigma_12(u,v) = (3*PP/(4*cc))*(1-((x_2(v)^2)/(cc^2)));
        sigma_vm (u,v)= sqrt((sigma_11(u,v).^2) + (sigma_22(u,v).^2) -...
            (sigma_11(u,v).*sigma_22(u,v)) + 3*(sigma_12(u,v).^2));
    end
end

figure(2)
contourf(x1,x2,sigma_vm,50)
title('Von Mises Stress Contour Plot')
xlabel('x1')
ylabel('x2')