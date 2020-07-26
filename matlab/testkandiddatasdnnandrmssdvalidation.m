clear
clf
load('kandid_data.mat');
%calculate SDNN and RMSSD using 5 min window
%note the algorithm waits for the first 5 minutes of data to be received
[resultts,resultsdnn,resultrmssd] = sdnnrmssdcalc(UnixTimeStamp,NNIntervals,5);

figure(1)
ax1=subplot(2,1,1);
plot(resultts,resultsdnn);
ax2=subplot(2,1,2);
plot(UnixTimeStamp,SDNN5min);
linkaxes([ax1,ax2],'x');

figure(2)
ax1=subplot(2,1,1);
plot(resultts,resultrmssd);
ax2=subplot(2,1,2);
plot(UnixTimeStamp,RMSSD5min);
linkaxes([ax1,ax2],'x');

for i=1:length(resultts)
    kandidtsindex = find(UnixTimeStamp==resultts(i));
    errorsdnn(i)=resultsdnn(i)-SDNN5min(kandidtsindex);
    errorrmssd(i)=resultrmssd(i)-RMSSD5min(kandidtsindex);
end
disp('SDNN Average Absolute Error')
mean(abs(errorsdnn))
disp('RMSSD Average Absolute Error')
mean(abs(errorrmssd))
