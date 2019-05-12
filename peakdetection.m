function [Y_peaknumber,peakvalues,peakindices] = peakdetection(data)
%PEAKDETECTION Summary of this function goes here
%   Detailed explanation goes here

warning('off','signal:findpeaks:largeMinPeakHeight');
channelnumber = length(data(:,1));
Y_peaknumber = zeros(channelnumber,1);
data = abs(data);
for i = 1:channelnumber
    [peakvalues,peakindices] = findpeaks(data(i,:)', 1000, 'MinPeakHeight', 90);
    peaknumber = length(peakvalues);
    
    %Y_peakvalues=
    %Y_peakindices=
    Y_peaknumber(i) = peaknumber;
end

%extreme values auch hier?