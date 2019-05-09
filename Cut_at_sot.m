% time in seconds after sot
clear
time = 5;
% select the folder with the data and get a structure with all .mat files
disp("Select Folder with Data");
DataFolder = uigetdir(pwd);
Files = dir(fullfile(DataFolder, '*.mat'));

% %Select the Output Folder
% disp("Select Output Folder");
% OutFolder = uigetdir(pwd);
CompleteData = [];
SeizureActivity = [];
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
    
    selected_channels = randperm(size(d,2),length(soz));
    
    % take data from all channels before and after sot
    DataAfterSOT = d(StartPoint:FsAfterSOT,:);
    DataBeforeSOT = d(FsBeforeSOT:FsBeforeSOT+time*fs,selected_channels);
    
    % resutling channels with seizure, according to the give soz
    DataWithSeizure = DataAfterSOT(:,soz);
    if fs < 1000
        QueryPointsAfter = [0:1/1000:time];
        QueryPointsBefore  = [0:1/fs:time];
        DataWithSeizure = interp1(QueryPointsBefore, DataWithSeizure, QueryPointsAfter, 'spline');
        DataBeforeSOT = interp1(QueryPointsBefore, DataBeforeSOT, QueryPointsAfter, 'spline');
    end
    
    CompleteData = [CompleteData,DataWithSeizure,DataBeforeSOT];
    SeizureActivity = [SeizureActivity, ones(1,size(DataWithSeizure,2)), zeros(1, size(DataBeforeSOT,2))];
end

CompleteData = [CompleteData;SeizureActivity]';

