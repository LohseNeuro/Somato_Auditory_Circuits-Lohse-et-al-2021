%% Subcortical circuits mediate communication between primary sensory cortical areas
%% Lohse, M. Dahmen, J.C. Bajo, V.M. and King, A.J.
% Code written by Michael Lohse
% Nature CommunIcations Manuscript number: NCOMMS-20-34371

clearvars -except elect Exp ExpCount ExpNo attenuation Thresh BasicExtract
close all

for e=1:18
    Exp(e).LatPosClust=rand(length([Exp(e).elect.peakChan]),1)'+Exp(e).LatPos([Exp(e).elect.peakChan])
    Exp(e).VenPosClust=rand(length([Exp(e).elect.peakChan]),1)'+Exp(e).VenPos([Exp(e).elect.peakChan])    
end


LatPosAllFull=[Exp(:).LatPosClust]
VenPosAllFull=[Exp(:).VenPosClust]
BFConFull=[Exp(:).BFCon]
SpontFull=[Exp(:).Spont]


pTAllFull=[Exp(:).pTAll]
Include=find(pTAllFull<Thresh)

for e=1:length(Exp)
    ee(e).normFreqConTemp=Exp(e).normFreqCon(26,:)
    ee(e).normFreqwhiskTemp=Exp(e).normFreqwhisk(26,:)
    for n=1:length(Exp(e).LatPosClust)
        tuningfull{e}(:,n)=Exp(e).normFreqwhisk(1:39,n);
        tuningfullCon{e}(:,n)=Exp(e).normFreqCon(1:39,n);

    end
    normFreqConFull=[ee(:).normFreqConTemp]
    normFreqWhiskFull=[ee(:).normFreqwhiskTemp]
end

for e=1:length(Exp);
    tunCon{e}=[tuningfullCon{e}(1:39,:)];
    tunAll{e}=[tuningfull{e}(1:39,:)];
    expNo{e}=zeros(1,length([tuningfull{e}(1:39,:)]))+e
end

tuningfullWhiskAll=[tunAll{:}]
tuningfullAllCon=[tunCon{:}]
expNoFull=[expNo{:}]


clear ee

PosAll=LatPosAllFull(Include)
PosAllDV=VenPosAllFull(Include)
BFConGood=BFConFull(Include)

normFreqAllTemp=normFreqWhiskFull(Include)./normFreqConFull(Include)

%% convert into orders of magnitude
normFreqAll=log2(normFreqAllTemp)

% Estimate shape of auditory thalamus from physiology using delaunay triangulation 
figure(100)
x = PosAll(PosAll<1250);
y = PosAllDV(PosAll<1250);
fillins=zeros(1,369)
z = fillins(PosAll<1250);
tri = delaunay(x'+rand(length(x),1),y'+rand(length(x),1));
hold on
trisurf(tri,x,y,z);
colormap(redblue)
xlabel('Distance from lateral border (L-M AXIS)')
ylabel('Distance from ventral border(D-V AXIS)')
xlim([-250 1100])
ylim([-250 1100])
colormap(hot)
clim([0 1])


%Somato modulation of BF resp - voronoi
x = PosAll(PosAll<1250);
y = PosAllDV(PosAll<1250);
z = normFreqAll(PosAll<1250);
figure(101)
[v,c] = voronoin([x'+rand(length(x),1)*5,y'+rand(length(x),1)*7.5],{'Qbb','Qz'});
kk=0
for i = 1:length(c)
    if all(c{i}~=1)   % If at least one of the indices is 1,
        
        patch(v(c{i},1),v(c{i},2),z(i)); % use color i.
    else
        kk=kk+1;
        patch(v(c{i},1),v(c{i},2),z(i)); % use color i.
        
        %c{i}(c{i}==1)=10
        disp('Open polygon')
        openPol(kk)=i
        hold on;scatter3(x(openPol),y(openPol),ones(1,length(openPol)),50,z(openPol),'filled')
    end
end
colormap(redblue)
xlabel('Distance from lateral border (L-M AXIS)')
ylabel('Distance from ventral border(D-V AXIS)')
xlim([-250 1100])
ylim([-250 1100])

clim([-1 1])
colorbar
set(gcf, 'Renderer', 'painters');
