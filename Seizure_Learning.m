clear;
load('CompleteData.mat');

%% Features Calculation

T_kurtosis = Kurtosis(CompleteData(:, 1:end-1)');
T_ZeroCrossing = ZeroCrossing(CompleteData(:, 1:end-1)');
T_HjComplex = HjorthComplexity(CompleteData(:, 1:end-1)');
T_HjMobility = HjorthMobility(CompleteData(:, 1:end-1)');
T_mean = Wmean(CompleteData(:, 1:end-1))';
T_stdv = Wstd(CompleteData(:, 1:end-1))';
T_pca = Wpca1(CompleteData(:, 1:end-1))';

%% Table
TrainData =  table(T_kurtosis',T_ZeroCrossing',T_HjComplex', ...
    T_HjMobility', T_mean', T_stdv',T_pca', 'VariableNames', {'Kurtosis',...
    'ZeroCrossing','HjComplex','HjMobility','Mean','Stand_Diviation',...
    'PCA'});
TrainData.SeizureActivity = (CompleteData(:,end));