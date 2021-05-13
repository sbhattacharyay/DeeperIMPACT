# Deeper IMPACT: Ordinal Models for Outcome Prediction After Traumatic Brain Injury

## Contents

- [Overview](#overview)
- [Abstract](#abstract)
- [Code](#code)
- [License](./LICENSE)
- [Citation](#citation)

## Overview

This repository contains the code underlying the article entitled **Deeper IMPACT: Ordinal Models for Outcome Prediction After Traumatic Brain Injury** from the [CENTER-TBI](https://www.center-tbi.eu/) database. In this file, we present the abstract, to outline the motivation for the work and the findings, and then a brief description of the code with which we generate these finding and achieve this objective.\
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
In this `.Rmd` script, we begin by extracting the [IMPACT](https://doi.org/10.1371/journal.pmed.0050165) predictors from the [CENTER-TBI](https://www.center-tbi.eu/) dataset. We then exclude patients under the age of 18 or for whom we do not have a GOSE label. We also fix unit mismatches for Haemoglobin (Hb) measurements. We then examine the distributions of the predictor variables and create the 100 splits for repeated cross-validation (20 repeats, 5 folds). Each of the folds were stratified to preserve GOSE imbalance as closely as possible. Finally, we performed stratified predictor mean analysis using Kruskal-Wallis rank sum tests and calculated the association of predictors with GOSE using Spearman correlations.

### 2. [Testing of ordinal regression assumptions](scripts/02_ordinal_assumptions.Rmd)
In this `.Rmd` script, we test two of the core assumptions of ordinal regression: no multicollinearity among predictors and equality of proportional odds between any pair of outcome group. Multicollinearity was checked visually via a correlogram as well as a Variance inflation factor (VIF) test. The proportional odds assumption was tested by calculating logit differences and by performing the Brant chi-squared test for proportional odds.

### 3. [Multiple imputation, normalization by Box-Cox transformation, and SMOTE](scripts/03_impute_boxcox_smote.Rmd)
In this `.Rmd` script, we perform multiple imputation with chained equations (MICE) to generate 100 imputataions of all missing predictor values. Then, we observe the resulting distributions of the imputed datasets to verify their plausibility. Following the imputations, we train Box-Cox transformations and scaling functions on the training sets and apply the transformation on both the training and validation sets accordingly. Finally, we create SMOTE'd versions of the normalised training sets as a hyperparamater for model tuning.

### 4. [Training and Evaluation of MNLR models](scripts/04_mnlr.Rmd)
In this `.Rmd` file, we train multinomial logistic regression (MNLR) models on both the normalised training sets and the SMOTE'd normalised training sets separately and return predictions of each model on the corresponding validation set. This process is repeated for each of the 100 splits in the repeated cross-validation paradigm, where each split is made on a unique imputation. Afterwards, we use 1,000 resamples of unique patients across the entire validation prediction set for Bootstrap Bias Corrected Cross-Validation (BBC-CV) to create unbiased estimates of classification metrics, probability curves (ROC and PRC), and associated 95% confidence intervals.

### 5. [Training and Evaluation of POLR models](scripts/05_polr.Rmd)
In this `.Rmd` file, we train proportional odds (a.k.a. ordinal) logistic regression (POLR) models on both the normalised training sets and the SMOTE'd normalised training sets separately and return predictions of each model on the corresponding validation set. This process is repeated for each of the 100 splits in the repeated cross-validation paradigm, where each split is made on a unique imputation. Afterwards, we use 1,000 resamples of unique patients across the entire validation prediction set for Bootstrap Bias Corrected Cross-Validation (BBC-CV) to create unbiased estimates of classification metrics, probability curves (ROC and PRC), and associated 95% confidence intervals.

### 6. [Training (with BBCD-CV) and prediction of DeepMN models](scripts/06_deepMN_part1.ipynb)
In this `.ipynb` file, we train class-weighted feedforward neural network models with a multinomial (SoftMax) output layer (DeepMN) of each of the viable hyperparameter combinations on both the normalised training sets and the SMOTE'd normalised training sets separately and return predictions of each model on the corresponding validation set. This process is repeated for each of the 100 splits in the repeated cross-validation paradigm, where each split is made on a unique imputation. To boost the efficiency of training, after training and validation on a particular split is completed, we use 200 resamples of unique patients across the compiled validation prediction set up to that point for Bootstrap Bias Corrected with Dropping Cross-Validation (BBCD-CV) to remove hyperparameter configurations that consistently (99+%) underperform from future consideration.

### 7. [Evaluation of DeepMN models](scripts/07_deepMN_part2.Rmd)
In this `.Rmd` file, we use 1,000 resamples of unique patients across the entire validation prediction set for Bootstrap Bias Corrected Cross-Validation (BBC-CV) to create unbiased estimates of classification metrics, probability curves (ROC and PRC), and associated 95% confidence intervals for DeepMN.

### 8. [Training (with BBCD-CV) and prediction of DeepOR models](scripts/08_deepOR_part1.ipynb)
In this `.ipynb` file, we train class-weighted feedforward neural network models with a ordinal (sigmoid) output layer (DeepOR) of each of the viable hyperparameter combinations on both the normalised training sets and the SMOTE'd normalised training sets separately and return predictions of each model on the corresponding validation set. This process is repeated for each of the 100 splits in the repeated cross-validation paradigm, where each split is made on a unique imputation. To boost the efficiency of training, after training and validation on a particular split is completed, we use 200 resamples of unique patients across the compiled validation prediction set up to that point for Bootstrap Bias Corrected with Dropping Cross-Validation (BBCD-CV) to remove hyperparameter configurations that consistently (99+%) underperform from future consideration.

### 9. [Evaluation of DeepOR models](scripts/09_deepOR_part2.Rmd)
In this `.Rmd` file, we use 1,000 resamples of unique patients across the entire validation prediction set for Bootstrap Bias Corrected Cross-Validation (BBC-CV) to create unbiased estimates of classification metrics, probability curves (ROC and PRC), and associated 95% confidence intervals for DeepOR.

### 10. [Calculate normalised confusion matrix values based on model classifications](scripts/10_calculate_confusion_matrices.ipynb)
In this `.ipynb` file, we produce true-label-normalised confusion matrix values for each of the four model types using the optimal performing hyperparameter configuration in each of the 20 repeats of the repeated cross-validation paradigm.

### 11. [Calculate probability calibration curves using BBC-CV](scripts/11_calculate_calibrations.ipynb)
In this `.ipynb` file, we use 1,000 resamples of unique patients across the entire validation prediction set for Bootstrap Bias Corrected Cross-Validation (BBC-CV) to create unbiased estimates of probability calibration curves for each of the four model types. During each step of the BBC-CV procedure, we select the current configuration by minimise the mean-squared error between the predicted probabilities and true positive fractions on in the in-sample and then calculate the probability calibration of that configuration on the corresponding out-sample.

### 12. [Calculate SHAP values from DeepMN and DeepOR](scripts/12_calculate_shap_values.ipynb)
In this `.ipynb` file, we calculate SHapley Additive exPlanations (SHAP) values to evaluate the relative importance of features in predicting GOSE. The SHAP explainer trained expected values over 100 stratified random samples from the training set of each of the 100 partitions/imputations and used to explain model predictions on 30 stratified random samples from the corresponding validation set. In each repeat, we limited calculation of SHAP on the best-performing model (in terms of macro-averaged AUROC) over the 5 folds.

### 13. [Assessment of IMPACT predictor variable significance](scripts/13_predictor_significance.Rmd)
In this `.Rmd` file, we first extract the learned coefficients of each of trained MNLR and POLR models, as well as the corresponding *p*-values of the coefficients. We then use a *z*-transform to calculate the *p*-value of coefficients across folds and repeats. We use the mean absolute values of coefficients as metrics of relative importance of predictors in MNLR and POLR. We then perform paired, pairwise Wilcoxon tests on the mean absolute SHAP values to compare feature significance, correcting for all other variables.

### 14. [Calculation of confidence intervals of model performance metrics and AUCs](scripts/14_calculate_metrics_auc.Rmd)
In this `.Rmd` script, we summarise the BBC-CV classification metrics and AUCs (AUROC and AUPRC) calculated in each of the model scripts to return the mean value and 95% confidence interval for every combination of model and GOSE score (including overall and macro-averaged).

### 15. [Plotting of figures for the manuscript](scripts/15_manuscript_figures.Rmd)
This `.Rmd` script contains the code corresponding to the formatted figures in the manuscript. The majority of figures were made using the `ggplot` package in R.

## Citation
