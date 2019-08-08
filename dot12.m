function w = dot12(a,B)

% v = [1 2 3];
% u = [2 3 4];


w = zeros(3,1);
for ii=1:3
    for jj=1:3
        w(jj,1) = w(jj,1) + B(ii,jj)*a(ii);
    end
end