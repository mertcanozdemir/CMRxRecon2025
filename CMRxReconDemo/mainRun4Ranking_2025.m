%% This is a demo to generate validation results into the submission folder
% MICCAI "CMRxRecon" challenge 2025
% 2023.03.06 @ fudan university
% Email: wangcy@fudan.edu.cn
% Revise: Huang Mingkai
% Updated directory structure: Task -> Center -> Vendor -> Patient -> .mat
clc; clear;

%% add path to utilities
addpath('./utils');

% set your data directories
basePath     = '/Path/to/ChallengeData';    % superior directory of 'MultiCoil/'
mainSavePath = '/Path/to/your/save/dir';     % output path
taskType     = 'TaskR1';                      % options: 'TaskR1', 'TaskR2','TaskS1','TaskS2'

%% fixed settings
dataTypeList = {'Cine','BlackBlood','T1w','T2w','Mapping','Flow2d','Perfusion','LGE','T1rho'};
setName      = 'ValidationSet/';          
coilInfo     = 'MultiCoil/';

%% traverse data types
for iType = 1:numel(dataTypeList)
    dataType = dataTypeList{iType};
    taskDir  = fullfile(basePath, coilInfo, dataType, setName, ['FullSample_',taskType]);
    centerList = dir(taskDir);

    % loop over center folders
    for iCenter = 1:numel(centerList)
        centerInfo = centerList(iCenter);
        if ~centerInfo.isdir || startsWith(centerInfo.name,'.')
            continue;
        end
        centerPath = fullfile(taskDir, centerInfo.name);

        % loop over vendor folders
        vendorList = dir(centerPath);
        for iVendor = 1:numel(vendorList)
            vendorInfo = vendorList(iVendor);
            if ~vendorInfo.isdir || startsWith(vendorInfo.name,'.')
                continue;
            end
            vendorPath = fullfile(centerPath, vendorInfo.name);

            % loop over patient folders
            patientList = dir(vendorPath);
            for iPatient = 1:numel(patientList)
                patientInfo = patientList(iPatient);
                if ~patientInfo.isdir || startsWith(patientInfo.name,'.')
                    continue;
                end
                patientPath = fullfile(vendorPath, patientInfo.name);

                % find all .mat files in patient folder
                matFiles = dir(fullfile(patientPath,'*.mat'));
                for iFile = 1:numel(matFiles)
                    fileInfo = matFiles(iFile);
                    fullMatPath = fullfile(patientPath, fileInfo.name);

                    % load k-space data
                    ksStruct = load(fullMatPath);
                    fields   = fieldnames(ksStruct);
                    kspace   = ksStruct.(fields{1});

                    % image reconstruction and ranking
                    img = ifft2c(kspace);
                    img4ranking = run4Ranking_2025(img, fileInfo.name);

                    % prepare save directory mirroring input structure
                    saveDir = fullfile(mainSavePath, taskType,coilInfo, dataType, setName, ['FullSample_',taskType], centerInfo.name, vendorInfo.name, patientInfo.name);
                    if ~exist(saveDir,'dir')
                        createRecursiveDir(saveDir);
                    end

                    % save result
                    savePath = fullfile(saveDir, fileInfo.name);
                    save(savePath, 'img4ranking');
                end
                fprintf('Processed %s/%s/%s\n', dataType, centerInfo.name, patientInfo.name);
            end
        end
    end
end

disp('All data generation successful!');
