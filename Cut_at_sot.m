% time in seconds after sot
clear
time = 5;
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
    StartPoint = fs * sot;
    % Generate random number between 5 and 30
    ran = randi([5, 30]);
    % Chekc if outside range
    if sot - ran < 0
       ran = sot; 
    end
    FsAfterSOT = (sot+time)*fs;
    FsBeforeSOT = (sot-ran)*fs;
    
    % take data from all channels before and after sot
%     DataAfterSOT = d(StartPoint:FsAfterSOT,:);
    DataBeforeSOT = d(FsBeforeSOT:FsBeforeSOT+time*fs,:);
    
    % resutling channels with seizure, according to the give soz
    DataWithSeizure = DataAfterSOT(:,soz); % maybe here iz instead of soz?
    
    % write data
    out1 = fullfile(OutFolder, strcat(name, '_before' ,'.mat'));
%     out2 = fullfile(OutFolder, strcat(name, '_after' ,'.mat'));
    out3 = fullfile(OutFolder, strcat(name, '_seizure' ,'.mat'));
    save(out1, 'DataBeforeSOT');
%     save(out2, 'DataAfterSOT');
    save(out3, 'DataWithSeizure');
end

