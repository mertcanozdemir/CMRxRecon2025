%% This is a demo to generate GRAPPA recon results into the Submission folder
% MICCAI "CMRxRecon" challenge 2025
% 2023.03.06 @ fudan university
% Email: wangcy@fudan.edu.cn
% Revise: Huang Mingkai
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
basePath     = '/Path/to/ChallengeData';
mainSavePath = '/Path/to/your/save/dir';

%% parameters
sampleStatusType = 1;  % 0: full k-space; 1: undersampled
reconType        = 1;  % 1: GRAPPA recon
imgShow          = 0;  % 0: no display

%% generate GRAPPA recon for all modalities and tasks
for dt = 1:numel(dataTypeList)
    dataType = dataTypeList{dt};
    for tt = 1:numel(taskTypeList)
        taskType = taskTypeList{tt};
        fprintf('Running GRAPPA recon for %s, %s...\n', dataType, taskType);
        runRecon2025(basePath, mainSavePath, coilInfo, setName, dataType, taskType, sampleStatusType, reconType, imgShow);
    end
end

disp('All GRAPPA recon results generated into Submission folder!');
