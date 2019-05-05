function Y = HjorthMobility(X)

n = size(X,2);

dX = diff([zeros(1,n);X]);

mx2 = mean(X.^2);
mdx2 = mean(dX.^2);

mobility = mdx2 ./ mx2;
Y = sqrt(mobility);

end

