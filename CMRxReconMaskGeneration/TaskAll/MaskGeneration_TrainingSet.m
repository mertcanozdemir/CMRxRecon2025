%% The matlab script for varied mask generation for TrainingSet (CMRxRecon MICCAI2025)
% Author: Zi Wang (wangziblake@gmail.com)
% February 21, 2025

% If you want to use the code, please cite the following paper:
% [1] Zi Wang et al., CMRxRecon2024: A multimodality, multiview k-space
% dataset boosting universal machine learning for accelerated cardiac MRI, Radiology: Artificial Intelligence, 7(2): e240443, 2025.

clc
clear all
close all
warning off
%% Add path
currentFolder = pwd;
addpath(genpath(currentFolder));

%% Set path
TaskName = 'Task1';  % Task1 or Task2
setName = 'TrainingSet';  % TrainingSet

% TrainingSet
basePath = '/home2/Raw_data/MICCAIChallenge2025/ChallengeData/MultiCoil';

mainDataPath = strcat(basePath,'/');
FileList = dir(mainDataPath);  % Different modalities
NumFile = length(FileList);

%% Running all modalities, datasets, samplings, and patient IDs
for ind0 = 1 : NumFile
    file_name = FileList(ind0).name;
    disp(['Running modality file:',file_name]);
    dataPath = strcat(mainDataPath,file_name,'/');  % Example: '/home2/Raw_data/MICCAIChallenge2025/ChallengeData/MultiCoil/Cine/'
    fileNameSet = dir(dataPath);
    fileSetLen = length(fileNameSet);  % Example: if only have TrainingSet, fileSetLen = 1; if have three type of sets, fileSetLen = 3.
    for ind1 = 1 : fileSetLen
        file_nameSet = fileNameSet(ind1).name;
        disp(['Running dataset file:',file_nameSet]);
        dataPathSet = strcat(dataPath,file_nameSet,'/');  % Example: '/home2/Raw_data/MICCAIChallenge2025/ChallengeData/MultiCoil/Cine/TrainingSet/'
        fileNameFS = dir(dataPathSet);
        fileFSLen = length(fileNameFS);  % Example: if only have FullSample, fileFSLen = 1; if have N type of sampling, fileFSLen = N.
        for ind2 = 1 : fileFSLen
            file_nameFS = fileNameFS(ind2).name;
            disp(['Running sampling file:',file_nameFS]);
            dataPathFS = strcat(dataPathSet,file_nameFS,'/');  % Example: '/home2/Raw_data/MICCAIChallenge2025/ChallengeData/MultiCoil/Cine/TrainingSet/FullSample/'
            fileNameCT = dir(dataPathFS);
            fileCTLen = length(fileNameCT);  % Example: if only have Center1, fileCTLen = 1; if have N different centers, fileCTLen = N.
            for ind22 = 1 : fileCTLen
                file_nameCT = fileNameCT(ind22).name;
                disp(['Running center file:',file_nameCT]);
                dataPathCT = strcat(dataPathFS,file_nameCT,'/');  % Example: '/home2/Raw_data/MICCAIChallenge2025/ChallengeData/MultiCoil/Cine/TrainingSet/FullSample/Center1/'
                fileNameVD = dir(dataPathCT);
                fileVDLen = length(fileNameVD);  % Example: if only have Siemens_30T_Vida, fileVDLen = 1; if have N different vendors, fileVDLen = N.
                for ind222 = 1 : fileVDLen
                    file_nameVD = fileNameVD(ind222).name;
                    disp(['Running vendor file:',file_nameVD]);
                    dataPathVD = strcat(dataPathCT,file_nameVD,'/');  % Example: '/home2/Raw_data/MICCAIChallenge2025/ChallengeData/MultiCoil/Cine/TrainingSet/FullSample/Center1/Siemens_30T_Vida/'
                    fileNameID = dir(dataPathVD);
                    fileIDLen = length(fileNameID);  % Example: if only have P001, fileIDLen = 1; if have N different patient ID, fileIDLen = N.
                    for ind3 = 1 : fileIDLen
                        file_nameID = fileNameID(ind3).name;
                        disp(['Running ID file:',file_nameID]);
                        dataPathID = strcat(dataPathVD,file_nameID,'/');  % Example: '/home2/Raw_data/MICCAIChallenge2025/ChallengeData/MultiCoil/Cine/TrainingSet/FullSample/Center1/Siemens_30T_Vida/P001/'
                        fileNamemat = dir(dataPathID);
                        filematLen = length(fileNamemat);  % Example: if only have cine_sax.mat, filematLen = 1; if have N different .mat, filematLen = N.
                        % Running all .mat
                        for ind4 = 1 : filematLen
                            imgName = fileNamemat(ind4).name;
                            
                            %% Different .mat files
                            if contains(imgName,'.mat') && ~contains(imgName,'mask') && ~contains(imgName,'kus')
                                dataName = strrep(imgName, '.mat', '');  % replace .mat to none, get dataName
                                data_path = strcat(dataPathID,imgName);  % Path for loading .mat
                                mainSavePath = strcat(dataPathSet,['Mask_',TaskName],'/');  % Main path for saving generated masks
                                % Parameters for mask generation
                                if strcmp(file_nameSet,'TrainingSet') && strcmp(file_nameSet,setName)
                                    patterns = ["Uniform", "ktGaussian", "ktRadial"]; % pattern type
                                    for i = 1 : length(patterns)
                                        pattern = patterns{i};
                                        for R = [8,16,24]
                                            ChallengeMaskGen_TrainingSet(data_path,mainSavePath,pattern,R,file_nameID,dataName,file_nameSet);
                                            % Save example: '/home2/Raw_data/MICCAIChallenge2025/ChallengeData/MultiCoil/Cine/TrainingSet/Mask_Task1/P001/cine_sax_mask_Uniform4.mat'
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
    end
end