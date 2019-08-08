function w = vector11(u,v)

% v = [1 2 3];
% u = [2 3 4];


w = zeros(3,1);
for ii=1:3
    for jj=1:3
        for kk=1:3
            w(kk,1) = w(kk,1) + perm([ii jj kk]) * u(ii) * v(jj);
            perm([ii jj kk])
        end
    end
end

w
cross(u, v)

