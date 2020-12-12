# Drug consumption classiffier 

Use Matlab2020a. 

## Folders

### Code 

Contains all the code used to train and evaluate our models. Some sections are commented out to skip parts of the code that take longer to run (some sections might take more than an hour). The data generated in those sections was save as a .mat file and is loaded at the beginning of the code. There are four models: 
- randomforest1.m
- randomforest2.m
- decisiontree1.m
- decisiontree2.m

Each one with their correspondent .mat files containing the data to run them.  

Inside this folder, the .csv file containing the data has been included as cleaned_drug_consumption.csv. 

Other files in this folder are self-made functions to perform k-fold cross validation or bootstrap validation for each model, and all contain descriptions. In order to run the .m files, this functions need to be in the same folder as them, or alternatively, in a folder the user has destined to store and use MatLAB functions. This functions are:

- AUCdttrain.m (To use as objective function in Bayesian optimization for decision trees)
- AUCrftrain.m (To use as objective function in Bayesian optimization for random forest)
- bootstrapdt.m (To perform bootstrap validation in decision trees)
- bootstraprf.m (To perform out-of-bag bootstrap validation in random forests)
- crossvalidationdt.m (To perform k-fold cross validation in decision trees)
- crossvalidationrf.m (To perform k-fold cross validation in random forests)

An extra folder is included with the code used to clean the data (cleaned.m).

### Models

Contains the four models implemented in this project. To load them, use the models.m file. This file automatically reads, and uses the models in the test set, returning the AUC score obtained. You just need to change two variables:

model_name: Type 'dt' for decision tree and 'rf' for random forest.
model_version: Type 1 for models with all the variables and 2 for model excluding 'Country' and 'Ethnicity'

This file will display in the command window the AUC of the test set. 

### PosterAndExtra

Contains the Poster and Suplementary Material as pdf files. Both the poster and the supplementary material contain all the information needed to understand the project and see its main results. 