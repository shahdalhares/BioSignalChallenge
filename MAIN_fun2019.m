function [sot,soz] = MAIN_fun2019(data)

load('trainedModel_879_bagged');
frame_length = 5;
signal_length_sec = size(data.d,1)/data.fs;
num_channel = size(data.d,2);
signal_length_fs = size(data.d,1);
soz= [];

if data.fs < 1000
    QueryPointsAfter = [0:1/1000:signal_length_sec];
    QueryPointsBefore  = [0:1/data.fs:signal_length_sec];
    data.d = interp1(QueryPointsBefore, data.d, QueryPointsAfter, 'spline');    
    data.fs = 1000;
    signal_length_fs = size(data.d,1);
end
tic
for channel_idx = 1 : num_channel
    counter = 0;
    for frame_idx = 1 : signal_length_fs/(frame_length*data.fs)*2 - 2
        frame_start = ((frame_idx-1)*(frame_length/2)*data.fs)+1;
        if (frame_start + frame_length*data.fs > signal_length_fs)
            continue;
        end
        frame = data.d(frame_start:frame_start + frame_length*data.fs -1,channel_idx);
        
        table_of_levels = DiscreteWaveletTransform(frame');
        
        T_kurtosis = varfun(@Kurtosis, table_of_levels);
        T_ZeroCrossing = varfun(@ZeroCrossing, table_of_levels);
        T_HjComplex = varfun(@HjorthComplexity, table_of_levels);
        T_HjMobility = varfun(@HjorthMobility, table_of_levels);
        T_mean = varfun(@Wmean, table_of_levels);
        T_stdv = varfun(@Wstd, table_of_levels);
        T_energy = varfun(@Energy, table_of_levels);
        T_meanAbsDiv = varfun(@MeanAbsoluteDeviation, table_of_levels);
        T_medianAbsDiv = varfun(@MedianAbsoluteDeviation, table_of_levels);
        
        features =  [T_kurtosis,T_ZeroCrossing,T_HjComplex, ...
            T_HjMobility, T_mean, T_stdv,T_energy, T_meanAbsDiv, T_medianAbsDiv];
        features.T_peaks = peakdetection(frame');
        
        trainedClass = trainedModel.ClassificationEnsemble;
        activity = predict(trainedClass, features);
        if (activity == 1)
            counter = counter + 1;
            if (counter == 3)
                soz = [soz, channel_idx];
                break;
            end
        elseif (activity == 0 && counter > 0)
            counter = 0;
        end
    end
end
toc
sot = 120;
