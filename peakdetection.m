function [Y_peaknumber,peakvalues,peakindices] = peakdetection(data)
%PEAKDETECTION Summary of this function goes here
%   Detailed explanation goes here

channelnumber = length(data(:,1));
Y_peaknumber = zeros(channelnumber,1);

for i = 1:channelnumber
    [peakvalues,peakindices] = findpeaks(data(i,:)');
    peaknumber = length(peakvalues);
    
    %Y_peakvalues=
    %Y_peakindices=
    Y_peaknumber(i) = peaknumber;
end

%extreme values auch hier?