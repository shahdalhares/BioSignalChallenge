function Y = HjorthComplexity(X)

n = size(X,2);

dX = diff([zeros(1,n);X]);
ddX = diff([zeros(1,n);dX]);

mx2 = mean(X.^2);
mdx2 = mean(dX.^2);
mddx2 = mean(ddX.^2);

mob = mdx2 ./ mx2;
Y = sqrt(mddx2 ./ mdx2 - mob);


end
