function [Y] = ZeroCrossing(X)
Y = sum(abs(diff(X>0)))/length(X);
end