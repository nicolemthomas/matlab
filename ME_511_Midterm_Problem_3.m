%ME 511 Midterm Problem 3
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
j = 0;  %number constants
m = j;
K = n*(j+m+2);
l= length(data);
num_sum = J
for num_sum = 1: K

    interval = round(l/K); %set interval to count by
    polar_data=[];
    %
    for k=1:interval:l
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
    % A_row = [];
    %
    for d = 1:length(polar_data)
        J=(K/n)-m-2;
        M=J;
        sigma_x = 2*(polar_data(d,1)^(J-0.5))*cos((J-0.5)*polar_data(d,2));
        sigma_y = 2*(polar_data(d,1)^(M))*cos(M*polar_data(d,2));
        X = [X, sigma_x];
        Y = [Y, sigma_y];
        %A_row = [A_row, X,Y];
        A = [A; X,Y];
    end

    A_t = A.';
    B = A_t*b;
    x_top = A_t*A;
    x= x_top\B;
    
end
plot(x,K)       
    