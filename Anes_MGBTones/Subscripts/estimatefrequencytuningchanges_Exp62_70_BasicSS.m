%% Subcortical circuits mediate communication between primary sensory cortical areas
%% Lohse, M. Dahmen, J.C. Bajo, V.M. and King, A.J.
% Code written by Michael Lohse
% Nature CommunIcations Manuscript number: NCOMMS-20-34371

%% Extracting tuning curves
% These experiments from anesthetized thalamus recordings include conditions
% where tones are played alone.
% And conditions where tones are paired
% with either whisker stimulation, or visual light flash, arriving either
% simulatous with tones, or temporally offset from the tone presentaion.
clearvars -except elect Exp ExpCount ExpNo attenuation Thresh BasicExtract smoothing CurPath
% 

freqrange=26:51
Good{ExpCount}=find(Exp(ExpCount).pTAll<Thresh) % find units showing significant tuning


%% extract normalized tuning curves (normalized to BF (from mean across all condirtions), and max firing rate for tones alone)
i=0 % counter
for n=1:length(Exp(ExpCount).elect) % extract tuing curves from all units
i=i+1

AllCond=mean([smooth(Exp(ExpCount).elect(n).cond(1).FRA(end-attenuation,:),smoothing),smooth(Exp(ExpCount).elect(n).cond(2).FRA(end-attenuation,:),smoothing),smooth(Exp(ExpCount).elect(n).cond(3).FRA(end-attenuation,:),smoothing),smooth(Exp(ExpCount).elect(n).cond(4).FRA(end-attenuation,:),smoothing),smooth(Exp(ExpCount).elect(n).cond(5).FRA(end-attenuation,:),smoothing),smooth(Exp(ExpCount).elect(n).cond(6).FRA(end-attenuation,:),smoothing)],2); % create  mean tuning curves from all conditions at the same sound level

[maxiconAllCond(n),idxconAllCond(n)]=max(AllCond); % find BF from mean (across conditions) tuning curve
[maxicon(n), idxcon(n)]=max(smooth(Exp(ExpCount).elect(n).cond(6).FRA(end-attenuation,:),smoothing)); % find max firing rate from tones alone condition

normFreqConTemp(:,n)=smooth(Exp(ExpCount).elect(n).cond(6).FRA(end-attenuation,:),smoothing)/maxicon(n);

normFreqTemplight(:,n)=smooth(Exp(ExpCount).elect(n).cond(3).FRA(end-attenuation,:),smoothing)/maxicon(n);
normFreqTemplight50(:,n)=smooth(Exp(ExpCount).elect(n).cond(4).FRA(end-attenuation,:),smoothing)/maxicon(n);
normFreqTemplight100(:,n)=smooth(Exp(ExpCount).elect(n).cond(5).FRA(end-attenuation,:),smoothing)/maxicon(n);

normFreqTempwhisk(:,n)=smooth(Exp(ExpCount).elect(n).cond(1).FRA(end-attenuation,:),smoothing)/maxicon(n);
normFreqTempwhisk50(:,n)=smooth(Exp(ExpCount).elect(n).cond(2).FRA(end-attenuation,:),smoothing)/maxicon(n);

normFreqCon([freqrange]-idxconAllCond(n)+1,i)=normFreqConTemp(:,n);

normFreqlight([freqrange]+1-idxconAllCond(n),i)=normFreqTemplight(:,n);
normFreqlight50([freqrange]+1-idxconAllCond(n),i)=normFreqTemplight50(:,n);
normFreqlight100([freqrange]+1-idxconAllCond(n),i)=normFreqTemplight100(:,n);

normFreqwhisk([freqrange]+1-idxconAllCond(n),i)=normFreqTempwhisk(:,n);
normFreqwhisk50([freqrange]+1-idxconAllCond(n),i)=normFreqTempwhisk50(:,n);

normFreqConTempstd(:,n)=smooth(Exp(ExpCount).elect(n).cond(6).stdFRA(end-attenuation,:),smoothing)/maxicon(n);

normFreqTemplightstd(:,n)=smooth(Exp(ExpCount).elect(n).cond(3).stdFRA(end-attenuation,:),smoothing)/maxicon(n);
normFreqTemplightstd50(:,n)=smooth(Exp(ExpCount).elect(n).cond(4).stdFRA(end-attenuation,:),smoothing)/maxicon(n);
normFreqTemplightstd100(:,n)=smooth(Exp(ExpCount).elect(n).cond(5).stdFRA(end-attenuation,:),smoothing)/maxicon(n);

normFreqTempwhiskstd(:,n)=smooth(Exp(ExpCount).elect(n).cond(1).stdFRA(end-attenuation,:),smoothing)/maxicon(n);
normFreqTempwhiskstd50(:,n)=smooth(Exp(ExpCount).elect(n).cond(2).stdFRA(end-attenuation,:),smoothing)/maxicon(n);


normFreqConstd([freqrange]-idxconAllCond(n)+1,i)=normFreqConTempstd(:,n);

normFreqlightstd([freqrange]+1-idxconAllCond(n),i)=normFreqTemplightstd(:,n);
normFreqlightstd50([freqrange]+1-idxconAllCond(n),i)=normFreqTemplightstd50(:,n);
normFreqlightstd100([freqrange]+1-idxconAllCond(n),i)=normFreqTemplightstd100(:,n);


normFreqwhiskstd([freqrange]+1-idxconAllCond(n),i)=normFreqTempwhiskstd(:,n);
normFreqwhiskstd50([freqrange]+1-idxconAllCond(n),i)=normFreqTempwhiskstd50(:,n);


end


normFreqCon(normFreqCon==0)=nan; % normalized tuning curves for tones alone

normFreqlight(normFreqlight==0)=nan; % normalized tuning curves for tones + simultanoues visual light flash
normFreqlight50(normFreqlight==0)=nan; % normalized tuning curves for tones + visual light 50 ms offset from tones
normFreqlight100(normFreqlight==0)=nan;% normalized tuning curves for tones + visual light 100 ms offset from tones

normFreqwhisk(normFreqwhisk==0)=nan; % normalized tuning curves for tones + simultanoues whisker stim
normFreqwhisk50(normFreqwhisk==0)=nan; % normalized tuning curves for tones + whisker stim 50 ms offset from tones

% Modulation at BF
Whisk=normFreqwhisk(26,:)./normFreqCon(26,:)
Whisk50=normFreqwhisk50(26,:)./normFreqCon(26,:)

Light=normFreqlight(26,:)./normFreqCon(26,:)
Light50=normFreqlight(26,:)./normFreqCon(26,:)
Light100=normFreqlight(26,:)./normFreqCon(26,:)



%% Including in experiment structure

Exp(ExpCount).Good=Good{ExpCount};

Exp(ExpCount).normFreqCon=normFreqCon
Exp(ExpCount).normFreqwhisk=normFreqwhisk
Exp(ExpCount).normFreqwhisk50=normFreqwhisk50
Exp(ExpCount).normFreqlight=normFreqlight
Exp(ExpCount).normFreqlight50=normFreqlight50
Exp(ExpCount).normFreqlight100=normFreqlight100

Exp(ExpCount).Whisk=Whisk;
Exp(ExpCount).Whisk50=Whisk50;
Exp(ExpCount).Light=Light;
Exp(ExpCount).Light50=Light50;
Exp(ExpCount).Light100=Light100;



