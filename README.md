# Somato_Auditory_Circuits-Lohse-et-al-2021
This repository contains example code used for producing figures included in the paper Subcortical Circuits Mediate Communication between Primary Sensory Cortical Areas in Mice by Lohse, Dahmen, Bajo, and King, 2021, Nature Communications


# INTRODUCTION TO CODE

The paper uses variations of essentially three types of analysis on data obtained using extracellular recordings and 2-photon imaging across multiple brain regions with multiple manipulations, to identify the circuits underlying somatosensory effects on the auditory system.

These three types of analyses are:

1. Changes in auditory responses with whisker stimulation/optogenetic manipulation.

2. Assessment of changes in frequency tuning curves with whisker stimulation/optogenetic manipulation, and quantification of differences in neuronal responses at the best frequency.

3. Assessment of response differences between all tones presented with and without whisker stimulation


The code demonstrates how these analyses were carried out using the data recorded from the auditory thalamus of anesthetized mice that are used in Figure 2, Figure 3, and Supplementary Figure 3. The code reproduces the graphs shown in these figures, to illustrate how these three types of analyses were run, both for the specific results shown in these figures, and for the results obtained using similar analyses in the rest of the paper.

# REQUIREMENTS FOR RUNNING CODE

The easiest way to use the code is simply to download the entire dropbox folder 'Lohse_et_al_2021_CodeandData' which contains the code and data and run the wrapperscripts: https://www.dropbox.com/sh/h4fgl583ecz9mh9/AACX_QAD8vrCIk5b9DFPDjwma?dl=0 (~2.5 GB).

Add the entire ‘CODE’ folder (including subfolder to the Matlab path) in the ‘Lohse_et_al_2021_Code’ folder

If the code is pulled from this GitHub repository, then download data separately from: https://www.dropbox.com/sh/77lf7rma17btc2u/AADTz-j9Axy4gJc8cKhcDfH4a?dl=0 (~2.5gb).

All code is written in Matlab 2018b.

# RUNNING THE CODE

The code repository is divided into three main folders:

Anes_MGBNoise - For assessing whisker stimulation effects on responses of auditory neurons to broadband noise
Anes_MGBTones - For assessing whisker stimulation effects on tone/tuning responses
SupportCode - For extra scripts helping with basic plotting and processing

In the Anes_MGBNoise folder:

Run the ‘Wrapper_NoisewithWhisk.m’ for producing Supplementary Figure 3 from the raw data files (found in the ‘DATA’ folder). You can find the wrapper script calls for producing these results and panels in the Subscript folder. (Takes ~2 minutes to finish running)

Because of path dependencies IT IS ESSENTIAL WHEN RUNNING THE WRAPPER SCRIPT THAT THE CURRENT FOLDER IS ‘Anes_MGBNoise’

In the Anes_MGBTones folder:

Run ‘Wrapper_TonesandWhisk_AnesMGB.m’ (takes ~7-10 minutes to finish running)
Because of path dependencies IT IS ESSENTIAL WHEN RUNNING THE WRAPPER SCRIPT THAT THE CURRENT FOLDER IS ‘Anes_MGBTones’

The script will first produce the Voronoi diagram (and its ‘shell’) showing the somatosensory modulation of BF responses across the auditory thalamus in Figure 3j (Matlab figure 100 and 101), using the subscript CreateBFModulationMap.m

The code will then move on to producing the MGBv and MGBd panels found in Figure 2 (Matlab figure 10), using the subscripts SummaryTuningCurves.m, AssessingTuningDivisiveScaling.m and Plot_MGBvd_Examples.m

Finally, the code will move on to produce the summary tuning curves from significantly modulated units in MGBm/PIN/SGN (Figure 3f and h) (Matlab figure 40).

The code in Anes_MGBTones can also produce these figures directly from the raw data (Reading in the raw data from the ‘DATA’ folder). An option exists in the wrapper code to skip the raw data import and instead load in the data directly (from ‘ExpDataBasic_50msRespWindow_Imported.mat’) for speed (this is set as default).

You can find the wrapper scripts call for producing these results and panels in the folder ’Subscripts’ located inside of each the Anes_MGBNoise and Anes_MGBTones folders.
