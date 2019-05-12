function [table_of_levels, table_of_entropy] = WaveletPacketTransform(data)
%WAVELETPACKETTRANSFORM Summary of this function goes here
%   Detailed explanation goes here
channelnumber = length(data(:,1));
name = 'db4';
levels = 3;
table_of_levels = table;
table_of_entropy = table;
vn = {'c30_ent', 'c31_ent', 'c32_ent', 'c33_ent', 'c34_ent', 'c35_ent', 'c36_ent', 'c37_ent'};
for i = 1:channelnumber
    data(i,:) = Bandpass(data(i,:));
    T = wpdec(data(i,:), levels, name);
    ent = read(T, 'ent', [7:15])';
    for j = 0:7
        switch j
            case 0
                c30 = wpcoef(T, [3,0]);
%                 subplot(8,1,j+1);
%                 plot(c30);
            case 1
                c31 = wpcoef(T, [3,1]);
%                 subplot(8,1,j+1);
%                 plot(c31);
            case 2
                c32 = wpcoef(T, [3,2]);
%                 subplot(8,1,j+1);
%                 plot(c32);
            case 3
                c33 = wpcoef(T, [3,3]);
%                 subplot(8,1,j+1);
%                 plot(c33);
            case 4
                c34 = wpcoef(T, [3,4]);
%                 subplot(8,1,j+1);
%                 plot(c34);
            case 5
                c35 = wpcoef(T, [3,5]);
%                 subplot(8,1,j+1);
%                 plot(c35);
            case 6
                c36 = wpcoef(T, [3,6]);
%                 subplot(8,1,j+1);
%                 plot(c36);
            case 7
                c37 = wpcoef(T, [3,7]);
%                 subplot(8,1,j+1);
%                 plot(c37);
        end
    end
    temp_table = table(c30, c31, c32, c33, c34, c35, c36, c37);
    temp_table2 = table(ent(1),ent(2),ent(3),ent(4),ent(5),ent(6),ent(7),ent(8), 'VariableNames', vn);
    table_of_levels = [table_of_levels; temp_table];
    table_of_entropy = [table_of_entropy; temp_table2];
end
end