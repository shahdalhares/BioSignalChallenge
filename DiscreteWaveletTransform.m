function [table_of_reconstructed_levels] = DiscreteWaveletTransform(data)
%DISCRETEWAVELETTRANSFORM Summary of this function goes here
%   Detailed explanation goes here
channelnumber = length(data(:,1));
name = 'db20';
levels = 4;
approx = [];
table_of_reconstructed_levels = table;
for i = 1:channelnumber
%     data(i,:) = Bandpass(data(i,:));
    [c,l] = wavedec(data(i,:), levels, name);
% %     approx = appcoef(c,l,name);
% %     [cd1,cd2,cd3,cd4,cd5] = detcoef(c,l,[1 2 3 4 5]);
% %     temp_table = table(approx, cd1,cd2,cd3);
%     table_of_levels = [table_of_levels; temp_table];
    % %Reconstructed Signals from apprx. and details coeff.
%     a5 = wrcoef('a', c, l, 'db20', 5);
%     a2 = wrcoef('a', c, l, 'db20', 2);
%     d5 = wrcoef('d', c,l, 'db20', 5);
    d4 = wrcoef('d', c,l, 'db20', 4);
    d3 = wrcoef('d', c,l, 'db20', 3);
    d2 = wrcoef('d', c,l, 'db20', 2);
    a4 = wrcoef('a', c, l, 'db20', 4);
    
%     a8 = wrcoef('a', c,l, 'db20', 8);
%     d8 = wrcoef('d', c,l, 'db20', 8);
%     d7 = wrcoef('d', c,l, 'db20', 7);
%     d6 = wrcoef('d', c,l, 'db20', 6);
%     d5 = wrcoef('d', c,l, 'db20', 5);
%     d4 = wrcoef('d', c,l, 'db20', 4);
%     d3 = wrcoef('d', c,l, 'db20', 3);
%     d2 = wrcoef('d', c,l, 'db20', 2);
    
%     temp_table = table(a2,a5,d2,d3,d4,d5);
%     temp_table = table(a8,d2,d3,d4,d5,d6,d7,d8);
    temp_table = table(a4,d2,d3,d4);
    table_of_reconstructed_levels = [table_of_reconstructed_levels; temp_table];
end

