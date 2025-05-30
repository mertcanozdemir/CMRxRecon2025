# MRI Data Loader and Transforms
This directory provides a reference data loader to read the CMRxRecon2025 data one
slice and one frame at a time and some useful data transforms to work with the data in PyTorch.

Each partition (train, validation or test) of the CMRxRecon2025 data is distributed as a set of mat files, such that each mat file contains data from one case with multiple slices and time frames. The set of fields and attributes in these mat files depends on the track (multi-coil) and the data partition.

## main
You can turn to ShowCase.ipynb to see the visualisation directly.


## functions
We acknowledged fastMRI repo for their utlity functions to convert k-space into image space. These functions work on PyTorch Tensors. The to_tensor function can convert Numpy arrays to PyTorch Tensors.

* 'readfile2numpy' read the file from mat to numpy complex
* 'show_coils' plots several coil images 
* 'fastmri.data.transform' converts from numpy array to pytorch tensor
* 'fastmri.ifft2c' applies Inverse Fourier Transform to get the complex image
* 'fastmri.complexabs' computes absolute value to get a real image
* 'fastmri.rss' gives the coil-combined images with the specified coil dim.
* 'savenumpy2mat' saves the numpy to a mat file.
