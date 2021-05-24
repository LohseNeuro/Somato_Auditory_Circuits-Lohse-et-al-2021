%% Subcortical circuits mediate communication between primary sensory cortical areas
%% Lohse, M. Dahmen, J.C. Bajo, V.M. and King, A.J.
% Code written by Michael Lohse
% Nature CommunIcations Manuscript number: NCOMMS-20-34371

%% Simply extrating Frequency response areas (FRA), if it has not been done previously
% Some mice were run with different number of conditions (e.g.
% different amount of sound levels used or different amount of whisker
% and tone SOAs). There are therefore slightly different scripts for different experiments. All three scripts below extract the the tuning curve and
% normalizes the tuning curves in similar ways, while being adjusted to account for changes in the amount of conditions.

if BasicExtract==0
    if ExpNo>130
        Estimate_FRA_SpikeSorted_FullBasicCrispr
    else
        Estimate_FRA_SpikeSorted_FullBasic
    end
end

