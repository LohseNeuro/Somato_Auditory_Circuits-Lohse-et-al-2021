%% Subcortical circuits mediate communication between primary sensory cortical areas
%% Lohse, M. Dahmen, J.C. Bajo, V.M. and King, A.J.
% Code written by Michael Lohse
% Nature CommunIcations Manuscript number: NCOMMS-20-34371

%% Wrapper script for assessing noise and whisker interactions in MGBv and MGBd
%This code produces supp figure 3, which is an expanded analysis of the noise
%whisker interaction analysis run for several brain areas thoughout the
%paper.

%% Add Lohse_code folder and subfolders to the maltab path and run this code.
%% This wrapper must run from 'Lohse_et_al_2020_Code/Anes_MGBTones' folder

clear all
close all

% Find path to current folder (you need to be in the 'Lohse_et_al_2020_CodeandData' folder for this wrapper to work)
CurFolder=dir('*.m')
CurPath=CurFolder.folder
clear CurFolder

% et electrode postions (from histology) and some metadata from all recordings
ElectrodePositionMapBasicNoise

% Parameters
Thresh=0.005 % inclusion threshold of p-value of t-test for finding units with noise reponses
smoothing=10 % PSTH smoothing

% Import raw data into matlab 
ExpCount=0;
for ExpNo=[60 61 62 63 65 67 68 69 69 70 71] % experimnts to include
    
    ExpCount=ExpCount+1
    cd(CurPath)
    cd ../..
    NoisewithWhiskImport % Script for importing raw data into matlab 

end

ExtractNoiseConditions % analyse results for recreation of supp fig 3

