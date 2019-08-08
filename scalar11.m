function w = scalar11(u,v)

% v = [1 2 3];
% u = [2 3 4];


w = 0;
for ii=1:3
    w = w + u(ii)*v(ii)
end
