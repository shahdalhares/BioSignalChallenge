function [table_of_levels] = DiscreteWaveletTransform(data)
%DISCRETEWAVELETTRANSFORM Summary of this function goes here
%   Detailed explanation goes here
channelnumber = length(data(:,1));
name = 'sym8';
levels = 3;
approx = [];
table_of_levels = table;
for i = 1:channelnumber
    [c,l] = wavedec(data(i,:), levels, name);
    approx = appcoef(c,l,name);
    [cd1,cd2,cd3] = detcoef(c,l,[1 2 3]);
    temp_table = table(approx, cd1,cd2,cd3);
    table_of_levels = [table_of_levels; temp_table];
end

