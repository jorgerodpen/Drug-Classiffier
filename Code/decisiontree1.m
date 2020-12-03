clear all, close all, clc
rng(2898) % For reproducibility

%% =====Reading the data
drug = readtable('cleaned_drug_consumption.csv', ...
    'VariableNamingRule', 'preserve');  % Full cleaned dataset

% ==Variables
predictors = {'Age', 'Gender', 'Education', 'Country', 'Ethnicity',...
    'Neuroticism', 'Extraversion', 'Openness to experience', ...
    'Agreeableness', 'Conscientiousness', 'Impulsiveness', ...
    'Sensation seeking'}; % Independent variables
target = {'Cannabis'}; % Dependent variables

% == Independent variables and target variable sets
X = drug(:,predictors); % Independent variables
y = drug(:,target); % Dependent/target variable

% == Train and test sets
[Xtest, Xtrain, ytest, ytrain] = traintestsplit(X, y, 0.2);

save('Xtest1','Xtest')
save('ytest1','ytest')