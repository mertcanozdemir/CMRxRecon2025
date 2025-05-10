%% This is a demo to generate ZF recon results into the Submission folder
% MICCAI "CMRxRecon" challenge 2025

clc; clear;

%% add paths
addpath(genpath('./GRAPPA'))
addpath(genpath('./ESPIRiT'))
addpath('./utils');

%% set info
coilInfo     = 'MultiCoil/';            % singleCoil not used for ZF recon
setName      = 'ValidationSet/';          % options: 'ValidationSet/','TestSet/'
taskTypeList = {'TaskS2'};
dataTypeList = {'Cine','BlackBlood','T1w','T2w','Flow2d','Mapping','Perfusion','LGE','T1rho'};%

% input and output root folders
basePath     = '/SSDHome/share/ChallengeData_ValSetSub/';
mainSavePath = '/SSDHome/share/SENSE_for_Validation/';

%% parameters
sampleStatusType = 1;  % 0: full k-space; 1: undersampled
reconType        = 2;  % 2: SENSE recon
imgShow          = 0;  % 0: no display

%% generate SENSE recon for all modalities and tasks
for dt = 1:numel(dataTypeList)
    dataType = dataTypeList{dt};
    for tt = 1:numel(taskTypeList)
        taskType = taskTypeList{tt};
        fprintf('Running SENSE recon for %s, %s...\n', dataType, taskType);
        runRecon2025(basePath, mainSavePath, coilInfo, setName, dataType, taskType, sampleStatusType, reconType, imgShow);
    end
end

disp('All SENSE recon results generated into Submission folder!');
