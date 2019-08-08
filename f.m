%ME 511 Midterm Problem 1 Function 
%Nicole Thomas

function err = f(theta,r)

    b=8;

    r_1 = sqrt((b+r*cos(theta))^2+(r*sin(theta))^2);
    theta_1 = atan(r*sin(theta)/(b+r*cos(theta)));

    sigma_yy_wf = (sqrt(b)/r_1)*[cos(theta_1+theta/2)+sin(theta_1)*sin(2*...
    theta_1+theta/2)+ 0.5*sin(theta)*sin(theta_1+(3*theta/2))];

    sigma_yy_nf = (1/sqrt(b))*(cos(theta/2)+cos(theta/2)*sin(theta/2)*...
    sin(3*theta/2));

err = ((sigma_yy_wf - sigma_yy_nf)/sigma_yy_nf) - 0.05;
