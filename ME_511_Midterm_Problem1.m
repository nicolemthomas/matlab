
clear all 
close all
clc

b = 8;
X = linspace(-160,160,1000);
Y = linspace(-160,160,1000);

data_x = zeros(0);
data_y = zeros(0);
for i=1:1000
    x = X(i);
    for j=1:1000
        y = Y(j);
        r = sqrt(x^2+y^2);
        theta = asin(y/r); 
        r_1 = sqrt((b+r*cos(theta))^2+y^2);
        theta_1 = asin(y/r_1);
        sigma_yy_wf = sqrt(b)*((1/r_1)*cos(theta_1+(theta/2))+sin(theta_1)*...
            sin(2*theta_1 + theta/2)+(1/(2*r))*sin(theta_1)*sin(theta_1+(3*theta/2)));
        sigma_yy_nf = (1/sqrt(b))*(cos(theta/2)+(r/b)*sin(theta)*sin(theta/2)...
            +(1/2)*sin(theta)*sin(3*theta/2));
        SDZ = (sigma_yy_nf - sigma_yy_wf)/sigma_yy_wf;
        if SDZ > 0.049 && SDZ <0.051 
            data_x = [data_x; x ];
            data_y = [data_y; y ];
        end
    end
end

scatter(data_x,data_y)

