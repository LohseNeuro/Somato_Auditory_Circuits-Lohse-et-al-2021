%% Subcortical circuits mediate communication between primary sensory cortical areas
%% Lohse, M. Dahmen, J.C. Bajo, V.M. and King, A.J.
% Code written by Michael Lohse
% Nature CommunIcations Manuscript number: NCOMMS-20-34371

%% Find units with BFs significantly modulated by simultanous whisker deflection

% Test for units with BFs significantly modulated by simultanous whisker deflection
ii=0
for e=1:length(Exp)
    
    for n=1:length(Exp(e).LatPosClust)
        ii=ii+1
        clear Con Whisk repsA2
        Con=squeeze(Exp(e).elect(n).cond(6).FRASingle(:,end,:)) % extract Tones alone tuning curve
        Whisk=squeeze(Exp(e).elect(n).cond(1).FRASingle(:,end,:)) % extract Tones+whisker stim  tuning curve
        repsA2=size(Con,1) % find amount of repetitions pr condition
        
        [~,BFIDx]=max(smooth(mean([mean(Whisk);mean(Con)]),3)); % find BF
        
        [~,p(ii)]=ttest2(Whisk(:,BFIDx),Con(:,BFIDx)) % test whisker stim modulation of BF
    end
    
end

clear SigMGBmUnitsMain SigMGBmUnitsInteract SigMGBmUnitsMainCon SigMGBmUnitsMainWhisk SigMGBmUnitsMainFacIdx
SigMGBmUnitsMain=p(MGBmPINSGNGoodIndex)<0.05 % find units with significant p-values


%Extract significantly modulated units
SigMGBmUnitsMainCon=tuningfullAllCon(:,MGBmPINSGNGoodIndex(find(SigMGBmUnitsMain)));
SigMGBmUnitsMainWhisk=tuningfullWhiskAll(:,MGBmPINSGNGoodIndex(find(SigMGBmUnitsMain)));

% Index suppressed and faciliated units
SigMGBmUnitsMainFacIdx=find((tuningfullWhiskAll(26,MGBmPINSGNGoodIndex(find(SigMGBmUnitsMain)))-tuningfullAllCon(26,MGBmPINSGNGoodIndex(find(SigMGBmUnitsMain))))>0)
SigMGBmUnitsMainDeppIdx=find((tuningfullWhiskAll(26,MGBmPINSGNGoodIndex(find(SigMGBmUnitsMain)))-tuningfullAllCon(26,MGBmPINSGNGoodIndex(find(SigMGBmUnitsMain))))<0)


% Bootstrap summary tuning curves fro suppressed and facilitated units, to
% get 95% confidecnce interval
for f=1:39
    disp(f)
    [MGBmFac95CIHighCon(f),MGBmFac95CILowCon(f),MGBmFacConMed(f)]=NonPar_BootCI(SigMGBmUnitsMainCon(f,SigMGBmUnitsMainFacIdx),95,10000);
    [MGBmFac95CIHighWhisk(f),MGBmFac95CILowWhisk(f),MGBmFacWhiskMed(f)]=NonPar_BootCI(SigMGBmUnitsMainWhisk(f,SigMGBmUnitsMainFacIdx),95,10000);
    
    [MGBmDepp95CIHighCon(f),MGBmDepp95CILowCon(f),MGBmDeppConMed(f)]=NonPar_BootCI(SigMGBmUnitsMainCon(f,SigMGBmUnitsMainDeppIdx),95,10000);
    [MGBmDepp95CIHighWhisk(f),MGBmDepp95CILowWhisk(f),MGBmDeppWhiskMed(f)]=NonPar_BootCI(SigMGBmUnitsMainWhisk(f,SigMGBmUnitsMainDeppIdx),95,10000);
end

ErrorbarsMGBmFacCon=abs([MGBmFac95CIHighCon-MGBmFacConMed;MGBmFac95CILowCon-MGBmFacConMed])
ErrorbarsMGBmFacWhisk=abs([MGBmFac95CIHighWhisk-MGBmFacWhiskMed;MGBmFac95CILowWhisk-MGBmFacWhiskMed])


%% Plot tuning curves from singificantly modulated MGBm/PIN/SGN units

figure(40)
subplot(2,1,1)
shadedErrorBar(-5:.2:2.6,nanmedian(SigMGBmUnitsMainCon(:,SigMGBmUnitsMainFacIdx),2)',ErrorbarsMGBmFacCon,{'linewidth',2.5,'color',[0 .447 .698]},1)
hold on
shadedErrorBar(-5:.2:2.6,nanmedian(SigMGBmUnitsMainWhisk(:,SigMGBmUnitsMainFacIdx),2)',ErrorbarsMGBmFacWhisk,{'linewidth',2.5,'color',[.835 .3686 0]},1)
box off
title(sprintf('%d Medial units facilitated of %d medial units', length(SigMGBmUnitsMainFacIdx),length(MGBmPINSGNGoodIndex)))
xlim([-2.5 2.5])
ylabel('Norm. firing rate')
xlabel('Distance from BF (Oct)')
set(gca,'linewidth',1.4)

subplot(2,1,2)
ErrorbarsMGBmDeppCon=abs([MGBmDepp95CIHighCon-MGBmDeppConMed;MGBmDepp95CILowCon-MGBmDeppConMed])
ErrorbarsMGBmDeppWhisk=abs([MGBmDepp95CIHighWhisk-MGBmDeppWhiskMed;MGBmDepp95CILowWhisk-MGBmDeppWhiskMed])

shadedErrorBar(-5:.2:2.6,nanmedian(SigMGBmUnitsMainCon(:,SigMGBmUnitsMainDeppIdx),2)',ErrorbarsMGBmDeppCon,{'linewidth',2.5,'color',[0 .447 .698]},1)
hold on
shadedErrorBar(-5:.2:2.6,nanmedian(SigMGBmUnitsMainWhisk(:,SigMGBmUnitsMainDeppIdx),2)',ErrorbarsMGBmDeppWhisk,{'linewidth',2.5,'color',[.835 .3686 0]},1)
box off
title(sprintf('%d Medial units suppressed of %d medial units', length(SigMGBmUnitsMainDeppIdx),length(MGBmPINSGNGoodIndex)))
xlim([-2.5 2.5])
ylabel('Norm. firing rate')
xlabel('Distance from BF (Oct)')
set(findall(gcf,'-property','FontSize'),'FontSize',20)
set(gca,'linewidth',1.4)
set(gcf,'Renderer', 'painters', 'Position', [100 100 500 1000])


