function Y = HjorthComplexity(X)

n = size(X,1);

dX = diff([zeros(n,1),X], [], 2);
ddX = diff([zeros(n,1),dX], [], 2);

mx2 = mean(X.^2, 2);
mdx2 = mean(dX.^2, 2);
mddx2 = mean(ddX.^2, 2);

mob = mdx2 ./ mx2;
Y = real(sqrt(mddx2 ./ mdx2 - mob));


end
