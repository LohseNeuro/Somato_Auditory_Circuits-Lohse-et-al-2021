%% Subcortical circuits mediate communication between primary sensory cortical areas
%% Lohse, M. Dahmen, J.C. Bajo, V.M. and King, A.J.
% Code written by Michael Lohse
% Nature CommunIcations Manuscript number: NCOMMS-20-34371

%% Create summary frequency tuning curves with and without simulatous whisker stimulation for auditory thalamus

% Find indexes for MGBv and MGBd 
MGBvGoodIndex=find(LatPosAllFull<500 & VenPosAllFull<500 & pTAllFull<Thresh)
MGBdGoodIndex=find(LatPosAllFull<500 & VenPosAllFull>500 & pTAllFull<Thresh)
MGBmPINSGNGoodIndex=find(LatPosAllFull>499 & pTAllFull<Thresh)

%% Run bootstrap to estimate 95% confidence interval of tuning curves for each subsection
%% of auditory thalamus
clear  medianDistMGBvCon medianDistMGBvWhisk medianDistMGBdCon medianDistMGBdWhisk medianDistMGBmCon medianDistMGBmWhisk medianDistSGNCon medianDistSGNWhisk
CIrange=[250 9750] % this is 95% CI because we resample 10000 times
for f=1:39
    disp(f)
    
    for n=1:10000 % 10000 resamples
        Sv=size(tuningfullAllCon(f,MGBvGoodIndex),2);
        randIdxMGBv=randi(Sv,1,Sv);
        
        Sd=size(tuningfullAllCon(f,MGBdGoodIndex),2);
        randIdxMGBd=randi(Sd,1,Sd);
        
        medianDistMGBvCon(n,f)=nanmedian(tuningfullAllCon(f,MGBvGoodIndex(randIdxMGBv)));
        medianDistMGBvWhisk(n,f)=nanmedian(tuningfullWhiskAll(f,MGBvGoodIndex(randIdxMGBv)));
        
        medianDistMGBdCon(n,f)=nanmedian(tuningfullAllCon(f,MGBdGoodIndex(randIdxMGBd)));
        medianDistMGBdWhisk(n,f)=nanmedian(tuningfullWhiskAll(f,MGBdGoodIndex(randIdxMGBd)));
           
    end
    clear MGBvSortCon MGBdSortCon MGBmSortCon SGNSortCon MGBvSortWhisk MGBdSortWhisk MGBmSortWhisk SGNSortWhisk
    MGBvSortCon=sort(medianDistMGBvCon(:,f));
    MGBv95CIHighCon(f)=sort(MGBvSortCon(CIrange(2)));
    MGBv95CILowCon(f)=sort(MGBvSortCon(CIrange(1)));
    
    MGBvSortWhisk=sort(medianDistMGBvWhisk(:,f));
    MGBv95CIHighWhisk(f)=sort(MGBvSortWhisk(CIrange(2)));
    MGBv95CILowWhisk(f)=sort(MGBvSortWhisk(CIrange(1)));
    
    MGBdSortCon=sort(medianDistMGBdCon(:,f));
    MGBd95CIHighCon(f)=sort(MGBdSortCon(CIrange(2)));
    MGBd95CILowCon(f)=sort(MGBdSortCon(CIrange(1)));
    
    MGBdSortWhisk=sort(medianDistMGBdWhisk(:,f));
    MGBd95CIHighWhisk(f)=sort(MGBdSortWhisk(CIrange(2)));
    MGBd95CILowWhisk(f)=sort(MGBdSortWhisk(CIrange(1)));

end

%% Plot summary tuning curves with and without whiskers for each subbsection of auditory thalamus
figure(10)
subplot(6,3,[14 17])
MGBvConMed=nanmedian(tuningfullAllCon(:,MGBvGoodIndex)')
MGBvWhiskMed=nanmedian(tuningfullWhiskAll(:,MGBvGoodIndex)')
shadedErrorBar(-5:.2:2.6,MGBvConMed,abs([MGBv95CIHighCon-MGBvConMed;MGBv95CILowCon-MGBvConMed]),{'linewidth',2,'color','k'},1)
hold on
shadedErrorBar(-5:.2:2.6,MGBvWhiskMed,abs([MGBv95CIHighWhisk-MGBvWhiskMed;MGBv95CILowWhisk-MGBvWhiskMed]),{'linewidth',2,'color','r'},1)
xlim([-2.5 2.5])
box off
xlabel('Distance from BF (Octaves)')
ylabel('Normalised firing rate')
ylim([-0 1.1])
set(gca,'linewidth',1.4)

subplot(6,3,[8 11])
MGBdConMed=nanmedian(tuningfullAllCon(:,MGBdGoodIndex)')
MGBdWhiskMed=nanmedian(tuningfullWhiskAll(:,MGBdGoodIndex)')
shadedErrorBar(-5:.2:2.6,MGBdConMed,abs([MGBd95CIHighCon-MGBdConMed;MGBd95CILowCon-MGBdConMed]),{'linewidth',2,'color','k'},1)
hold on
shadedErrorBar(-5:.2:2.6,MGBdWhiskMed,abs([MGBd95CIHighWhisk-MGBdWhiskMed;MGBd95CILowWhisk-MGBdWhiskMed]),{'linewidth',2,'color','r'},1)
xlim([-2.5 2.5])
box off
ylim([-0 1.1])
set(gca,'linewidth',1.4)


%% Test siginficance of BF modulation on MGBv
MGBvsample=(tuningfullWhiskAll(26,MGBvGoodIndex)'-tuningfullAllCon(26,MGBvGoodIndex)')./tuningfullAllCon(26,MGBvGoodIndex)'
[psign,hsign,signstats]=signrank(MGBvsample,1)

