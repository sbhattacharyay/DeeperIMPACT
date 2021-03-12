# Deeper IMPACT: Ordinal Models for Outcome Prediction After Traumatic Brain Injury

## Contents

- [Overview](#overview)
- [Abstract](#abstract)
- [Code](#code)
- [License](./LICENSE)
- [Citation](#citation)

## Overview

This repository contains the code underlying the article entitled **Deeper IMPACT: Ordinal Models for Outcome Prediction After Traumatic Brain Injury** from the [CENTER-TBI](https://www.center-tbi.eu/) database. In this file, we present the abstract, to outline the motivation for the work and the findings, and then a brief description of the code which we generate these finding and achieve this objective.\
\
The code on this repository is commented throughout to provide a description of each step alongside the code which achieves it.

## Abstract
### Background/Objective:
### Methods
### Results
### Conclusions

## Code 
All of the code used in this work can be found in the `scripts` directory as R Markdown (`.Rmd`) files and Jupyter notebooks (`.ipynb`). We have also made the code available in `html` form with the following prefix `https://sbhattacharyay.github.io/DeeperIMPACT/html/` and the suffix `.html`. For instance, `scripts/15_manuscript_figures.Rmd` can also be accessed on a browswer at https://sbhattacharyay.github.io/DeeperIMPACT/html/15_manuscript_figures.html.

### 1. [Preprocessing of IMPACT predictor variables](scripts/01_preprocessing.Rmd)
### 2. [Testing of ordinal regression assumptions](scripts/02_ordinal_assumptions.Rmd)
### 3. [Multiple imputation, normalization by Box-Cox transformation, and SMOTE](scripts/03_impute_boxcox_smote.Rmd)
### 4. [Training and Evaluation of MNLR models](scripts/04_mnlr.Rmd)
### 5. [Training and Evaluation of POLR models](scripts/05_polr.Rmd)
### 6. [Training (with BBCD-CV) and prediction of DeepMN models](scripts/06_deepMN_part1.ipynb)
### 7. [Evaluation of DeepMN models](scripts/07_deepMN_part2.Rmd)
### 8. [Training (with BBCD-CV) and prediction of DeepOR models](scripts/08_deepOR_part1.ipynb)
### 9. [Evaluation of DeepOR models](scripts/09_deepOR_part2.Rmd)
### 10. [Calculate normalised confusion matrix values based on model classifications](scripts/10_calculate_confusion_matrices.ipynb)
### 11. [Calculate probability calibration curves using BBC-CV](scripts/11_calculate_calibrations.ipynb)
### 12. [Calculate SHAP values from DeepMN and DeepOR](scripts/12_calculate_shap_values.ipynb)
### 13. [Assessment of IMPACT predictor variable significance](scripts/13_predictor_significance.Rmd)
### 14. [Calculation of confidence intervals of model performance metrics and AUCs](scripts/14_calculate_metrics_auc.Rmd)
### 15. [Plotting of figures for the manuscript](scripts/15_manuscript_figures.Rmd)

## Citation
