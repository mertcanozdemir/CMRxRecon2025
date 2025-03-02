%% The matlab script for mask generation for TestSet (CMRxRecon MICCAI2025)
% Author: Zi Wang (wangziblake@gmail.com)
% February 20, 2025

% If you want to use the code, please cite the following paper:
% [1] Zi Wang et al., CMRxRecon2024: A multimodality, multiview k-space
% dataset boosting universal machine learning for accelerated cardiac MRI, Radiology: Artificial Intelligence, 7(2): e240443, 2025.

function ChallengeMaskGen_TestSet(data_path,mainSavePath_mask,mainSavePath_kus,pattern,R,file_nameID,dataName,setName)

%% 5D kspace [nx, ny, sc, sz, t] or 4D kspace [nx, ny, sc, sz]
load(data_path);  % Loading raw kspace data
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
if strcmp(setName,'TestSet')
    savepath1 = strcat(mainSavePath_mask,file_nameID);
    savepath2 = strcat(mainSavePath_kus,file_nameID);
    mkdir(savepath1);
    mkdir(savepath2);
    save(fullfile(savepath1,[dataName,'_mask_',pattern,num2str(R),'.mat']),'mask','-v7.3');
    if strcmp(setName,'TestSet')
        mask_multi = reshape(mask, [nx,ny,1,1,nt]);
        kus = kspace_full .* mask_multi;
        save(fullfile(savepath2,[dataName,'_kus_',pattern,num2str(R),'.mat']),'kus','-v7.3');
    end
end

%% Mask display
% figure(R),imshow(mask,[]);
% figure(R+1),imshow(squeeze(mask(60,:,:)),[]);
end

