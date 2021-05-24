function [UPPER LOWER MEDIAN MEDIANReSamples RANGE SAMPLES]=NonPar_BootCI(Data,CIRange, Samples)
% Estimation of non-parametric confidence intervals of the median
%Input: Data should be a vector of 1 column. CI range is the confidence
%interval range i.e. 95 for 95%. Samples is how many times the data is
%resampled. Samples should be 1000,10000,100000 etc.

% Michael Lohse 2018

disp(sprintf('%d Non-parametric confidence interval estimation', CIRange))

CI_Idx=round([abs(((CIRange-100)/2)) abs(((CIRange-100)/2)+100)]*Samples/100); %IDx of CI values

for Boot_i=1:Samples
clear ReplaceIdx
ReplaceIdx=randi(length(Data),length(Data),1);

DataReSample(:,Boot_i)=Data(ReplaceIdx);

end

SampleMedians=sort(nanmedian(DataReSample)); % sorted sample medians





% Ouput variables
SAMPLES=Samples;
RANGE=CIRange;
MEDIANReSamples=nanmedian(SampleMedians); % Median of bootstrapped medians
MEDIAN=nanmedian(Data); % actual median of sample
LOWER=SampleMedians(CI_Idx(1)); %Lower condfidence
UPPER=SampleMedians(CI_Idx(2)); %Upper confidence