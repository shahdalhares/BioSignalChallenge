function [sot,soz] = MAIN_fun2019(data)

load('trainedModel');
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

for channel_idx = 1 : num_channel
    counter = 0;
    for frame_idx = 1 : signal_length_fs/(frame_length*data.fs)*2 - 2
        frame_start = ((frame_idx-1)*(frame_length/2)*data.fs)+1;
        if (frame_start + frame_length*data.fs > signal_length_fs)
            continue;
        end
        frame = data.d(frame_start:frame_start + frame_length*data.fs -1,channel_idx);
        features = [Kurtosis(frame), ZeroCrossing(frame), HjorthComplexity(frame), HjorthMobility(frame)...
            mean(frame), std(frame,[])];
        baggedTreemdl = trainedModel.ClassificationEnsemble;
        activity = predict(baggedTreemdl, features);
        if (activity == 1)
            counter = counter + 1;
            if (counter == 5)
                soz = [soz, channel_idx];
                break;
            end
        elseif (activity == 0 && counter > 0)
            counter = 0;
        end
    end
end
sot = 120;
