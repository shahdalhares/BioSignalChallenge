% clear;
load('CompleteDataWV.mat');
tic;
table_of_levels = DiscreteWaveletTransform(CompleteData(:,1:end-1));
% [table_of_levels, table_of_entropy] = WaveletPacketTransform(CompleteData(:,1:end-1));
toc;

%% Features Calculation

% T_kurtosis = Kurtosis(CompleteData(:, 1:end-1)');
% T_ZeroCrossing = ZeroCrossing(CompleteData(:, 1:end-1)');
% T_HjComplex = HjorthComplexity(CompleteData(:, 1:end-1)');
% T_HjMobility = HjorthMobility(CompleteData(:, 1:end-1)');
% T_mean = Wmean(CompleteData(:, 1:end-1))';
% T_stdv = Wstd(CompleteData(:, 1:end-1))';
% T_pca = Wpca1(CompleteData(:, 1:end-1))';
% [T_periodogram,T_welch,T_burg,T_cov,T_mcov,T_multitaper] = PowerspectralDE(CompleteData(:, 1:end-1));

%%
T_kurtosis = varfun(@Kurtosis, table_of_levels);
T_ZeroCrossing = varfun(@ZeroCrossing, table_of_levels);
T_HjComplex = varfun(@HjorthComplexity, table_of_levels);
T_HjMobility = varfun(@HjorthMobility, table_of_levels);
T_mean = varfun(@Wmean, table_of_levels);
T_stdv = varfun(@Wstd, table_of_levels);
T_energy = varfun(@Energy, table_of_levels);
T_meanAbsDiv = varfun(@MeanAbsoluteDeviation, table_of_levels);
T_medianAbsDiv = varfun(@MedianAbsoluteDeviation, table_of_levels);
toc;

%% Table
TrainData =  [T_kurtosis,T_ZeroCrossing,T_HjComplex, ...
    T_HjMobility, T_mean, T_stdv,T_energy, T_meanAbsDiv, T_medianAbsDiv];
%     'T_periodogram',...
%     'T_welch', 'T_burg', 'T_cov', 'T_mcov', 'T_multitaper'});
TrainData.T_peaks = peakdetection(CompleteData(:,1:end-1));
TrainData.SeizureActivity = (CompleteData(:,end));