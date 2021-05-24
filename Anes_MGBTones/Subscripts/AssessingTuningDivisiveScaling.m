%% Subcortical circuits mediate communication between primary sensory cortical areas
%% Lohse, M. Dahmen, J.C. Bajo, V.M. and King, A.J.
% Code written by Michael Lohse
% Nature CommunIcations Manuscript number: NCOMMS-20-34371

%Run WhiskerAnalysis wrapper first

MGBvWhiskAll=(tuningfullWhiskAll(:,MGBvGoodIndex));
MGBvConAll=(tuningfullAllCon(:,MGBvGoodIndex));
 MGBvConAllFull=MGBvConAll;
 MGBvWhiskAllFull=MGBvWhiskAll;
 %MGBvSpontNormAllFull=SpontNormFull(MGBvGoodIndex)
 
 clear MGBvConAll MGBvWhiskAll

 MGBdWhiskAll=(tuningfullWhiskAll(:,MGBdGoodIndex));
MGBdConAll=(tuningfullAllCon(:,MGBdGoodIndex));
 MGBdConAllFull=MGBdConAll;
 MGBdWhiskAllFull=MGBdWhiskAll;
 %MGBdSpontNormAllFull=SpontNormFull(MGBdGoodIndex)

 clear MGBdConAll MGBdWhiskAll
 
MGBdWhiskAll=MGBdWhiskAllFull(MGBdConAllFull>0);
MGBdConAll=MGBdConAllFull(MGBdConAllFull>0);
MGBdWhiskAll2=MGBdWhiskAllFull(MGBdConAllFull<0);
MGBdConAll2=MGBdConAllFull(MGBdConAllFull<0);

MGBvWhiskAll=MGBvWhiskAllFull(MGBvConAllFull>0);
MGBvConAll=MGBvConAllFull(MGBvConAllFull>0);
MGBvWhiskAll2=MGBvWhiskAllFull(MGBvConAllFull<0);
MGBvConAll2=MGBvConAllFull(MGBvConAllFull<0);
 
nfreqv=length(MGBvConAllFull(:,1));
nfreqd=length(MGBdConAllFull(:,1));
nUnitv=length(MGBvConAllFull(1,:));
nUnitd=length(MGBdConAllFull(1,:));
BFDistv=repmat([-25:13],nUnitv,1)';
BFDistd=repmat([-25:13],nUnitd,1)';

radius=.1 % radius for scatstat1

figure(10)
subplot(6,3,[12 15 18])

  ybMGBv = scatstat1(MGBvConAllFull(:),MGBvWhiskAllFull(:),radius,@nanmedian); 
  ybMGBvBF = scatstat1(MGBvConAllFull(:),abs(BFDistv(:))/5,radius,@nanmedian); 
 % scatter3(MGBvConAllFull(:),MGBvWhiskAllFull(:),randn(length(BFDistv(:)),1),5,abs(BFDistv(:))*-1,'filled')
  scatter(MGBvConAllFull(:),MGBvWhiskAllFull(:),'k.')

  xlabel('Tones alone')
  ylabel('Tones + Whisker stim')
  hold on
 ybMGBv2 = scatstat1(MGBvConAll2(:),MGBvWhiskAll2(:),radius,@nanmedian); 
  plot(MGBvConAll2(:),MGBvWhiskAll2(:),'w.')
  scatter(MGBvConAllFull(:),ybMGBv,30,ybMGBvBF,'filled')
    clim([0 2.5])
        line([-2.5 2.5], [-2.5 2.5],'color','r','linestyle','--','linewidth',2)
set(gca,'linewidth',1.4)

colormap('jet')
 % lsline
 xlim([0 1])
 ylim([0 2.1])

box off
colorbar
line([0 0], [-2 2.5])
%% MGBd


subplot(6,3,[3 6 9])

  ybMGBd = scatstat1(MGBdConAllFull(:),MGBdWhiskAllFull(:),radius,@nanmedian); 
  ybMGBdBF = scatstat1(MGBdConAllFull(:),abs(BFDistd(:))/5,radius,@nanmedian); 
 % scatter3(MGBdConAllFull(:),MGBdWhiskAllFull(:),randn(length(BFDistv(:)),1),5,abs(BFDistv(:))*-1,'filled')
  scatter(MGBdConAllFull(:),MGBdWhiskAllFull(:),'k.')
  xlabel('Tones alone')
  ylabel('Tones + Whisker stim')
  hold on
 ybMGBd2 = scatstat1(MGBdConAll2(:),MGBdWhiskAll2(:),radius,@nanmedian); 
  plot(MGBdConAll2(:),MGBdWhiskAll2(:),'w.')
  scatter(MGBdConAllFull(:),ybMGBd,30,ybMGBdBF,'filled')
    clim([0 2.5])
        line([-2.5 2.5], [-2.5 2.5],'color','r','linestyle','--','linewidth',2)
line([0 0], [-2 2.5])

colormap('jet')
 % lsline
set(gca,'linewidth',1.4)

 xlim([0 1])
 ylim([0 2.1])

box off
colorbar
