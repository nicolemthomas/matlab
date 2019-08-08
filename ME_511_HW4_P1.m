%%ME 511 Fatigue and Fracture
%Homework 4 
%Problem 1
%Nicole Thomas
%
%%Define crack geometry
%
r = linspace(0.00001,0.1);
%%Define lambda?
%
c = 0;      %(m/s) crack velocity
c_k = 0;    %(m/s) longitudinal wave velocity
c_2 = 0;    %(m/s) shear wave velocity
lambda_k = sqrt(1 - (c/c_k)^2);
lambda_1 = 0;
lambda_2 = 0;

%%Define the beta functions
%
beta_1 = (1 + lambda_2^2)/(4*lambda_1*lambda_2 - (1 - lambda_2)^2);
beta_2 = 1 + 2*lambda_1^2 - lambda_2^2;
beta_3 = 4*lambda_1*lambda_2/(1 + lambda_2^2);
beta_4 = 1 + lambda_2^2;
beta_5 = ((1 + lambda_2)^2)/(4*lambda_1*lambda_2);

%%Define the Z and Y RE and IM functions 
% 
Re_Z1 = 0;
Re_Z2 = 0;
Re_Y1 = 0; 
Re_Y2 = 0; 
Im_Z1 = 0;
Im_Z2 = 0;
Im_Y1 = 0;
Im_Y2 = 0;

%%Define the stress functions
%
sigma_xx = beta_1*(beta_2*Re_Z1 - beta_3*Re_Z2 + beta_2*Re_Y1 - beta_4*Re_Y2);
sigma_yy = beta_1*(-beta_4*Re_Z1 + beta_3*Re_Z2 + beta_4*Re_Y1 + beta_4*Re_Y2);
%sigma_xy = 2*lambda_1*beta_1(-Im_Z1 + Im_Z2 - Im_Y1 + beta_5*Im_Y2);

normalized_sigma_yy = 1\sqrt(r);


figure
plot(r, normalized_sigma_yy)
%axis([-1 1 -1 1])
title('Normalized Stress vs. Crack Tip Radius')
xlabel('Crack Tip Radius (in)') % x-axis label
ylabel('Normalized Stress (psi/(in^2))') % y-axis label





