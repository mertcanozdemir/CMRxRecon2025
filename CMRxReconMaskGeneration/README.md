## The matlab script for varied mask generation for TrainingSet (CMRxRecon MICCAI2025)

# Package Structure
Folder `TaskAll`: The matlab script for varied mask generation for TrainingSet (3D kspace-temporal undersampling mask)
* `MaskGeneration_TrainingSet`: This is a demo to generate varied 3D masks for TrainingSet (this step is optional if you need more different masks for training!!!)
* `MaskGeneration_Demo`: This is a demo to generate typical 3D masks for understanding their properties

===========================

## Matlab code for generating undersampled kspace using the fully sampled kspace and 2D undersampling mask
kus = kspace .* mask;

## Matlab code for generating undersampled kspace using the fully sampled kspace and 3D k-t undersampling mask
mask_5D = reshape(mask, [nx,ny,1,1,nt]); kus = kspace .* mask_5D;
