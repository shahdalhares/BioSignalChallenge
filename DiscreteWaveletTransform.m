function Y = DiscreteWaveletTransform(data)
%DISCRETEWAVELETTRANSFORM Summary of this function goes here
%   Detailed explanation goes here
channelnumber = length(data(:,1));
Y = zeros(channelnumber,1);
name = 'db4';

for i = 1:channelnumber
    dwtofchannel = dwt(data(i,:)',name);
    Y(i) = dwtofchannel;
end

