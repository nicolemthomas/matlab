function w = scalar22(A,B)

% v = [1 2 3];
% u = [2 3 4];


w = 0;
for ii=1:3
    for jj=1:3
        w = w + A(ii,jj)*B(ii,jj);
    end
end