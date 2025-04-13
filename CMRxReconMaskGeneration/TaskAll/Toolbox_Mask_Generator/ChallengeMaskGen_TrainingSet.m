%% The matlab script for mask generation for TrainingSet (CMRxRecon MICCAI2025)
% Author: Zi Wang (wangziblake@gmail.com)
% April 3, 2025

% If you want to use the code, please cite the following paper:
% [1] Zi Wang et al., CMRxRecon2024: A multimodality, multiview k-space
% dataset boosting universal machine learning for accelerated cardiac MRI, Radiology: Artificial Intelligence, 7(2): e240443, 2025.

function ChallengeMaskGen_TrainingSet(data_path,mainSavePath,pattern,R,file_nameCT,file_nameVD,file_nameID,dataName,setName)

%% 5D kspace [nx, ny, sc, sz, t] or 4D kspace [nx, ny, sc, sz]
var = load(data_path);  % Loading raw kspace data
if isfield(var, 'kspace_full')
    kspace_full = var.kspace_full;
elseif isfield(var, 'kspace')
    kspace_full = var.kspace;
else
    disp('No k-space data in the .mat file.');
end
nx = size(kspace_full, 1);
ny = size(kspace_full, 2);
if length(size(kspace_full)) == 5
    nt = size(kspace_full, 5);
elseif length(size(kspace_full)) == 4
    nt = 1;
end
ncalib = 20;

%% 2D+t Mask generation [nx, ny, nt] or [nx, ny]
mask = ktMaskGenerator(nx, ny, nt, ncalib, R, pattern);

%% Save mask and undersampled kspace
if strcmp(setName,'TrainingSet')
    savepath1 = strcat(mainSavePath,'/',file_nameCT,'/',file_nameVD,'/',file_nameID);
    mkdir(savepath1);
    save(fullfile(savepath1,[dataName,'_mask_',pattern,num2str(R),'.mat']),'mask','-v7.3');
end

%% Mask display
% figure(R),imshow(mask,[]);
% figure(R+1),imshow(squeeze(mask(60,:,:)),[]);
end

