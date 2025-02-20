# CMRxRecon2025

## About
**Welcome to the Cardiac MRI Reconstruction Challenge 2025 (CMRxRecon2025)！**  
The CMRxRecon2025 (Towards Foundation Model) Challenge is a part of the 28th International Conference on Medical Image Computing and Computer Assisted Intervention, MICCAI 2025, which will be held from September 23rd to 27th 2025 in Daejeon, Republic of Korea.


[Website](https://cmrxrecon.github.io/2025) |
[Dataset](TODO) |
[GitHub](https://github.com/CmrxRecon/CMRxRecon2025/) |
[Publications](#Publication-references)

## Motivation
The objective of establishing the CMRx series challenges is to provide a benchmark that enables the research community to contribute to the work of accelerated CMR imaging with universal approaches that allow more diverse applications and better performance in real-world deployment in various environments. The previous CMRxRecon2023 and CMRxRecon2024 datasets did not cover multiple centers, multiple vendors, and multiple diseases. Therefore, this year we aim to fill these gaps and make an important leap towards real-world clinical scenarios.

## Background
Cardiac MRI (CMR) has become an essential tool for diagnosing and evaluating cardiovascular diseases, offering multi-parametric, high-resolution anatomical and functional data. CMR reconstruction from highly under-sampled k-space data has gained significant attention in recent research. Numerous AI-based image reconstruction algorithms have shown potential in improving imaging performance and patient experience in recovering high-quality images from aggressively undersampled k-space measurements. However, the complexity and diversity of CMR scans in real-world applications, involving various image contrasts, sampling trajectories, equipment vendors, anatomical structures, and disease types, present a great challenge for existing AI-based reconstruction methods, which are usually developed for only one or a few specific scanning settings. In practice, there are often inevitable distribution mismatches between the training data and target data, due to the diversities listed above. **Therefore, building and validating universal and robust reconstruction models for handling these diversities remains a critical technical challenge for multi-parametric CMR imaging.**

![CMRxSeries](https://github.com/CmrxRecon/CMRxRecon2025/blob/main/CMRxSeries.png)

We aim to make an important leap towards real-world clinical scenarios by extending the challenge scope in two directions:
**1) To evaluate the robustness and generalization performance of reconstruction foundation models in more than 5 centers and 10 scanners, all those data are unseen during the training stage.**
**2) To evaluate the clinical performance of reconstruction foundation models under no less than 5 cardiovascular diseases (e.g., hypertrophic cardiomyopathy, dilated cardiomyopathy, myocardial infarction, coronary artery disease, arrhythmias), all those data are unseen during the training stage.**

This repository contains Matlab code for data loaders, undersampling functions, evaluation metrics, and reference implementations of simple baseline methods. It also contains implementations for methods in some of the publications of the CMRxRecon project.

## Challenge tasks
**The 'CMRxRecon2025' challenge includes two regular tasks (announced during MICCAI annual meeting) and two special tasks (announced during SCMR annual meeting). The tasks are awarded independently, so each team can choose to participate any one of them.** For each task, participants can submit one model each (which can be four different models, or they can submit just one model, but they must submit it separately for each task). Please note that for the four tasks, the training dataset we provide is the same; however, the validation and test datasets are different for each of the four tasks. 

**Our objective is to evaluate the model's generalization performance across diverse centers and scanners (Regular TASK 1), diseases (Tegular TASK 2), magnetic fields (Special TASK 1), and populations (Special TASK 2).**

![TaskText](https://github.com/CmrxRecon/CMRxRecon2025/blob/main/TaskText.png)
![TaskImage](https://github.com/CmrxRecon/CMRxRecon2025/blob/main/TaskImage.png)

**Regular TASK 1: CMR reconstruction model for multi-center evaluation**

This task primarily focuses on addressing the issue of declining generalization performance between multiple centers. Participants are required to train the reconstruction model on the training dataset and achieve good multi-contrast cardiac image reconstruction results on the validation and test datasets. It is important to note that for this task, we will include data from two entirely new centers in the validation set (not present in the training set), and the test set will contain data from five entirely new centers (not present in the training set, including the two centers that appeared in the validation set).

**TASK 2: Random sampling CMR reconstruction**

**1) Goal:** To develop a sampling-universal model that can robustly reconstruct CMR images 1) from different k-space trajectories (uniform, Guassian, and pseudo radial undersampling with temporal/parametric interleaving); 2) at different acceleration factors (acceleration factors from 4x to 24x, ACS not included for calculations). The proposed method is supposed to leverage deep learning algorithms to exploit the potential of random sampling, enabling faster acquisition times while maintaining high-quality image reconstructions.

**2) Note:** In TASK 2, participants are allowed to train **only one universal model** to reconstruct various data at the different undersampling scenarios (including different k-space trajectories: uniform, Guassian, and pseudo radial undersampling with temporal/parametric interleaving; and different acceleration factors: 4x, 8x, 12x, 16x, 20x, 24x, ACS not included for calculations); **TrainingSet includes Cine, Aorta, Mapping, and Tagging; ValidationSet and TestSet also include Cine, Aorta, Mapping, and Tagging**; the data size of Cine, Aorta, Mapping, and Tagging is 5D (nx,ny,nc,nz,nt); **the size of all undersampling masks is 3D (nx,ny,nt)**, the central 16 lines (ny, in ktUniform and ktGaussian) or central 16x16 regions (nx*ny, in ktRadial) are always fully sampled to be used as autocalibration signals (ACS).

![Task 2](https://github.com/CmrxRecon/CMRxRecon2024/blob/main/Overview_Task2.png)

## Documentation

### The CMRxRecon2025 Dataset
A total of 330 healthy volunteers are recruited for multi-contrast CMR imaging in our imaging center (3.0T Siemens Vida). **The dataset include multi-contrast k-space data, consist of cardiac cine, T1/T2mapping, tagging, phase-contrast (i.e., flow2d), and dark-blood imaging. It also includes imaging of different anatomical views like long-axis (2-chamber, 3-chamber, and 4-chamber), short-axis (SAX), left ventricul outflow tract (LVOT), and aorta (transversal and sagittal views)**.

![Task 1&2 Image](https://github.com/CmrxRecon/CMRxRecon2024/blob/main/Task1&2_ContrastImageCMR.png)

**The released dataset includes 200 training data, 60 validation data, and 70 test data.**

Training cases including fully sampled k-space data and sampling trajectories will be provided in '.mat' format.

Validation cases include under-sampled k-space data, sampling trajectories, and autocalibration signals (ACS, 16 lines or 16x16 regions) with various acceleration factors in '.mat' format.

Test cases include fully sampled k-space data, undersampled k-space data, sampling trajectories, and autocalibration signals (ACS, 16 lines or 16x16 regions). Test cases will not be released before the challenge ends.

![Task 1&2 Mask](https://github.com/CmrxRecon/CMRxRecon2024/blob/main/Task1&2_MaskCMR.png)

## Package Structure
* `CMRxReconDemo`: contains parallel imaging reconstruction code
* `ChallengeDataFormat`: explains the challenge data and the rules for data submission
* `CMRxReconMaskGeneration`: contains code for varied undersampling mask generation in different tasks
* `Evaluation`: contains image quality evaluation code for validation and testing
* `Submission`: contains the structure for challenge submission

## Contact
The code is provided to support reproducible research. If the code is giving syntax error in your particular configuration or some files are missing then you may open an issue or email us at CMRxRecon@outlook.com

## Publication references
You are free to use and/or refer to the CMRxRecon challenge and datasets in your own research after the embargo period (Dec 2025), provided that you cite the following manuscripts: 

**Reference of the CMR imaging acquisition protocol: **
1.	Wang C, Lyu J, Wang S, et al. CMRxRecon: A publicly available k-space dataset and benchmark to advance deep learning for cardiac MRI. Scientific Data, 2024, 11(1): 687.
2.	Wang C, Lyu J, Wang S, et al. CMRxRecon: An open cardiac MRI dataset for the competition of accelerated image reconstruction. arXiv preprint arXiv:2309.10836, 2023.
3.	Wang Z, Wang F, Qin C, et al. CMRxRecon2024: CMRxRecon2024: A Multimodality, Multiview k-Space Dataset Boosting Universal Machine Learning for Accelerated Cardiac MRI. Radiology: Artificial Intelligence. 2025, 7(2): e240443.
4.	Wang Z, Wang F, Qin C, et al. CMRxRecon2024: A Multi-Modality, Multi-View K-Space Dataset Boosting Universal Machine Learning for Accelerated Cardiac MRI. arXiv preprint arXiv:2406.19043, 2024.
5.	Lyu J, Qin C, Wang S, et al. The state-of-the-art in Cardiac MRI Reconstruction: Results of the CMRxRecon Challenge in MICCAI 2023. Medical Image Analysis. 2025. 101: 103485.
6.	Wang C, Li Y, Lv J, et al. Recommendation for Cardiac Magnetic Resonance Imaging-Based Phenotypic Study: Imaging Part. Phenomics. 2021, 1(4): 151-170. 
7.	Wang S, Qin C, Wang C, et al. The Extreme Cardiac MRI Analysis Challenge under Respiratory Motion (CMRxMotion). arXiv preprint arXiv:2210.06385, 2022.

**Reference for previously developed reconstruction algorithms: **
1.	Wang C, Jang J, Neisius U, et al. Black blood myocardial T2 mapping. Magnetic resonance in medicine. 2019, 81(1): 153-166. 
2.	Lyu J, Wang S, Tian Y, Zou J, Dong S, Wang C, Aviles-Rivero AI, Qin J. STADNet: Spatial-Temporal Attention-Guided Dual-Path Network for cardiac cine MRI super-resolution. Medical Image Analysis, 2024;94:103142.
3.	Lyu J, Li G, Wang C, et al. Region-focused multi-view transformer-based generative adversarial network for cardiac cine MRI reconstruction. Medical Image Analysis, 2023: 102760. 
4.	Lyu J, Tian Y, Cai Q, Wang C*, Qin J. Adaptive channel-modulated personalized federated learning for magnetic resonance image reconstruction. Computers in Biology and Medicine, 2023, 165: 107330.
5.	Qin C, Schlemper J, Caballero J, et al. Convolutional recurrent neural networks for dynamic MR image reconstruction. IEEE transactions on medical imaging, 2018, 38(1): 280-290. 
6.	Qin C, Duan J, Hammernik K, et al. Complementary time-frequency domain networks for dynamic parallel MR image reconstruction. Magnetic Resonance in Medicine, 2021, 86(6): 3274-3291. 
7.	Lyu J, Tian Y, Cai Q, et al. Adaptive channel-modulated personalized federated learning for magnetic resonance image reconstruction. Computers in Biology and Medicine, 2023, 165: 107330.
8.	Lyu J, Tong X, Wang C. Parallel Imaging With a Combination of SENSE and Generative Adversarial Networks (GAN). Quantitative Imaging in Medicine and Surgery. 2020, 10(12): 2260-2273. 
9.	Lyu J, Sui B, Wang C, et al. DuDoCAF: Dual-Domain Cross-Attention Fusion with Recurrent Transformer for Fast Multi-contrast MR Imaging. International Conference on Medical Image Computing and Computer-Assisted Intervention. Springer, Cham, 2022: 474-484.
10.	Ouyang C, Schlemper K, et al. Generalizing Deep Learning MRI Reconstruction across Different Domains, arXiv preprint arXiv: 1902.10815, 2019.
11.	Shangqi Gao, Hangqi Zhou, Yibo Gao, Xiahai Zhuang. BayeSeg: Bayesian Modeling for Medical Image Segmentation with Interpretable Generalizability. Medical Image Analysis Volume 89, 102889, 2023 (Elsevier-MedIA 1st Prize & MICCAl Best Paper Award 2023) 
