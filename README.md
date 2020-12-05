# Drug consumption classiffier 

Use Matlab2020a. 

## Folders

### Code 

Contains all the code used to train and evaluate our models. Some sections are commented out to skip longer parts of code (might take more than an hour for each model) but the data has been stored in separate files and loaded at the beginning of the code to avoid this. There are four models: 
- randomforest1.m
-randomforest2.m
-decisiontree1.m-
decisiontree2.m

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

Contains the four models implemented in this project. To load and test the models use the code specified bellow:

- dtmodel1.mat (Decision tree with all the variables)

model = load('dtmodel1.mat');
decisiontree = model.dt;
load('Xtest1.mat')
load('Ytest1.mat')
[y,score] = predict(decisiontree, Xtest);


- rfmodel1.mat (Random forest with all the varaibles)

model = load('rfmodel1.mat');
randomforest = model.rf;
load('Xtest1.mat')
load('Ytest1.mat')
[y,score] = predict(randomforest, Xtest);


- dtmodel2.mat (Decision tree excluding Country and Ethnicity)

model = load('dtmodel2.mat');
decisiontree = model.dt;
load('Xtest2.mat')
load('Ytest2.mat')
[y,score] = predict(decisiontree, Xtest);


- rfmodel2.mat (Random forest excluding Country and Ethnicity)

model = load('rfmodel2.mat');
randomforest = model.rf;
load('Xtest2.mat')
load('Ytest2.mat')
[y,score] = predict(randomforest, Xtest);

### PosterAndExtra
s
Contains the Poster and Suplementary Material pdf files, containing all the information related to the project. 