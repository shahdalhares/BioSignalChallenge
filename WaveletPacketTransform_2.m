function [table_of_levels, table_of_entropy] = WaveletPacketTransform_2(data)
%WAVELETPACKETTRANSFORM Summary of this function goes here
%   Detailed explanation goes here
channelnumber = length(data(:,1));
name = 'db20';
levels = 7;
table_of_levels = table;
table_of_entropy = table;
vn = {'c70_ent', 'c71_ent', 'c72_ent', 'c73_ent', 'c74_ent', 'c75_ent', 'c76_ent', 'c77_ent', 'c78_ent', 'c79_ent',...
    'c710_ent', 'c711_ent', 'c712_ent', 'c713_ent'};
for i = 1:channelnumber
    data(i,:) = Bandpass(data(i,:));
    T = wpdec(data(i,:), 7, name);
    ent = read(T, 'ent', [127:140])';
    for j = 0:13
        switch j
            case 0
                c70 = wpcoef(T, [levels,0]);
%                 subplot(8,1,j+1);
%                 plot(c30);
            case 1
                c71 = wpcoef(T, [levels,1]);
%                 subplot(8,1,j+1);
%                 plot(c31);
            case 2
                c72 = wpcoef(T, [levels,2]);
%                 subplot(8,1,j+1);
%                 plot(c32);
            case 3
                c73 = wpcoef(T, [levels,3]);
%                 subplot(8,1,j+1);
%                 plot(c33);
            case 4
                c74 = wpcoef(T, [levels,4]);
%                 subplot(8,1,j+1);
%                 plot(c34);
            case 5
                c75 = wpcoef(T, [levels,5]);
%                 subplot(8,1,j+1);
%                 plot(c35);
            case 6
                c76 = wpcoef(T, [levels,6]);
%                 subplot(8,1,j+1);
%                 plot(c36);
            case 7
                c77 = wpcoef(T, [levels,7]);
%                 subplot(8,1,j+1);
%                 plot(c37);
            case 8
                c78 = wpcoef(T, [levels,8]);
            case 9
                c79 = wpcoef(T, [levels,9]);
            case 10
                c710 = wpcoef(T, [levels,10]);
            case 11
                c711 = wpcoef(T, [levels,11]);
            case 12
                c712 = wpcoef(T, [levels,12]);
            case 13
                c713 = wpcoef(T, [levels,13]);
                
        end
    end
    temp_table = table(c70, c71, c72, c73, c74, c75, c76, c77, c78, c79, c710, c711, c712, c713);
    temp_table2 = table(ent(1),ent(2),ent(3),ent(4),ent(5),ent(6),ent(7),ent(8),...
        ent(9), ent(10), ent(11), ent(12), ent(13), ent(14),'VariableNames', vn);
    table_of_levels = [table_of_levels; temp_table];
    table_of_entropy = [table_of_entropy; temp_table2];
end
end