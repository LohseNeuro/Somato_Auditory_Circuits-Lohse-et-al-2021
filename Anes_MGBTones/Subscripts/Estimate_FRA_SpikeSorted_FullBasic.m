%% Subcortical circuits mediate communication between primary sensory cortical areas
%% Lohse, M. Dahmen, J.C. Bajo, V.M. and King, A.J.
% Code written by Michael Lohse
% Nature CommunIcations Manuscript number: NCOMMS-20-34371

%% Estimates FRA for 6 conditions.
% These experimetns from anesthetized thalamus recordings include conditions
% where tones are played alone.
% And conditions where tones are paired
% with either whisker stimulation, or visual light flash, arriving either
% simulatous with tones, or temporally offset from the tone presentaion.


clearvars -except Exp ExpCount Thresh ExpNo BasicExtract CurPath attenuation smoothing
%close all
if ExpNo==68
    basedir=['DATA' filesep 'MGB_Tones' filesep sprintf('expt%d',Exp(ExpCount).ExpNo) filesep sprintf('P0%d-tone_with_WhiskandLight.2',Exp(ExpCount).Pen)];
    
else
    basedir=['DATA' filesep 'MGB_Tones' filesep sprintf('expt%d',Exp(ExpCount).ExpNo) filesep sprintf('P0%d-tone_with_WhiskandLight',Exp(ExpCount).Pen)];
end
cd(basedir)

load('gridInfo') % load stimulus and grid info
load('dataCompact') % load raw data
rawdata=dataCompact;
clear dataCompact

if ExpNo==60
    elec=find(rawdata.peakChans<33);
else
    elec=find(rawdata.peakChans<100);
    
end
if ExpNo<62
    reps=length(rawdata.sets(1).spikeTimes{1});
    
else
    reps=length(rawdata.sets(1).spikeTimes{1});
end
Exp(ExpCount).reps=reps;


sets=length(grid.stimGrid-1);
edges_for_analysis= 0:10:500; %10ms bin size
edges_for_PSTHs= 0:1:500; %10ms bin size

convert2Hz_analysis = 0.01;
whiskvoltages=unique(grid.stimGrid(:,5));
lightvoltages=unique(grid.stimGrid(:,8));
freqs=unique(grid.stimGrid(:,2));
levels=unique(grid.stimGrid(:,11));

%% First 50 ms after tone onset
tone_dur=5; % the window is ten times bigger than this number (edges are 10ms)
response_win_delay=1;

Exp(ExpCount).tone_dur=tone_dur;
Exp(ExpCount).response_win_delay=response_win_delay;

figure
iiii=0 % counter
for electrode =1:length(elec)
    Clust=elec(electrode);
    iiii=iiii+1;
    
    %% Extract responses from each condition at 10 ms binning and 1 ms binning
    cur_set=0
    for cur_set_act=1:sets
        cur_set=cur_set+1;
        for csw = 1:reps
            response(csw,:)=histc(rawdata.sets(cur_set_act).spikeTimes{Clust}{csw}'*1000,edges_for_analysis);% single sweep response
            response1ms(csw,:)=histc(rawdata.sets(cur_set_act).spikeTimes{Clust}{csw}'*1000,edges_for_PSTHs);% single sweep response
            
        end
        single_PSTHs = response/convert2Hz_analysis ;
        single_PSTHs1ms = response1ms/0.001 ;
        
        mean_PSTH = mean(single_PSTHs);
        
        mean_PSTH_sets1ms(cur_set,:) = mean(single_PSTHs1ms);
        std_PSTH_sets1ms(cur_set,:) = std(single_PSTHs1ms);
        
        set_resp_win=[(grid.stimGrid(cur_set_act,3)/10+response_win_delay):((grid.stimGrid(cur_set_act,3)/10)+tone_dur+response_win_delay)];
        
        singlePSTHWindow(:,cur_set)=mean(single_PSTHs(:,set_resp_win),2);
        singlePSTHSpont(:,cur_set)=mean(single_PSTHs(:,1:9),2);
        
        response_win_freqs_10ms_spacing=(mean_PSTH(:,set_resp_win));
        response_win_freqs_10ms_spacingsingle=mean(single_PSTHs(:,set_resp_win),2);
        response_win_freqs(cur_set)=mean(response_win_freqs_10ms_spacing);
        response_win_freqsstd(cur_set)=std(response_win_freqs_10ms_spacingsingle);
        
        
    end
    
    elect(electrode).peakChan=rawdata.peakChans(Clust)
    
    %% whisk conditions 0 ms delay
    for condition=1
        
        condIdx=find(grid.stimGrid(:,3) == 100 & grid.stimGrid(:,5) == whiskvoltages(2) & grid.stimGrid(:,8) == lightvoltages (1) & grid.stimGrid(:,4) == 50);
        temp=((length(freqs))-1)*((length(levels))-1);
        if length(condIdx)==length(temp);
            disp('dimesions match')
        end
        n=0;
        for FreqCount=1:length(freqs)-1; % minus one bcause there is a spontanous activity sweep
            for levelCount=1:length(levels)-1; % minus one bcause there is a spontanous activity sweep
                n=n+1;
                elect(electrode).cond(condition).FRA(levelCount,FreqCount)=response_win_freqs(condIdx(n));
                elect(electrode).cond(condition).stdFRA(levelCount,FreqCount)=response_win_freqsstd(condIdx(n));
                
                elect(electrode).cond(condition).FRASingle(:,levelCount,FreqCount)=singlePSTHWindow(:,condIdx(n));
                elect(electrode).cond(condition).SpontSingle(levelCount,FreqCount)=mean(singlePSTHSpont(:,condIdx(n)));
                
                if levelCount== length(levels)-1
                    elect(electrode).cond(condition).PSTH80(FreqCount,:)=mean_PSTH_sets1ms(condIdx(n),:);
                    elect(electrode).cond(condition).stdPSTH80(FreqCount,:)=std_PSTH_sets1ms(condIdx(n),:);
                    
                end
                
            end
        end
        
        
    end
    
    %% whisk condition 50 ms delay
    for condition=2
        
        condIdx=find(grid.stimGrid(:,3) == 150 & grid.stimGrid(:,5) == whiskvoltages(2) & grid.stimGrid(:,8) == lightvoltages (1) & grid.stimGrid(:,4) == 50);
        temp=((length(freqs))-1)*((length(levels))-1);
        if length(condIdx)==length(temp);
            disp('dimesions match')
        end
        n=0;
        for FreqCount=1:length(freqs)-1; % minus one bcause there is a spontanous activity sweep
            for levelCount=1:length(levels)-1; % minus one bcause there is a spontanous activity sweep
                n=n+1;
                elect(electrode).cond(condition).FRA(levelCount,FreqCount)=response_win_freqs(condIdx(n));
                elect(electrode).cond(condition).stdFRA(levelCount,FreqCount)=response_win_freqsstd(condIdx(n));
                
                elect(electrode).cond(condition).FRASingle(:,levelCount,FreqCount)=singlePSTHWindow(:,condIdx(n));
                elect(electrode).cond(condition).SpontSingle(levelCount,FreqCount)=mean(singlePSTHSpont(:,condIdx(n)));
                
            end
        end
        
        
    end
    
    
    %% Visual light 0 ms delay
    for condition=3
        
        condIdx=find(grid.stimGrid(:,3) == 100 & grid.stimGrid(:,5) == whiskvoltages(1) & grid.stimGrid(:,8) == lightvoltages (2) & grid.stimGrid(:,4) == 50);
        temp=((length(freqs))-1)*((length(levels))-1);
        if length(condIdx)==length(temp);
            disp('dimesions match')
        end
        n=0;
        for FreqCount=1:length(freqs)-1; % minus one bcause there is a spontanous activity sweep
            for levelCount=1:length(levels)-1; % minus one bcause there is a spontanous activity sweep
                n=n+1;
                elect(electrode).cond(condition).FRA(levelCount,FreqCount)=response_win_freqs(condIdx(n));
                elect(electrode).cond(condition).stdFRA(levelCount,FreqCount)=response_win_freqsstd(condIdx(n));
                
                elect(electrode).cond(condition).FRASingle(:,levelCount,FreqCount)=singlePSTHWindow(:,condIdx(n));
                elect(electrode).cond(condition).SpontSingle(levelCount,FreqCount)=mean(singlePSTHSpont(:,condIdx(n)));
                
            end
        end
        
    end
    
    %% Visual light 50 ms delay
    for condition=4
        
        condIdx=find(grid.stimGrid(:,3) == 150 & grid.stimGrid(:,5) == whiskvoltages(1) & grid.stimGrid(:,8) == lightvoltages (2) & grid.stimGrid(:,4) == 50);
        temp=((length(freqs))-1)*((length(levels))-1);
        if length(condIdx)==length(temp);
            disp('dimesions match')
        end
        n=0;
        for FreqCount=1:length(freqs)-1; % minus one bcause there is a spontanous activity sweep
            for levelCount=1:length(levels)-1; % minus one bcause there is a spontanous activity sweep
                n=n+1;
                elect(electrode).cond(condition).FRA(levelCount,FreqCount)=response_win_freqs(condIdx(n));
                elect(electrode).cond(condition).stdFRA(levelCount,FreqCount)=response_win_freqsstd(condIdx(n));
                
                elect(electrode).cond(condition).FRASingle(:,levelCount,FreqCount)=singlePSTHWindow(:,condIdx(n));
                elect(electrode).cond(condition).SpontSingle(levelCount,FreqCount)=mean(singlePSTHSpont(:,condIdx(n)));
                
            end
        end
        
    end
    
    if ExpNo>61
        %% Visual light 100 ms delay
        for condition=5
            
            condIdx=find(grid.stimGrid(:,3) == 200 & grid.stimGrid(:,5) == whiskvoltages(1) & grid.stimGrid(:,8) == lightvoltages (2) & grid.stimGrid(:,4) == 50);
            temp=((length(freqs))-1)*((length(levels))-1);
            if length(condIdx)==length(temp);
                disp('dimesions match')
            end
            n=0;
            for FreqCount=1:length(freqs)-1; % minus one bcause there is a spontanous activity sweep
                for levelCount=1:length(levels)-1; % minus one bcause there is a spontanous activity sweep
                    n=n+1;
                    elect(electrode).cond(condition).FRA(levelCount,FreqCount)=response_win_freqs(condIdx(n));
                    elect(electrode).cond(condition).stdFRA(levelCount,FreqCount)=response_win_freqsstd(condIdx(n));
                    
                    elect(electrode).cond(condition).FRASingle(:,levelCount,FreqCount)=singlePSTHWindow(:,condIdx(n));
                    elect(electrode).cond(condition).SpontSingle(levelCount,FreqCount)=mean(singlePSTHSpont(:,condIdx(n)));
                    
                end
            end
            
        end
    end
    
    for condition=6 %control
        
        condIdx=find(grid.stimGrid(:,3) == 100 & grid.stimGrid(:,5) == whiskvoltages(1) & grid.stimGrid(:,8) == lightvoltages (1) & grid.stimGrid(:,4) == 50);
        
        
        
        temp=(length(freqs)-1)*(length(levels)-1);
        if length(condIdx)==length(temp);
            disp('dimesions match')
        end
        n=0;
        for FreqCount=1:length(freqs)-1; % minus one bcause there is a spontanous activity trial
            for levelCount=1:length(levels)-1; % minus one bcause there is a spontanous activity trial
                n=n+1;
                elect(electrode).cond(condition).FRA(levelCount,FreqCount)=response_win_freqs(condIdx(n));
                elect(electrode).cond(condition).stdFRA(levelCount,FreqCount)=response_win_freqsstd(condIdx(n));
                
                elect(electrode).cond(condition).FRASingle(:,levelCount,FreqCount)=singlePSTHWindow(:,condIdx(n));
                elect(electrode).cond(condition).SpontSingle(levelCount,FreqCount)=mean(singlePSTHSpont(:,condIdx(n)));
                
                if levelCount== length(levels)-1
                    elect(electrode).cond(condition).PSTH80(FreqCount,:)=mean_PSTH_sets1ms(condIdx(n),:);
                    elect(electrode).cond(condition).stdPSTH80(FreqCount,:)=std_PSTH_sets1ms(condIdx(n),:);
                    
                end
                
            end
        end
        
        [pT]=anova1([squeeze(elect(electrode).cond(condition).FRASingle(:,end-1,:)),squeeze(elect(electrode).cond(condition).FRASingle(:,end,:))]-mean(elect(electrode).cond(condition).SpontSingle(:)),[],'off');
        elect(electrode).cond(condition).pTune(1)=pT(1);
        pTAll(electrode)=pT(1);
        
        [val,BFId]=max(mean(elect(electrode).cond(6).FRA));
        BFCon(electrode)=freqs(BFId+1);
        subplot(8,8,iiii)
        
        pic=imagesc(elect(electrode).cond(condition).FRA);
        colormap('jet')
        set(gca,'Ydir','Normal')
        
    end
    if ExpNo<62
        cCount=0
        for c=[1 2 3 4 6]
            cCount=cCount+1
            TuneAll80(cCount,:)=elect(electrode).cond(c).FRA(end,:);
            TuneAll60(cCount,:)=elect(electrode).cond(c).FRA(end-1,:);
        end
        
    else
        cCount=0
        for c=[1 2 3 4 5 6]
            cCount=cCount+1
            TuneAll80(cCount,:)=elect(electrode).cond(c).FRA(end,:);
            TuneAll60(cCount,:)=elect(electrode).cond(c).FRA(end-1,:);
        end
        
    end
    
    [val,BF80AllId(electrode)]=max(mean(TuneAll80));
    [val,BF60AllId(electrode)]=max(mean(TuneAll60));
    
    
    BF80All(electrode)=freqs(BF80AllId(electrode)+1);
    BF60All(electrode)=freqs(BF60AllId(electrode)+1);
end

Exp(ExpCount).elect=elect;
Exp(ExpCount).pTAll=pTAll;
Exp(ExpCount).BFCon=BFCon;
Exp(ExpCount).BF80AllCond=BF80All;
Exp(ExpCount).BF60AllCond=BF60All;
Exp(ExpCount).BF80AllCondId=BF80AllId;
Exp(ExpCount).BF60AllCondId=BF60AllId;

