%% Subcortical circuits mediate communication between primary sensory cortical areas
%% Lohse, M. Dahmen, J.C. Bajo, V.M. and King, A.J.
% Code written by Michael Lohse
% Nature CommunIcations Manuscript number: NCOMMS-20-34371

%% Wrapper script for extracting tuning curves for estiamtion of whisker modulation on tuning curves in anesthetized auditory thalamus

%% Add Lohse_code folder and subfolders to the maltab path and run this code.
%% This wrapper must run from 'Lohse_et_al_2020_Code/Anes_MGBTones' folder

clear all
close all

% Find path to current folder (you need to be in the 'Lohse_et_al_2020_CodeandData' folder for this wrapper to work)
CurFolder=dir('*.m')
CurPath=CurFolder.folder
clear CurFolder

%% Get electrode postions (estimated form histology) and some metadata from all recordings
cd('Subscripts')
ElectrodePositionMapBasic
cd ..

%% Parameters
Thresh=0.005 % inclusion threshold of FRA (from ANOVA)
attenuation=0 % Sound level attenuation to extract tuning curves from. 0 = 80dB, 1 = 60 dB
smoothing=3 % amount of smoothing of frequency tuning curves.
BasicExtract=1; % has the raw data import already been run, if yes =1 (It has when ExpDataBasic_50msRespWindow_Imported.mat is in the folder)

%% Basic processing
if BasicExtract==1
    load('ExpDataBasic_50msRespWindow_Imported.mat') % This loads the saved results from ImportTones, so you can skip the import step. The import step can be rerun by running 'ReImportTones.m'
end
ExpCount=0; % experiment counter
for ExpNo=[60 61 62 63 65 67 68 69 70 71 137 137 138 139 139 140 140 140] % experiments to include
    ExpCount=ExpCount+1;
    
    %% Importing raw data, if it has not been done previously
    if BasicExtract==0
        cd(CurPath)
        cd ../..
        ImportTones
        close all
    end
    
    ExtractTuning % Extracting and normalizing tuning curves
end

%% Results and figures %%

%% See summaries of whisker stimulation effects across auditory thalamus
CreateBFModulationMap % Creates whisker stim modulation voronoi diagram seen in figure 3j

%% See summaries of whisker stimulation effects from MGBv and MGBd  (matlab figure 10)
%CreateBFModulationMap.m must be run before this script
SummaryTuningCurves % Creates summary tuning curves, using data from anesthetized MGBv and MGBd (as seen in figure 2).
AssessingTuningDivisiveScaling % Creates scatter of responses across all tones with and without whisker deflection, using data from anesthetized MGBv and MGBd (as seen in figure 2)
Plot_MGBvd_Examples % produces examples frequency tuning curves and PSTHs from anesthetized MGBv and MGBd (as seen in figure 2)

%% See summaries of whisker stimulation effects from MGBm/PIN/SGN (matlab figure 40)
SigMedialTuningSummary % Finds units in MGBm/PIN/SGN which are significantly modualted by whisker modulation and plots summary tuning curves of significantly modulated MGBm/PIN/SGN units (as seen in figure 3f and h)
