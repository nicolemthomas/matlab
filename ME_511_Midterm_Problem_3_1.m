%%ME 511 Midterm Problem 3
%Nicole Thomas
clear all
clear 
clc

%%Concatenate all fringe data into one file w/ fringe numbers in 3rd column
data = [];
%
for i = 8:13
    file_num = '%d.csv';
    filename = sprintf(file_num,i);
    fringe_data = csvread(filename);
    fringe_number = i + 0.5;
    for k = 1:length(fringe_data)
        col1= fringe_data(k,1);
        col2= fringe_data(k,2);
        data = [data; col1, col2, fringe_number ];
    end
end
%
%%Select K data points out of the data & convert to r and theta

n = 8;  %number times data than constants
%
lgth= length(data);
A_o = [];
j=0;

for num_sum = 1:8
    j = num_sum - 1;
    m = j;
    K = n*(j+m+2);
    interval = floor(lgth/K); %set interval to count by
    %rem = lgth - K*n;
    polar_data=[];
    max_data_pt = K*interval;
    %
    for k=1:interval:max_data_pt
    %         l= length(fringe_data);
        r = sqrt(data(k,1).^2 + data(k,2).^2); %r=sqrt(x^2+y^2)
        theta = atan(data(k,1)/data(k,2));
        N = data(k,3);
        polar_data = [polar_data; r, theta, N];
    end
    %
    %%Form b matrix
    f_over_t = 2056; %lb/(in-fringe)
    b = f_over_t*polar_data(:,3);
    %
    %%Form coefficient matrix, A
    A = [];
    X = [];
    Y = []; 
    for z = 1:num_sum 
        sigma_x = 2*(polar_data(:,1).^((z-1)-0.5)).*cos(((z-1)-0.5)*polar_data(:,2));
        sigma_y = 2*(polar_data(:,1).^(z-1)).*cos((z-1)*polar_data(:,2));
        X = [X, sigma_x];
        Y = [Y, sigma_y];
    end

    A = [A; X,Y];
    A_t = A.';
    B = A_t*b;
    x_top = A_t*A;
    x= x_top\B; 
    num_coeff = j+m+2 ;
    A_o= [A_o; x(1,1), num_coeff]; %
end


figure
plot(A_o(:,2),A_o(:,1),'b') 
%axis([-1 1 -1 1])
title('Non-Convergence plot')
xlabel('Number of Coefficients') % x-axis label
ylabel('A_0') % y-axis label
    