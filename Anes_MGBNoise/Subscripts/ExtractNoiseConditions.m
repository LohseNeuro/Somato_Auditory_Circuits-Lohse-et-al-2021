%% Subcortical circuits mediate communication between primary sensory cortical areas
%% Lohse, M. Dahmen, J.C. Bajo, V.M. and King, A.J.
% Code written by Michael Lohse
% Nature CommunIcations Manuscript number: NCOMMS-20-34371

% Extract responses and plot results for noise and whisker responses in
% MGBv and MGBd (supp fig 3)


ii=0 % counter
for e=1:11 % a total of 11 penetrations across all animals in which noise and whisker interactions were assessed in MGBv/d
    iii=0
    
    %% Extract recording position
    Exp(e).LatPosClust=rand(length([Exp(e).elect.peakChan]),1)'+Exp(e).LatPos([Exp(e).elect.peakChan]);
    Exp(e).VenPosClust=rand(length([Exp(e).elect.peakChan]),1)'+Exp(e).VenPos([Exp(e).elect.peakChan]);
    
    clear N80Id N60Id NW80Id NW60Id
    
    %% Extract condition indexes
    WId=find(Exp(e).stimGrid(:,2) == 250 & Exp(e).stimGrid(:,4) == 9 & Exp(e).stimGrid(:,7) == 0 & Exp(e).stimGrid(:,10) == 80); % whisker stimulatio alone condition (i.e. a noise stimulation also comes on several hundreds of milliseconds later)
    if isempty(WId)
        WId=find(Exp(e).stimGrid(:,2) == 250 & Exp(e).stimGrid(:,4) == 9 & Exp(e).stimGrid(:,7) == 0 & Exp(e).stimGrid(:,10) == 60); % in case there is only 60dB condition
    end
    N80Id=find(Exp(e).stimGrid(:,2) == 300 & Exp(e).stimGrid(:,4) == 0 & Exp(e).stimGrid(:,7) == 0 & Exp(e).stimGrid(:,10) == 80); % 80 dB noise alone
    N60Id=find(Exp(e).stimGrid(:,2) == 300 & Exp(e).stimGrid(:,4) == 0 & Exp(e).stimGrid(:,7) == 0 & Exp(e).stimGrid(:,10) == 60); % 60 dB noise alone
    NW80Id=find(Exp(e).stimGrid(:,2) == 100 & Exp(e).stimGrid(:,4) == 9 & Exp(e).stimGrid(:,7) == 0 & Exp(e).stimGrid(:,10) == 80); % 80 dB noise and whisker stim
    NW60Id=find(Exp(e).stimGrid(:,2) == 100 & Exp(e).stimGrid(:,4) == 9 & Exp(e).stimGrid(:,7) == 0 & Exp(e).stimGrid(:,10) == 60); % 60 dB noise and whisker stim
    
    % Indexes for conditions with different noise and whisker stim SOA
    k=0
    for T=[125 150 200 250 350]
        k=k+1
        NW80IdDelay{k}=find(Exp(e).stimGrid(:,2) == T & Exp(e).stimGrid(:,4) == 9 & Exp(e).stimGrid(:,7) == 0 & Exp(e).stimGrid(:,10) == 80);
        NW60IdDelay{k}=find(Exp(e).stimGrid(:,2) == T & Exp(e).stimGrid(:,4) == 9 & Exp(e).stimGrid(:,7) == 0 & Exp(e).stimGrid(:,10) == 60);
    end
    
    
    %% Extract responses from all conditions
    for Clust=1:length(Exp(e).elect)
        ii=ii+1;
        iii=iii+1;
        for Ds=1:5
            if isempty(N80Id)
                pTAll60(ii)=Exp(e).elect(Clust).p(N60Id);
                pTAll80(ii)=NaN;
                
                pTAll80Cell{e}(iii)=NaN;
                pTAll60Cell{e}(iii)=Exp(e).elect(Clust).p(N60Id);
                
                W(ii,:)=NaN(1,700);
                
                N60(ii,:)=Exp(e).elect(Clust).PSTH(N60Id,:);
                NW60(ii,:)=Exp(e).elect(Clust).PSTH(NW60Id,:);
                N80(ii,:)=NaN(1,700);
                NW80(ii,:)=NaN(1,700);
                
                sem_N60(ii,:)=Exp(e).elect(Clust).sem_PSTH(N60Id,:);
                sem_NW60(ii,:)=Exp(e).elect(Clust).sem_PSTH(NW60Id,:);
                sem_N80(ii,:)=NaN(1,700);
                sem_NW80(ii,:)=NaN(1,700);
                
                NW60Delay(ii,:,Ds)=Exp(e).elect(Clust).PSTH(NW60IdDelay{Ds},:);
                sem_NW60Delay(ii,:,Ds)=Exp(e).elect(Clust).sem_PSTH(NW60IdDelay{Ds},:);
                
                NW80Delay(ii,:,Ds)=NaN(1,700);
                sem_NW80Delay(ii,:,Ds)=NaN(1,700);
                
            elseif isempty(N60Id)
                pTAll80(ii)=Exp(e).elect(Clust).p(N80Id);
                pTAll60(ii)=NaN;
                
                pTAll80Cell{e}(iii)=Exp(e).elect(Clust).p(N80Id);
                pTAll60Cell{e}(iii)=NaN;
                
                W(ii,:)=Exp(e).elect(Clust).PSTH(WId,:);
                
                N80(ii,:)=Exp(e).elect(Clust).PSTH(N80Id,:);
                NW80(ii,:)=Exp(e).elect(Clust).PSTH(NW80Id,:);
                N60(ii,:)=NaN(1,700);
                NW60(ii,:)=NaN(1,700);
                
                sem_N80(ii,:)=Exp(e).elect(Clust).sem_PSTH(N80Id,:);
                sem_NW80(ii,:)=Exp(e).elect(Clust).sem_PSTH(NW80Id,:);
                sem_N60(ii,:)=NaN(1,700);
                sem_NW60(ii,:)=NaN(1,700);
                
                NW80Delay(ii,:,Ds)=Exp(e).elect(Clust).PSTH(NW80IdDelay{Ds},:);
                sem_NW80Delay(ii,:,Ds)=Exp(e).elect(Clust).sem_PSTH(NW80IdDelay{Ds},:);
                
                NW60Delay(ii,:,Ds)=NaN(1,700);
                sem_NW60Delay(ii,:,Ds)=NaN(1,700);
                
            else
                pTAll60(ii)=Exp(e).elect(Clust).p(N60Id);
                pTAll80(ii)=Exp(e).elect(Clust).p(N80Id);
                
                pTAll80Cell{e}(iii)=Exp(e).elect(Clust).p(N80Id);
                pTAll60Cell{e}(iii)=Exp(e).elect(Clust).p(N60Id);
                
                W(ii,:)=Exp(e).elect(Clust).PSTH(WId,:);
                
                N80(ii,:)=Exp(e).elect(Clust).PSTH(N80Id,:);
                N60(ii,:)=Exp(e).elect(Clust).PSTH(N60Id,:);
                NW80(ii,:)=Exp(e).elect(Clust).PSTH(NW80Id,:);
                NW60(ii,:)=Exp(e).elect(Clust).PSTH(NW60Id,:);
                
                sem_N80(ii,:)=Exp(e).elect(Clust).sem_PSTH(N80Id,:);
                sem_NW80(ii,:)=Exp(e).elect(Clust).sem_PSTH(NW80Id,:);
                sem_N60(ii,:)=Exp(e).elect(Clust).sem_PSTH(N60Id,:);
                sem_NW60(ii,:)=Exp(e).elect(Clust).sem_PSTH(NW60Id,:);
                
                NW80Delay(ii,:,Ds)=Exp(e).elect(Clust).PSTH(NW80IdDelay{Ds},:);
                sem_NW80Delay(ii,:,Ds)=Exp(e).elect(Clust).sem_PSTH(NW80IdDelay{Ds},:);
                
                NW60Delay(ii,:,Ds)=Exp(e).elect(Clust).PSTH(NW60IdDelay{Ds},:);
                sem_NW60Delay(ii,:,Ds)=Exp(e).elect(Clust).sem_PSTH(NW60IdDelay{Ds},:);
            end
        end
    end
end


%% positions for all units in single vector
LatPosAllFull=[Exp(:).LatPosClust]
VenPosAllFull=[Exp(:).VenPosClust]

%% MGBv responses only

MGBvGoodIndex80=find(LatPosAllFull<500 & VenPosAllFull<500 & pTAll80<Thresh) % all MGBv units responding to 80dB noise
MGBvGoodIndex60=find(LatPosAllFull<500 & VenPosAllFull<500 & pTAll60<Thresh) % all MGBv units responding to 60dB noise

MGBvRepsSpont=nanmean(W(MGBvGoodIndex80,10:99)') % extracting baseline activity
MGBvRepsW=nanmean(W(MGBvGoodIndex80,101:150)') % extracting response to whisker deflection around stimulation window
MGBv80RepsN=nanmean(N80(MGBvGoodIndex80,301:350)') % extracting response to 80dB noise around stimulation window
MGBv80RepsNW=nanmean(NW80(MGBvGoodIndex80,101:150)') % extracting response to 80dB noise combined with simultanous whisker deflection around stimulation window
MGBv60RepsN=nanmean(N60(MGBvGoodIndex60,301:350)') % extracting response to 60dB noise around stimulation window
MGBv60RepsNW=nanmean(NW60(MGBvGoodIndex60,101:150)') % extracting response to 60dB noise combined with simultanous whisker deflection around stimulation window

%% Normalized response to noise and whisker stimulaion combined, compared to noise alone for MGBv units for noise stimulation at different SOAs (see supp fig 3)

MGBv80RepsNWDelayNorm(1,:)=MGBv80RepsNW./MGBv80RepsN; % Normalized response to noise and simultanous whisker stimulaion combined, compared to noise alone for MGBv units for 80 dB noise stimulation (see supp fig 3)
MGBv60RepsNWDelayNorm(1,:)=MGBv60RepsNW./MGBv60RepsN; % Normalized response to noise and simultanous whisker stimulaion combined, compared to noise alone for MGBv units for 60 dB noise stimulation (see supp fig 3)

DsWindows={126:175,151:200,201:250,251:300,351:400} % response windows for different SOAs (see supp fig 3)
for k=1:5
    MGBv80RepsNWDelay(k,:)=nanmean(squeeze(NW80Delay(MGBvGoodIndex80,DsWindows{k},k))')
    MGBv60RepsNWDelay(k,:)=nanmean(squeeze(NW60Delay(MGBvGoodIndex60,DsWindows{k},k))')
    
    MGBv80RepsNWDelayNorm(k+1,:)=nanmean(squeeze(NW80Delay(MGBvGoodIndex80,DsWindows{k},k))')./MGBv80RepsN;
    MGBv60RepsNWDelayNorm(k+1,:)=nanmean(squeeze(NW60Delay(MGBvGoodIndex60,DsWindows{k},k))')./MGBv60RepsN;
    
    
end

% median and 95% CI
for k=1:6
    [UPPER80(k) LOWER80(k) MEDIAN80(k)]=NonPar_BootCI(MGBv80RepsNWDelayNorm(k,:),95, 10000)
    [UPPER60(k) LOWER60(k) MEDIAN60(k)]=NonPar_BootCI(MGBv60RepsNWDelayNorm(k,:),95, 10000)
    
end

% For plots with diffrent SOAs
UP80=UPPER80-MEDIAN80;
UP60=UPPER60-MEDIAN60;
LOW80=LOWER80-MEDIAN80;
LOW60=LOWER60-MEDIAN60;

%% MGBv panels

% Plot scatter showing response to noise and whisker stimulaion combined, compared to noise alone for MGBv units at different SOAs (see supp fig 3)

figure(10)
subplot(4,3,[3 6])
Times=[0 25 50 100 150 250]

errorbar(Times+5,MEDIAN60,UP60,LOW60,'color','b','linewidth',3)
hold on
errorbar(Times,MEDIAN80,UP80,LOW80,'k','linewidth',3)
ylim([0 1.35])
xlim([-10 260])
box off


figure(10)
subplot(4,3,[2 5])
scatter(MGBv60RepsN,MGBv60RepsNW,'filled','b')
lsline
hold on
scatter(MGBv80RepsN,MGBv80RepsNW,'filled','k')
lsline
line([0 300], [0 300],'linestyle','--','linewidth',2,'color','r')
xlim([0 300])
ylim([0 300])


set(findall(gcf,'-property','FontSize'),'FontSize',23)
set(gca,'linewidth',1.4)

% Example PSTHs for 80 dB
n=16 % example selected

figure(10)
subplot(4,3,[4])
shadedErrorBar(-299:400,smooth(N80(MGBvGoodIndex80(n),:),10),smooth(sem_N80(MGBvGoodIndex80(n),:),10),{'color','k','linewidth',2},1)
hold on
shadedErrorBar(-99:600,smooth(NW80(MGBvGoodIndex80(n),:),10),smooth(sem_NW80(MGBvGoodIndex80(n),:),10),{'color',[213 94 0]/255,'linewidth',2},1)
xlim([-49 300])
set(findall(gcf,'-property','FontSize'),'FontSize',23)
set(gca,'linewidth',1.4)
box off

% Example PSTHs for 60 dB
figure(10)
subplot(4,3,[1])
shadedErrorBar(-299:400,smooth(N60(MGBvGoodIndex60(n),:),10),smooth(sem_N60(MGBvGoodIndex60(n),:),10),{'color','k','linewidth',2},1)
hold on
shadedErrorBar(-99:600,smooth(NW60(MGBvGoodIndex60(n),:),10),smooth(sem_NW60(MGBvGoodIndex60(n),:),10),{'color',[213 94 0]/255,'linewidth',2},1)
xlim([-49 300])
set(findall(gcf,'-property','FontSize'),'FontSize',23)
set(gca,'linewidth',1.4)
box off


%% MGBd responses only (same code as for MGBv responses, but using the MGBd units)

MGBdGoodIndex80=find(LatPosAllFull<500 & VenPosAllFull>500 & pTAll80<Thresh)
MGBdGoodIndex60=find(LatPosAllFull<500 & VenPosAllFull>500 & pTAll60<Thresh)

MGBdRepsSpont=nanmean(W(MGBdGoodIndex80,10:99)')

MGBdRepsW=nanmean(W(MGBdGoodIndex80,101:150)')

MGBd80RepsN=nanmean(N80(MGBdGoodIndex80,301:350)')
MGBd80RepsNW=nanmean(NW80(MGBdGoodIndex80,101:150)')
MGBd60RepsN=nanmean(N60(MGBdGoodIndex60,301:350)')
MGBd60RepsNW=nanmean(NW60(MGBdGoodIndex60,101:150)')

MGBd80RepsNWDelayNorm(1,:)=MGBd80RepsNW./MGBd80RepsN;
MGBd60RepsNWDelayNorm(1,:)=MGBd60RepsNW./MGBd60RepsN;

for k=1:5
    
    MGBd80RepsNWDelayNorm(k+1,:)=nanmean(squeeze(NW80Delay(MGBdGoodIndex80,DsWindows{k},k))')./MGBd80RepsN;
    MGBd60RepsNWDelayNorm(k+1,:)=nanmean(squeeze(NW60Delay(MGBdGoodIndex60,DsWindows{k},k))')./MGBd60RepsN;
    
    
end

for k=1:6 %median and confidence intervals for multiple SOAs
    [UPPER80(k) LOWER80(k) MEDIAN80(k)]=NonPar_BootCI(MGBd80RepsNWDelayNorm(k,:),95, 10000)
    [UPPER60(k) LOWER60(k) MEDIAN60(k)]=NonPar_BootCI(MGBd60RepsNWDelayNorm(k,:),95, 10000)
    
end

UP80=UPPER80-MEDIAN80;
UP60=UPPER60-MEDIAN60;
LOW80=LOWER80-MEDIAN80;
LOW60=LOWER60-MEDIAN60;

%% MGBd figures (same code as for MGBv figures, but using the MGBd units)

figure(10)
subplot(4,3,[9 12])
Times=[0 25 50 100 150 250]

errorbar(Times+5,MEDIAN60,UP60,LOW60,'color','b','linewidth',3)
hold on
errorbar(Times,MEDIAN80,UP80,LOW80,'k','linewidth',3)
ylim([0 1.35])

xlim([-10 260])
box off
set(gca,'linewidth',1.4)

figure(10)
subplot(4,3,[8 11])
scatter(MGBd60RepsN,MGBd60RepsNW,'filled','b')
lsline
hold on
scatter(MGBd80RepsN,MGBd80RepsNW,'filled','k')
lsline
line([0 300], [0 300],'linestyle','--','linewidth',2,'color','r')
xlim([0 150])
ylim([0 150])

set(findall(gcf,'-property','FontSize'),'FontSize',23)
set(gca,'linewidth',1.4)

% Example PSTHs
n=10 % example selected

figure(10)
subplot(4,3,[10])
shadedErrorBar(-299:400,smooth(N80(MGBdGoodIndex80(n),:),10),smooth(sem_N80(MGBdGoodIndex80(n),:),10),{'color','k','linewidth',2},1)
hold on
shadedErrorBar(-99:600,smooth(NW80(MGBdGoodIndex80(n),:),10),smooth(sem_NW80(MGBdGoodIndex80(n),:),10),{'color',[213 94 0]/255,'linewidth',2},1)
xlim([-49 300])
set(findall(gcf,'-property','FontSize'),'FontSize',23)
set(gca,'linewidth',1.4)
box off

figure(10)
subplot(4,3,[7])
shadedErrorBar(-299:400,smooth(N60(MGBdGoodIndex60(n),:),10),smooth(sem_N60(MGBdGoodIndex60(n),:),10),{'color','k','linewidth',2},1)
hold on
shadedErrorBar(-99:600,smooth(NW60(MGBdGoodIndex60(n),:),10),smooth(sem_NW60(MGBdGoodIndex60(n),:),10),{'color',[213 94 0]/255,'linewidth',2},1)
xlim([-49 300])
set(findall(gcf,'-property','FontSize'),'FontSize',23)
set(gca,'linewidth',1.4)
box off



