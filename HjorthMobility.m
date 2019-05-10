function Y = HjorthMobility(X)

n = size(X,1);

dX = diff([zeros(n,1),X], [], 2);

mx2 = mean(X.^2, 2);
mdx2 = mean(dX.^2, 2);

mobility = mdx2 ./ mx2;
Y = sqrt(mobility);

end

