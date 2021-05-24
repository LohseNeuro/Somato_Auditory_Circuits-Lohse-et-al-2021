%% Subcortical circuits mediate communication between primary sensory cortical areas
%% Lohse, M. Dahmen, J.C. Bajo, V.M. and King, A.J.
% Code written by Michael Lohse
% Nature CommunIcations Manuscript number: NCOMMS-20-34371

%% Importing data from anesthetized MGB recording with broadband noise with whisker stimulation to analyse their interactions and temporal dependency

close all
clearvars -except Exp ExpCount Thresh ExpNo BasicExtract CurPath

% identfy the correct postfix for the raw data
if ExpNo==63
    basedir=['DATA' filesep 'MGB_Noise' filesep sprintf('expt%d',Exp(ExpCount).ExpNo) filesep sprintf('P0%d-noise_with_WhiskandLight.2',Exp(ExpCount).Pen)];
elseif ExpNo==69
    if ExpCount==8
        basedir=['DATA' filesep 'MGB_Noise' filesep sprintf('expt%d',Exp(ExpCount).ExpNo) filesep sprintf('P0%d-noise_with_WhiskandLight',Exp(ExpCount).Pen)];
    elseif ExpCount==9
        basedir=['DATA' filesep 'MGB_Noise' filesep sprintf('expt%d',Exp(ExpCount).ExpNo) filesep sprintf('P0%d-noise_with_WhiskandLight.2',Exp(ExpCount).Pen)]; 
    end
else
    basedir=['DATA' filesep 'MGB_Noise' filesep sprintf('expt%d',Exp(ExpCount).ExpNo) filesep sprintf('P0%d-noise_with_WhiskandLight',Exp(ExpCount).Pen)];
end

cd(basedir)

load('gridInfo') % load stimulus parameters and stimulus grid for the current recording
load('dataCompact') % load raw data for the current recording
rawdata=dataCompact;
clear dataCompact

% Experiment 60 has recordings from multiple locations and only recording channels below 33
% are in the thalamus. All other experiments have all recording channels (32 or 64 channels depending on the probe) in the thalamus. 
if ExpNo==60
    elec=find(rawdata.peakChans<33);
else
    elec=find(rawdata.peakChans<100);
    
end

reps=length(rawdata.sets(1).spikeTimes{1}); % identify amount of repetitions of each condition in the current recordings

Exp(ExpCount).reps=reps; % Put into strucure to contain information from all experiments


sets=length(grid.stimGrid); % identify amount of conditions
edges_for_analysis= 0:1:700; %1ms bin size for PSTH
%% Response window during stimulus
noise_dur=50; % stimulus duration
response_win_delay=1; % response window beginning relative to stimulus onset
convert2Hz_analysis = 0.001; % value for converting histogram to sp/s for PSTH



iiii=0; % counter
for electrode =1:length(elec) % loop through each recorded unit for the current recording
    clear  response singlePSTHWindow p mean_PSTH_sets CI95_PSTH_sets std_PSTH set_resp_win response_win_freqsstd response_win_freqs singlePSTHWindow singlePSTHSpont single_PSTHs_sets
    Clust=elec(electrode);
    iiii=iiii+1; % counter
    cur_set=0; % counter
    for cur_set_act=1:sets % loop through each condition
        clear  singlePSTHWindow singlePSTHSpont response spont_response_win_freqs_spacing spont_response_win_freqs singlePSTHWindow singlePSTHSpont response_win_freqs_spacing response_win_freqs_spacingsingle
        cur_set=cur_set+1;
        for csw = 1:reps % loop through each repetition for each condition
            response(csw,:)=histc(rawdata.sets(cur_set_act).spikeTimes{Clust}{csw}'*1000,edges_for_analysis);% single trial response PSTH
        end
        single_PSTHs = response/convert2Hz_analysis; % convert single trial PSTH to sp/s
        
        mean_PSTH = mean(single_PSTHs); % get mean PSTH for current condition for current recorded unit
        mean_PSTH_sets(cur_set,:) = mean_PSTH; % mean PSTH for all conditions for current recorded unit
        
        std_PSTH = std(single_PSTHs); % std for current PSTH
        sem_PSTH_sets(cur_set,:) = std_PSTH./sqrt(size(single_PSTHs,1)).*2; % standard error of the mean for PSTH
        
        single_PSTHs_sets{cur_set}=single_PSTHs; % all single trial PSTHs for this condition for current unit
        
        set_resp_win=[(grid.stimGrid(cur_set_act,2)+response_win_delay):((grid.stimGrid(cur_set_act,2))+noise_dur+response_win_delay)]; % find when sound was on for current condition
        
        spont_resp_win=[10:99]; % window for baseline firing rate
        
        singlePSTHWindow(:,cur_set)=mean(single_PSTHs(:,set_resp_win),2); % find stimulus response for all trials
        singlePSTHSpont(:,cur_set)=mean(single_PSTHs(:,spont_resp_win),2);% find baseline for all trials
        
        whisk_resp_win=101:150; % whisker stimulation window
        singlePSTHWindowWhisk(:,cur_set)=mean(single_PSTHs(:,whisk_resp_win),2); % find mean whisker stimulation firing rate for current unit
        
        [h(cur_set),p(cur_set)]=ttest2(singlePSTHWindow(:,cur_set),singlePSTHSpont(:,cur_set),'tail','right'); % two-sample t-test to test if the unit is responding to noise
        
    end
    
    % Create structure containing info from all recordings
    Exp(ExpCount).elect(electrode).WinRespSingleWhisk=singlePSTHWindowWhisk;
    Exp(ExpCount).elect(electrode).WinRespSingleSpont=singlePSTHSpont;
    Exp(ExpCount).elect(electrode).PSTH=mean_PSTH_sets(:,1:700);
    Exp(ExpCount).elect(electrode).sem_PSTH=sem_PSTH_sets(:,1:700);
    Exp(ExpCount).elect(electrode).SinglePSTH=single_PSTHs_sets;
    Exp(ExpCount).elect(electrode).peakChan=rawdata.peakChans(Clust);
    Exp(ExpCount).elect(electrode).stimGrid=grid.stimGrid;
    Exp(ExpCount).stimGrid=grid.stimGrid;
    Exp(ExpCount).elect(electrode).p=p;
    Exp(ExpCount).elect(electrode).CluType=rawdata.CluTypes(Clust);
    
end

