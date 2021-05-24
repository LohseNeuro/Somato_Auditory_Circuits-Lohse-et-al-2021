%% Subcortical circuits mediate communication between primary sensory cortical areas
%% Lohse, M. Dahmen, J.C. Bajo, V.M. and King, A.J.
% Code written by Michael Lohse
% Nature CommunIcations Manuscript number: NCOMMS-20-34371

%% Extract and normalize tuning curves
% Some mice were run with different number of conditions (e.g.
% different amount of sound levels used or different amount of whisker
% and tone SOAs). There are therefore slightly different scripts for different experiments. All three scripts below extract the the tuning curve and
% normalizes the tuning curves in similar ways, while being adjusted to account for changes in the amount of conditions. The script 'estimatefrequencytuningchanges_Exp62_70_BasicSS' is commented for udnerstanding the structure of the code

if ExpNo<62
    estimatefrequencytuningchanges_Exp60_61_BasicSS %% Without light 100 ms delay
elseif ExpNo>130
    estimatefrequencytuningchanges_Crispr_BasicSS % for hearing loss corrected animals
else
    estimatefrequencytuningchanges_Exp62_70_BasicSS % this code is commented for understanding the code of this and the two codes above
end