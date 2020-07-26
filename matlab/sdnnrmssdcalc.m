function [tsresult,sdnnresult,rmssdresult] = sdnnrmssdcalc(timestampinms,ibiinms,windowlengthinminutes)
timestampinms_ibiinms(:,1) = timestampinms;
timestampinms_ibiinms(:,2) = ibiinms;
calts(1) = timestampinms_ibiinms(1);
for i=2:length(timestampinms_ibiinms)
%    calts(i)=timestampinms_ibiinms(i)+calts(i-1);
end
%timestampinms_ibiinms(:,2)=timestampinms_ibiinms(:,1);
%timestampinms_ibiinms(:,1)=calts;
timestampinms_ibiinms(:,3)=60000./timestampinms_ibiinms(:,2);
nnbuffer=[];
tsbuffer=[];
sdnn=[];
ts=[];
rmssd=[];
winsize = (windowlengthinminutes*60)*1000; % 5 minutes
%winsize = (3*60)*1000; % 15 seconds
firsttimefull = 0;
for i=1:length(timestampinms_ibiinms(:,1))
    %disp(timestampinms_ibiinms(i,1));
    nnbuffer = [nnbuffer timestampinms_ibiinms(i,2)];
    tsbuffer = [tsbuffer timestampinms_ibiinms(i,1)];
    
    while (tsbuffer(end) - tsbuffer(1)) > winsize
        tsbuffer(1) = [];
        nnbuffer(1) = [];
        firsttimefull = 1;
    end
    if (firsttimefull==1)
        sdnn = [sdnn std(nnbuffer)];
        ts = [ts tsbuffer(end)];
        %rmssd
        bufdiff = [];
        for k=1:length(nnbuffer)-1
            bufdiff = [bufdiff (nnbuffer(k)-nnbuffer(k+1))^2];
        end
        rmssd = [rmssd mean(bufdiff)^0.5];
    end
    
    
end
ts=ts';
sdnn=sdnn';
rmssd= rmssd';
tsresult=ts;
sdnnresult=sdnn;
rmssdresult=rmssd;
%result(:,4)=timestampinms_ibiinms(:,3);

% SCbuffer = [obj.windowSCTrendbuffer gsr];
%                 TimeStampsBuffer = [obj.windowTimeStamps4SCtrend time];
%                 
%                 if time + samplingDuration - TimeStampsBuffer(1) > obj.winSize   % Check difference between timestamps and adjust buffer
%                     obj.firsttimefilled = true;
%                     while time - TimeStampsBuffer(1) > obj.winSize
%                         TimeStampsBuffer(1) = [];
%                         SCbuffer(1) = [];
%                     end
%                 end
