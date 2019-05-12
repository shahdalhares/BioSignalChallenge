% time in seconds after sot
clear
time = 5;
% load('cut_time.mat');
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
    DataAfterSOT = [];
    DataBeforeSOT = [];
    %CurrentFile = Files(k).name;
    CurrentFile = fullfile(Files(k).folder, Files(k).name);
    load (CurrentFile)
    [~,name,~] = fileparts(CurrentFile);
    % Generate random numbers between 5 and 30
    rand_before = randi([5,30]);
    rand_after = sot;
    % Chekc if outside range
%     if sot - ran < 0
%        ran = sot; 
%     end
    rand_before(sot - rand_before < 0) = sot;
    rand_after (rand_after > size(d,1)/fs) = sot + 5;
    
    FsAfterSOT = (rand_after)*fs;
    FsBeforeSOT = (sot-rand_before)*fs;
    
    selected_channels = randperm(size(d,2),length(soz));
    
    % take data from all channels before and after sot
%     DataAfterSOT = d(FsAfterSOT:FsAfterSOT+time*fs,:);
%     DataBeforeSOT = d(FsBeforeSOT:FsBeforeSOT+time*fs,selected_channels);

    for i = 1:length(FsAfterSOT)
        DataAfterSOT = [DataAfterSOT, d(FsAfterSOT(i):FsAfterSOT(i)+time*fs,:)];
        DataBeforeSOT = [DataBeforeSOT, d(FsBeforeSOT(i):FsBeforeSOT(i)+time*fs,selected_channels)];
    end
    
    cut_soz = soz;
    % resutling channels with seizure, according to the give soz
    DataWithSeizure = DataAfterSOT(:,cut_soz);
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

