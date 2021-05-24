%% Subcortical circuits mediate communication between primary sensory cortical areas
%% Lohse, M. Dahmen, J.C. Bajo, V.M. and King, A.J.
% Code written by Michael Lohse
% Nature CommunIcations Manuscript number: NCOMMS-20-34371

%% Testing amount of significantly modulated units
%clearvars -except elect Exp ExpCount ExpNo attenuation Thresh BasicExtract
%close all
expselect=[1:11]
for e=expselect
    for elec=1:length(Exp(e).elect)
        
        Con80{e}(:,elec)=Exp(e).elect(elec).cond(6).FRASingle(1:15,end,Exp(e).BF80AllCondId(elec));
        Con60{e}(:,elec)=Exp(e).elect(elec).cond(6).FRASingle(1:15,end,Exp(e).BF60AllCondId(elec));
        
        Con80PSTHBF{e}(:,elec)=Exp(e).elect(elec).cond(6).PSTH80(Exp(e).BF80AllCondId(elec),:);
        Whisk80PSTHBF{e}(:,elec)=Exp(e).elect(elec).cond(1).PSTH80(Exp(e).BF80AllCondId(elec),:);
        
        Con80stdPSTHBF{e}(:,elec)=Exp(e).elect(elec).cond(6).stdPSTH80(Exp(e).BF80AllCondId(elec),:);
        Whisk80stdPSTHBF{e}(:,elec)=Exp(e).elect(elec).cond(1).stdPSTH80(Exp(e).BF80AllCondId(elec),:);
        
        Whisk80{e}(:,elec)=Exp(e).elect(elec).cond(1).FRASingle(1:15,end,Exp(e).BF80AllCondId(elec));
        Whisk60{e}(:,elec)=Exp(e).elect(elec).cond(1).FRASingle(1:15,end,Exp(e).BF60AllCondId(elec));
        
        ConTun80Single{e}(:,:,elec)=squeeze(Exp(e).elect(elec).cond(6).FRASingle(1:15,end,:))
        WhiskTun80Single{e}(:,:,elec)=squeeze(Exp(e).elect(elec).cond(1).FRASingle(1:15,end,:))
        
    end
end

pTAllFull=[Exp(expselect).pTAll];

Include=find(pTAllFull<Thresh);

ConTun80SingleFull=cat(3,ConTun80Single{1:10});
WhiskTun80SingleFull=cat(3,WhiskTun80Single{1:10});

ConTun80SingleGood=ConTun80SingleFull(:,:,Include(1:170))
WhiskTun80SingleGood=WhiskTun80SingleFull(:,:,Include(1:170))
Con80BFPSTHFull=[Con80PSTHBF{:}];
Whisk80BFPSTHFull=[Whisk80PSTHBF{:}];

Con80BFPSTHFullGood=Con80BFPSTHFull(:,Include);
Whisk80BFPSTHFullGood=Whisk80BFPSTHFull(:,Include);

Con80BFstdPSTHFull=[Con80stdPSTHBF{:}];
Whisk80BFstdPSTHFull=[Whisk80stdPSTHBF{:}];

Con80BFstdPSTHFullGood=Con80BFstdPSTHFull(:,Include);
Whisk80BFstdPSTHFullGood=Whisk80BFstdPSTHFull(:,Include);

Con80Full=[Con80{expselect}];
Con60Full=[Con60{expselect}];

Whisk80Full=[Whisk80{expselect}];
Whisk60Full=[Whisk60{expselect}];

LatPosAllFull=[Exp(expselect).LatPos];
VenPosAllFull=[Exp(expselect).VenPos];


Con80FullGood=Con80Full(:,Include);
Con60FullGood=Con60Full(:,Include);

Whisk80FullGood=Whisk80Full(:,Include);
Whisk60FullGood=Whisk60Full(:,Include);

PosAll=LatPosAllFull(Include);
PosAllDV=VenPosAllFull(Include);

clear Good
for Good=1:length(PosAll)
    [hW_80(Good),pW_80(Good)]=ttest2(Whisk80FullGood(:,Good),Con80FullGood(:,Good));
    DiffWhisk_80(Good)=mean(Whisk80FullGood(:,Good))-mean(Con80FullGood(:,Good));
    
end


SigDiff=DiffWhisk_80(find(hW_80));
SigPosAll=PosAll(find(hW_80));
SigPosDVAll=PosAllDV(find(hW_80));

MGBvUnitsIdx=(find(PosAll<500 & PosAllDV<500))
MGBdUnitsIdx=(find(PosAll<500 & PosAllDV>500))


MGBvUnits=length(find(PosAll<500 & PosAllDV<500))

SigDiffMGBv=SigDiff(find(SigPosAll<500 & SigPosDVAll<500));
SigSuppMGBv=SigDiffMGBv(SigDiffMGBv<0);
PercMGBvSuppressed=length(SigSuppMGBv)/MGBvUnits

MGBmPINUnitsIdx=(find(PosAll>499 & PosAllDV<500))
SGNUnitsIdx=(find(PosAll>499 & PosAllDV>500))

MGBm_PINUnits=length(find(PosAll>499));% & PosAllDV<500))
SigDiffMGBm_PINUnits=SigDiff(find(SigPosAll>499));% & SigPosDVAll<500))
SigFacMGBm_PINUnits=SigDiffMGBm_PINUnits(SigDiffMGBm_PINUnits>0);





PercMGBmPINFacil=length(SigFacMGBm_PINUnits)/MGBm_PINUnits

SigModIdx=find(hW_80);

figure(10)
n=0
for i=125
    if sum(i== find(hW_80))>0
        n=n+1;
        subplot(6,3,[5])
        
        shadedErrorBar([1:350]-100,smooth(Con80BFPSTHFullGood(1:350,i),10),smooth(Con80BFstdPSTHFullGood(1:350,i),10)./sqrt(15),{'linewidth',2,'color','k'},1)
        hold on
        shadedErrorBar([1:350']-100,smooth(Whisk80BFPSTHFullGood(1:350,i),10),smooth(Whisk80BFstdPSTHFullGood(1:350,i),10)./sqrt(15),{'linewidth',2,'color','r'},1)
        xlim([-50 150])
        ylim([0 400])
        set(findall(gca,'-property','linewidth'),'linewidth',1.75)
        
        box off
    else
    end
    
end

figure(10)
n=0
for i=115
    if sum(i== find(hW_80))>0
        n=n+1;
        subplot(6,3,[2])
        
        shadedErrorBar([1:350']-100,smooth(Con80BFPSTHFullGood(1:350,i),10),smooth(Con80BFstdPSTHFullGood(1:350,i),10)./sqrt(15),{'linewidth',2,'color','k'},1)
        hold on
        shadedErrorBar([1:350']-100,smooth(Whisk80BFPSTHFullGood(1:350,i),10),smooth(Whisk80BFstdPSTHFullGood(1:350,i),10)./sqrt(15),{'linewidth',2,'color','r'},1)
        xlim([-50 150])
        ylim([0 400])
        set(findall(gca,'-property','linewidth'),'linewidth',1.75)
        
        box off
    else
    end
    
end

figure(10)
subplot(6,3,[13 16])
shadedErrorBar(1:26,smooth(mean(ConTun80SingleGood(:,:,125)),3)',smooth((std(ConTun80SingleGood(:,:,125))./sqrt(15))*2,3)',{'linewidth',2,'color','k'},1)
hold on
shadedErrorBar(1:26,smooth(mean(WhiskTun80SingleGood(:,:,125)),3)',smooth((std(ConTun80SingleGood(:,:,125))./sqrt(15))*2,3)',{'linewidth',2,'color','r'},1)
xticks([1:5:26])
xticklabels({2,4,8,16,32,64})
xlim([1 26])
set(gca,'linewidth',1.4)
ylim([0 100])
xlabel('Frequency (kHz)')
ylabel('Firing Rate (Sp/S)')


box off
figure(10)
subplot(6,3,[7 10])
shadedErrorBar(1:26,smooth(mean(ConTun80SingleGood(:,:,115)),3)',smooth((std(ConTun80SingleGood(:,:,115))./sqrt(15))*2,3)',{'linewidth',2,'color','k'},1)
hold on
shadedErrorBar(1:26,smooth(mean(WhiskTun80SingleGood(:,:,115)),3)',smooth((std(ConTun80SingleGood(:,:,115))./sqrt(15))*2,3)',{'linewidth',2,'color','r'},1)
xticks([1:5:26])
xticklabels({2,4,8,16,32,64})
xlim([1 26])
ylim([0 50])
box off
set(findall(gcf,'-property','FontSize'),'FontSize',20)
set(gca,'linewidth',1.4)

MGBvConTuning=tuningfullAllCon(:,MGBvGoodIndex)'
MGBdConTuning=tuningfullAllCon(:,MGBdGoodIndex)'
MGBvWhiskTuning=tuningfullWhiskAll(:,MGBvGoodIndex)'
MGBdWhiskTuning=tuningfullWhiskAll(:,MGBdGoodIndex)'




