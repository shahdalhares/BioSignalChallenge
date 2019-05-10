function [Y] = ZeroCrossing(X)
Y = sum(abs(diff(X>0, [], 2)),2)/length(X);
end