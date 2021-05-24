%% Subcortical circuits mediate communication between primary sensory cortical areas
%% Lohse, M. Dahmen, J.C. Bajo, V.M. and King, A.J.
% Code written by Michael Lohse
% Nature CommunIcations Manuscript number: NCOMMS-20-34371

%% Extracting tuning curves
clearvars -except elect Exp ExpCount ExpNo attenuation Thresh BasicExtract smoothing CurPath
% 
freqrange=26:51

Good{ExpCount}=find(Exp(ExpCount).pTAll<Thresh)

i=0
for n=1:length(Exp(ExpCount).elect)%Good{ExpCount}
i=i+1

AllCond=mean([smooth(Exp(ExpCount).elect(n).cond(1).FRA(end-attenuation,:),smoothing),smooth(Exp(ExpCount).elect(n).cond(2).FRA(end-attenuation,:),smoothing),smooth(Exp(ExpCount).elect(n).cond(3).FRA(end-attenuation,:),smoothing),smooth(Exp(ExpCount).elect(n).cond(4).FRA(end-attenuation,:),smoothing),smooth(Exp(ExpCount).elect(n).cond(6).FRA(end-attenuation,:),smoothing)],2);

[maxiconAllCond(n),idxconAllCond(n)]=max(AllCond);
[maxicon(n), idxcon(n)]=max(smooth(Exp(ExpCount).elect(n).cond(6).FRA(end-attenuation,:),smoothing));

normFreqConTemp(:,n)=smooth(Exp(ExpCount).elect(n).cond(6).FRA(end-attenuation,:),smoothing)/maxicon(n);

normFreqTemplight(:,n)=smooth(Exp(ExpCount).elect(n).cond(3).FRA(end-attenuation,:),smoothing)/maxicon(n);
normFreqTemplight50(:,n)=smooth(Exp(ExpCount).elect(n).cond(4).FRA(end-attenuation,:),smoothing)/maxicon(n);

normFreqTempwhisk(:,n)=smooth(Exp(ExpCount).elect(n).cond(1).FRA(end-attenuation,:),smoothing)/maxicon(n);
normFreqTempwhisk50(:,n)=smooth(Exp(ExpCount).elect(n).cond(2).FRA(end-attenuation,:),smoothing)/maxicon(n);

normFreqCon([freqrange]-idxconAllCond(n)+1,i)=normFreqConTemp(:,n);

normFreqlight([freqrange]+1-idxconAllCond(n),i)=normFreqTemplight(:,n);
normFreqlight50([freqrange]+1-idxconAllCond(n),i)=normFreqTemplight50(:,n);

normFreqwhisk([freqrange]+1-idxconAllCond(n),i)=normFreqTempwhisk(:,n);
normFreqwhisk50([freqrange]+1-idxconAllCond(n),i)=normFreqTempwhisk50(:,n);

normFreqConTempstd(:,n)=smooth(Exp(ExpCount).elect(n).cond(6).stdFRA(end-attenuation,:),smoothing)/maxicon(n);

normFreqTemplightstd(:,n)=smooth(Exp(ExpCount).elect(n).cond(3).stdFRA(end-attenuation,:),smoothing)/maxicon(n);
normFreqTemplightstd50(:,n)=smooth(Exp(ExpCount).elect(n).cond(4).stdFRA(end-attenuation,:),smoothing)/maxicon(n);

normFreqTempwhiskstd(:,n)=smooth(Exp(ExpCount).elect(n).cond(1).stdFRA(end-attenuation,:),smoothing)/maxicon(n);
normFreqTempwhiskstd50(:,n)=smooth(Exp(ExpCount).elect(n).cond(2).stdFRA(end-attenuation,:),smoothing)/maxicon(n);


normFreqConstd([freqrange]-idxconAllCond(n)+1,i)=normFreqConTempstd(:,n);

normFreqlightstd([freqrange]+1-idxconAllCond(n),i)=normFreqTemplightstd(:,n);
normFreqlightstd50([freqrange]+1-idxconAllCond(n),i)=normFreqTemplightstd50(:,n);


normFreqwhiskstd([freqrange]+1-idxconAllCond(n),i)=normFreqTempwhiskstd(:,n);
normFreqwhiskstd50([freqrange]+1-idxconAllCond(n),i)=normFreqTempwhiskstd50(:,n);


end


normFreqCon(normFreqCon==0)=nan;

normFreqlight(normFreqlight==0)=nan;
normFreqlight50(normFreqlight==0)=nan;

normFreqwhisk(normFreqwhisk==0)=nan;
normFreqwhisk50(normFreqwhisk==0)=nan;



meanNormFreqCon=nanmedian(normFreqCon,2);

meanNormFreqlight=nanmedian(normFreqlight,2);
meanNormFreqlight50=nanmedian(normFreqlight50,2);

meanNormFreqwhisk=nanmedian(normFreqwhisk,2);
meanNormFreqwhisk50=nanmedian(normFreqwhisk50,2);


semNormFreqCon=nanstd(normFreqCon')/sqrt(size(normFreqCon,2))*2;

semNormFreqlight=nanstd(normFreqlight')/sqrt(size(normFreqlight,2));
semNormFreqlight50=nanstd(normFreqlight50')/sqrt(size(normFreqlight50,2));

semNormFreqwhisk=nanstd(normFreqwhisk')/sqrt(size(normFreqwhisk,2));
semNormFreqwhisk50=nanstd(normFreqwhisk50')/sqrt(size(normFreqwhisk50,2));


figure
errorbar(1:length(meanNormFreqCon),meanNormFreqCon,semNormFreqCon,'k','linewidth', 2)
hold on

errorbar(1:length(meanNormFreqCon),meanNormFreqlight,semNormFreqlight,'b','linewidth', 2) 
errorbar(1:length(meanNormFreqCon),meanNormFreqlight50,semNormFreqlight50,'b--','linewidth', 2)

errorbar(1:length(meanNormFreqCon),meanNormFreqwhisk,semNormFreqwhisk,'r','linewidth', 2)
errorbar(1:length(meanNormFreqCon),meanNormFreqwhisk50,semNormFreqwhisk50,'r--','linewidth', 2)
xlim([11 40])



Whisk=normFreqwhisk(26,:)./normFreqCon(26,:)
Whisk50=normFreqwhisk50(26,:)./normFreqCon(26,:)

Light=normFreqlight(26,:)./normFreqCon(26,:)
Light50=normFreqlight(26,:)./normFreqCon(26,:)

figure(ExpNo+1000)

idx=reshape(1:64,1,64)';
for n= 1:length(Good{ExpCount})
subplot(8,8,n)
plot(normFreqCon(:,idx(n,:)),'k','linewidth', 1.5)
hold on
plot(normFreqlight(:,idx(n,:)),'b','linewidth', 1.5)
plot(normFreqlight50(:,idx(n,:)),'b--','linewidth', 1.5)

plot(normFreqwhisk(:,idx(n,:)),'r','linewidth', 1.5)
plot(normFreqwhisk50(:,idx(n,:)),'r--','linewidth', 1.5)

axis off
end


%% Including in experiment structure

Exp(ExpCount).Good=Good{ExpCount};

Exp(ExpCount).normFreqCon=normFreqCon
Exp(ExpCount).normFreqwhisk=normFreqwhisk
Exp(ExpCount).normFreqwhisk50=normFreqwhisk50
Exp(ExpCount).normFreqlight=normFreqlight
Exp(ExpCount).normFreqlight50=normFreqlight50

Exp(ExpCount).Whisk=Whisk;
Exp(ExpCount).Whisk50=Whisk50;
Exp(ExpCount).Light=Light;
Exp(ExpCount).Light50=Light50;

