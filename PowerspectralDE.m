function [Y_periodogram,Y_welch,Y_burg,Y_cov,Y_mcov,Y_multitaper] = PowerspectralDE(data)
%POWERSPECTRALDENSITYESTIMATOR Summary of this function goes here
%   Detailed explanation goes here
order = 11;
Fs = 1000;

[Y_periodogram,~] = periodogram(data',[],length(data),Fs);
Y_welch = pwelch(data');
Y_burg = pburg(data',order);
Y_cov = pcov(data',order);
Y_mcov = pmcov(data',order);
Y_multitaper = pmtm(data');

end

