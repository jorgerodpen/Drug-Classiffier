clear all, close all, clc
rng(2898) % For reproducibility
% =========================================================================
% =========================================================================
% ==============================DECISION TREE==============================
% =============================SECOND ATTEMPT==============================
% =========================================================================
% =========================================================================
% For this first attempt we used categorical data for variables: 'Age',
% 'Gender', 'Education'. Personality tests contain numerical values. The 
% five factor model ('Neuroticism', 'Extraversion', 'Openness to 
% experience', 'Agreeableness', 'Conciestiousness') contain  values from  
% 12 to 60, while the 'Impulsiveness' and 'Sensation Seeking' tests are 
% scored from 0 to 9 and 10, respectively. 
% We used the area under the curve (AUC) as the meassure for error
%
% NOTE: This code contains loops which have been commented out to avoid
% waiting too much for the code tu run. The data and variables used in this
% code have been saved into a file called 'randomforest1.mat'. This
% variables are loaded in the next code section. 
%% =====LOADING VARIABLES=====
% Uncomment to load the data
load('decisiontree1')

%% =====Reading the data
drug = readtable('cleaned_drug_consumption.csv', ...
    'PreserveVariableNames', true);  % Full cleaned dataset

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

%% Bayesian optimization for ideal values for the model
% We will try to optimize 2 hyper-parameters: 'MinLeafSize' (minimum number 
% of elements in each leaf), 'MinParentSize' (number of node observations).
% We will perform Bayesian Optimization and average out the results. 

% WARNING!
% This code may take some time to run. If you do not want to wait, you can
% load all the variables used in this document in the section above called
% "LOADING VARIABLES" and continue to the next section. 
%
% If you do want to run this code, please uncomment it from here: 

% % == Parameter values
% % MinLeafSize
% maxMinLeafSize = 100; % This will lead to a model of 66 leafs
% minLeafSize = optimizableVariable('minLeafSize',[1,maxMinLeafSize], ...
%     'Type','integer');
% 
% % NumParents
% maxNumParents = 100; % We have a total of 12 predictors
% numParents = optimizableVariable('numParents', ...
%     [1,maxNumParents],'Type','integer');
% 
% hyperparametersDT = [minLeafSize; numParents];
% 
% % == Bayesian optimization
% runs = 25; % Number bayesian optimization performed
% errbo = zeros(runs,1);
% params = {'minLeafSize','numParents'};
% paramsbo = array2table(zeros(runs,2),'VariableNames', params);
% for i = 1:runs
%     % Bayesian optimization
%     results = bayesopt(@(params)AUCdttrain(params, Xtrain, ytrain), ...
%         hyperparametersDT, 'AcquisitionFunctionName',...
%         'expected-improvement-plus', 'Verbose', 0, ...
%         'PlotFcn', []);
%     % Keeping the results for each bayesian optimization
%     errbo(i) = results.MinObjective;
%     paramsbo(i, :) = results.XAtMinObjective
% end

%% Results from Bayesian Optimization
figure(1)
subplot(1,2,1), b1 = boxplot(paramsbo{:,1}, 'Widths', 4);
set(b1,'LineWidth',2)
xlabel('minLeafSize')
grid
ax1 = gca;
ax1.FontSize = 18;

subplot(1,2,2), b2 = boxplot(paramsbo{:,2}, 'Widths', 4);
set(b2,'LineWidth',2)
xlabel('numPredictors')
grid
ax2 = gca;
ax2.FontSize = 18;

% ==Median of the results
fprintf('minLeafSize: %f +- %f\nnumParents: %f +-%f\n \n', ...
median(paramsbo{:,1}), std(paramsbo{:,1}), ...
median(paramsbo{:,2}), std(rmoutliers(paramsbo{:,2})))

% ==Best params
[value, idx] = min(errbo);
bestparams = paramsbo(idx,:);

fprintf(['Best parameters: \nminLeafSize: %f \nnumPredictors: %f \n \n'], ...
bestparams.minLeafSize, bestparams.numParents)

%% =====Evaluation of our model

%==Cross validation
AUCcv = crossvalidationdt(Xtrain, ytrain, 10, 14, 1);

%==Bootstrap validation
AUCb = bootstrapdt(Xtrain, ytrain, 10, 14, 1);

%% ===== Testing our model
% ==Test set value
tic
dt = fitctree(Xtrain, ytrain, 'MinLeafSize', 14, ... % Size of each leaf  
        'MinParentSize', 1);
traintime = toc;

% ==Predicting with the model
[~,score] = predict(dt, Xtest); 
[Xdt2,Ydt2,~,AUCt] = perfcurve(ytest{:,:},score(:,2),'1');

% ==Confusion matrix
C = confusionmat(double(score(:,2)>=0.5),ytest{:,:});
TN = C(1,1);
TP = C(2,2); 
FN = C(2,1);
FP = C(1,2);
sensitivity = TP/(TP+FN)
specificity = TN/(TN+FP)

%% =====Displaying results
fprintf(['AUC for CV: %f +- %f\n' ...
    'AUC for bootstrap: %f +-%f\n' ...
'AUC for test: %f\nTime: %fs\n \n'], ...
mean(AUCcv), std(AUCcv), mean(AUCb), std(AUCb), AUCt, traintime)


%% =====Visualizing our tree
view(dt,'Mode','text')
view(dt,'Mode','graph')

%% =====Predictor importance
imp = predictorImportance(dt);
figure(3)
bar(categorical(predictors,predictors),imp)
ax = gca;
ax.FontSize = 18;
grid
xlabel('Predictors')
ylabel('Importance')