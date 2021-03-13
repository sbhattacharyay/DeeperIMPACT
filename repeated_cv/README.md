## Repeated cross-validation directory
Directory in which active scripts of the repository save information after each of the repeated cross-validation splits.

`dl_tuning_grid.csv` contains all the hyperparameter configuration combinations tested for DeepMN and DeepOR. 

`deepMN_banned_tuning_indices.csv` contains all the hyperparameter configuration combinations that were dropped (according to BBCD-CV) during the training and validation of DeepMN.

`deepOR_banned_tuning_indices.csv` contains all the hyperparameter configuration combinations that were dropped (according to BBCD-CV) during the training and validation of DeepOR.
