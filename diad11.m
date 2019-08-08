function W = diad11(a,b)

% v = [1 2 3];
% u = [2 3 4];


W = zeros(3,3);
for ii=1:3
    for jj=1:3
        W(ii,jj) = W(ii,jj) + a(ii)*b(jj);
    end
end