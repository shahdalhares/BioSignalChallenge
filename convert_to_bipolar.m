clear

% select the folder with the data and get a structure with all .mat files
disp("Select Folder with Data");
DataFolder = uigetdir(pwd);
Files = dir(fullfile(DataFolder, '*.mat'));

%Select the Output Folder
disp("Select Output Folder");
OutFolder = uigetdir(pwd);

for k=1:length(Files)
    %CurrentFile = Files(k).name;
    CurrentFile = fullfile(Files(k).folder, Files(k).name);
    load (CurrentFile)
    [~,name,~] = fileparts(CurrentFile);
    
    index_cell = header.labels_bipolar(:,2);
    index_mat = cell2mat(index_cell);
    d = d(:,index_mat(:,1)) - d(:,index_mat(:,2));
    soz_size = length(soz);
    soz_new = [];
    for soz_channel = 1:soz_size
        soz_t = find(index_mat == soz(soz_channel));
        bipolar_size = size(index_mat,1);
        soz_t(soz_t>bipolar_size) = soz_t(soz_t>bipolar_size)-bipolar_size;
        soz_new = [soz_new;soz_t];
    end
    soz_new = unique(soz_new);
    soz = soz_new;
    out1 = fullfile(OutFolder, strcat(name, '_bipolar' ,'.mat'));
    save(out1, 'd', 'header', 'fs', 't', 'sot', 'soz');

end

