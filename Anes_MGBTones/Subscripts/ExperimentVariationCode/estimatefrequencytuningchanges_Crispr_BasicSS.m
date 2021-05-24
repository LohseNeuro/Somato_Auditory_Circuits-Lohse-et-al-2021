%% Subcortical circuits mediate communication between primary sensory cortical areas
%% Lohse, M. Dahmen, J.C. Bajo, V.M. and King, A.J.
% Code written by Michael Lohse
% Nature CommunIcations Manuscript number: NCOMMS-20-34371

%% Extracting tuning curves
clearvars -except elect Exp ExpCount ExpNo attenuation Thresh BasicExtract smoothing CurPath
% 
%if ExpNo>130
%freqrange=26:46
%else
 freqrange=26:51
%end
Good{ExpCount}=find(Exp(ExpCount).pTAll<Thresh)

i=0
for n=1:length(Exp(ExpCount).elect)%Good{ExpCount}
i=i+1
clear TuningConInterp TuningWhiskInterp
TuningConInterp=interp1(Exp(ExpCount).elect(n).cond(6).FRA(end-attenuation,:),linspace(1,21,26)) % so that spacing matches other experiments
TuningWhiskInterp=interp1(Exp(ExpCount).elect(n).cond(1).FRA(end-attenuation,:),linspace(1,21,26)) % so that spacing matches other experiments

AllCond=mean([smooth(TuningWhiskInterp,smoothing),smooth(TuningConInterp,smoothing)],2);

[maxiconAllCond(n),idxconAllCond(n)]=max(AllCond);
[maxicon(n), idxcon(n)]=max(smooth(TuningConInterp,smoothing));


normFreqConTemp(:,n)=smooth(TuningConInterp,smoothing)/maxicon(n);


normFreqTempwhisk(:,n)=smooth(TuningWhiskInterp,smoothing)/maxicon(n);


normFreqCon([freqrange]-idxconAllCond(n)+1,i)=normFreqConTemp(:,n);


normFreqwhisk([freqrange]+1-idxconAllCond(n),i)=normFreqTempwhisk(:,n);

normFreqConTempstd(:,n)=smooth(TuningConInterp,smoothing)/maxicon(n);

normFreqTempwhiskstd(:,n)=smooth(TuningWhiskInterp,smoothing)/maxicon(n);

normFreqConstd([freqrange]-idxconAllCond(n)+1,i)=normFreqConTempstd(:,n);

normFreqwhiskstd([freqrange]+1-idxconAllCond(n),i)=normFreqTempwhiskstd(:,n);


end


normFreqCon(normFreqCon==0)=nan;

normFreqwhisk(normFreqwhisk==0)=nan;


meanNormFreqCon=nanmedian(normFreqCon,2);

meanNormFreqwhisk=nanmedian(normFreqwhisk,2);


semNormFreqCon=nanstd(normFreqCon')/sqrt(size(normFreqCon,2))*2;

semNormFreqwhisk=nanstd(normFreqwhisk')/sqrt(size(normFreqwhisk,2));

% figure
% errorbar(1:length(meanNormFreqCon),meanNormFreqCon,semNormFreqCon,'k','linewidth', 2)
% hold on
% errorbar(1:length(meanNormFreqCon),meanNormFreqwhisk,semNormFreqwhisk,'r','linewidth', 2)
% xlim([11 40])



Whisk=normFreqwhisk(26,:)./normFreqCon(26,:)


figure(ExpCount+1000)

idx=reshape(1:64,1,64)';
for n= 1:length(Exp(ExpCount).elect)
subplot(8,8,n)
plot(normFreqCon(:,idx(n,:)),'k','linewidth', 1.5)
hold on
plot(normFreqwhisk(:,idx(n,:)),'r','linewidth', 1.5)

%axis off
end


%% Including in experiment structure

Exp(ExpCount).Good=Good{ExpCount};

Exp(ExpCount).normFreqCon=normFreqCon
Exp(ExpCount).normFreqwhisk=normFreqwhisk
Exp(ExpCount).Whisk=Whisk;




