clear all, close all, clc
rng(2898) % For reproducibility
% =========================================================================
% =========================================================================
% ==============================RANDOM FOREST==============================
% ==============================SECOND ATTEMPT=============================
% =========================================================================
% =========================================================================
% For this first attempt we used categorical data for variables: 'Age',
% 'Gender', 'Education'. Personality tests contain numerical values. The 
% five factor model ('Neuroticism', 'Extraversion', 'Openness to 
% experience', 'Agreeableness', 'Conciestiousness') contain  values from  
% 12 to 60, while the 'Impulsiveness' and 'Sensation Seeking' tests are 
% scored from 0 to 9 and 10, respectively. 
% We used the area under the curve (AUC) as the meassure for model
% performance.
%
% NOTE: This code contains loops which have been commented out to avoid
% waiting too much for the code tu run. The data and variables used in this
% code have been saved into a file called 'randomforest1.mat'. This
% variables are loaded in the next code section. 

%% =====LOADING VARIABLES=====
% Uncomment to load the data
load('randomforest2')

%% =====Reading the data
drug = readtable('cleaned_drug_consumption.csv', ...
    'VariableNamingRule', 'preserve');  % Full cleaned dataset

% ==Variables
predictors = {'Age', 'Gender', 'Education',  'Neuroticism', ...
    'Extraversion', 'Openness to experience', 'Agreeableness', ...
    'Conscientiousness', 'Impulsiveness', 'Sensation seeking'}; % Independent variables
target = {'Cannabis'}; % Dependent variables

% == Independent variables and target variable sets
X = drug(:,predictors); % Independent variables
y = drug(:,target); % Dependent/target variable

% == Train and test sets
[Xtest, Xtrain, ytest, ytrain] = traintestsplit(X, y, 0.2);

%% Grid search for ideal values for the model
% We will try to optimize 3 hyper-parameters: 'MinLeafSize' (minimum number 
% of elements in each leaf), ''NumPredictorstoSample' (maximum number of
% predictors tu sample at each node), 'NumLearningCycles' (Trees in the
% forest in this case). 
% We will perform Bayesian Optimization and average out the results. 

% WARNING!
% This code may take some time to run. If you do not want to wait, you can
% load all the variables used in this document in the section above called
% "LOADING VARIABLES" and continue to the next section. 
%
% If you do want to run this code, please uncomment it from here: 

% % == Parameter values
% % MinLeafSize
% maxMinLeafSize = 1000; % This will lead to a model of 66 leafs
% minLeafSize = optimizableVariable('minLeafSize',[1,maxMinLeafSize], ...
%     'Type','integer');
% 
% % NumPredictorstoSample
% maxNumPredictors = 12; % We have a total of 12 predictors
% numPredictors = optimizableVariable('numPredictors', ...
%     [1,maxNumPredictors],'Type','integer');
% 
% % NumLearningCycles
% trees = 1000;
% numTrees = optimizableVariable('numTrees',[1,trees],'Type','integer');
% 
% % Hyperparameters
% hyperparametersRF = [minLeafSize; numPredictors; numTrees];
% 
% % == Bayesian optimization
% runs = 25; % Number bayesian optimization performed
% errbo = zeros(runs,1);
% params = {'minLeafSize','numPredictors','numTrees'};
% paramsbo = array2table(zeros(runs,3),'VariableNames', params);
% for i = 1:runs
%     tic
%     % Bayesian optimization
%     results = bayesopt(@(params)AUCrftrain(params, Xtrain, ytrain), ...
%         hyperparametersRF, 'AcquisitionFunctionName',...
%         'expected-improvement-plus', 'Verbose', 0, 'PlotFcn',[]);
%     
%     % Keeping the results for each bayesian optimization
%     errbo(i) = results.MinObjective;
%     paramsbo(i, :) = results.XAtMinObjective
%     toc
% end

%% Results from Bayesian Optimization
figure(1)
subplot(1,3,1), b1 = boxplot(paramsbo{:,1}, 'Widths', 4);
set(b1,'LineWidth',2)
xlabel('minLeafSize')
grid
ax1 = gca;
ax1.FontSize = 18;

subplot(1,3,2), b2 = boxplot(paramsbo{:,2}, 'Widths', 4);
set(b2,'LineWidth',2)
xlabel('numPredictors')
grid
ax2 = gca;
ax2.FontSize = 18;

subplot(1,3,3), b3 = boxplot(paramsbo{:,3}, 'Widths', 4);
set(b3,'LineWidth',2)
xlabel('# trees')
grid
ax3 = gca;
ax3.FontSize = 18;

% ==Median of the results
fprintf(['minLeafSize: %f +- %f\nnumPredictors: %f +-%f\n' ...
         'numTrees: %f +- %f\n \n'], ...
median(rmoutliers(paramsbo{:,1})), std(rmoutliers(paramsbo{:,1})), ...
median(paramsbo{:,2}), std(paramsbo{:,2}), ...
median(rmoutliers(paramsbo{:,3})), std(rmoutliers(paramsbo{:,3})))

% ==Best params
[value, idx] = min(errbo);
bestparams = paramsbo(idx,:);

fprintf(['Best parameters: \nminLeafSize: %f \nnumPredictors: %f \n' ...
         'numTrees: %f \n \n'], ...
bestparams.minLeafSize, bestparams.numPredictors, bestparams.numTrees)

%% Trees vs time
% We will try to see the relationship between the number of trees, the time
% it takes to train the model and the AUC obtained. 
% We used the medians of 'minLeafSize' (5) and 'numPredictors' (1) obtained 
% in the previous sections and changed the number of trees over time. 

% WARNING!
% This code may take some time to run. If you do not want to wait, you can
% load all the variables used in this document in the section above called
% "LOADING VARIABLES" and continue to the next section. 
%
% If you do want to run this code, please uncomment it from here:

% ntrees = 1000; % Evaluate up to this number of trees
% step = 10; % Number of trees added on each run
% trees = 1:step:ntrees;
% 
% t = zeros(floor(ntrees/step),1); % To store times
% AUCvst = zeros(floor(ntrees/step),1); % To store AUC
% for i = 1:floor(ntrees/step)
%     tic
%     basetree = templateTree('MinLeafSize', 5, ... % Size of each leaf  
%         'NumPredictorstoSample', 1); % Number of predictors sampled at each node
%     rf = fitcensemble(Xtrain, ytrain, 'Method', 'Bag', ...
%         'Learners', basetree, 'ClassNames', [0; 1], ...
%         'NumLearningCycles', trees(i)); % Number of trees 
%     time = toc;
%     [~,scorevs] = oobPredict(rf);
%     [~,~,~,AUCvs] = perfcurve(ytrain{:,:},scorevs(:,2),'1');
%     AUCvst(i) = AUCvs; 
%     t(i) = time;
% end

%% Trees vs time plots
figure(2)
subplot(2,1,1), plot(trees, AUCvst, 'LineWidth', 3, 'Color', [0.949,0.314,0.133])
xlabel('Number of trees')
ylabel('AUC')
title('2^{nd} model number of trees optimization results')
grid
ax = gca;
ax.FontSize = 18;
subplot(2,1,2), plot(trees, t, 'LineWidth', 3, 'Color', [0.949,0.314,0.133])
xlabel('Number of trees')
ylabel('Training time (s)')
grid
ax = gca;
ax.FontSize = 18;

%% =====Evaluation of our model
% WARNING!
% This code may take some time to run. If you do not want to wait, you can
% load all the variables used in this document in the section above called
% "LOADING VARIABLES" and continue to the next section. 
%
% If you do want to run this code, please uncomment it from here:

% %==Cross validation
% AUCcv = crossvalidationrf(Xtrain, ytrain, 10, 5, 1, 600);
% 
% %==Bootstrap validation
% AUCb = bootstraprf(Xtrain, ytrain, 5, 1, 600);

%% ===== Testing our model
% ==Test set value
tic
basetree = templateTree('MinLeafSize', 5, ... % Size of each leaf  
        'NumPredictorstoSample', 1); % Number of predictors sampled at each node
rf = fitcensemble(Xtrain, ytrain, 'Method', 'Bag', ...
        'Learners', basetree, 'ClassNames', [0; 1], ...
        'NumLearningCycles', 600); % Number of trees 
traintime = toc;

% ==Predicting with the model
[~,score] = predict(rf, Xtest); 
[~,~,~,AUCt] = perfcurve(ytest{:,:},score(:,2),'1');

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

%% =====Predictor importance
% WARNING!
% This code may take some time to run. If you do not want to wait, you can
% load all the variables used in this document in the section above called
% "LOADING VARIABLES" and continue to the next section. 
%
% If you do want to run this code, please uncomment it from here:

% imp = oobPermutedPredictorImportance(rf);

%% =====Visualizing predictor importance
figure(3)
bar(categorical(predictors,predictors),imp, 'FaceColor', [0.949,0.314,0.133])
ax = gca;
ax.FontSize = 18;
grid
xlabel('Predictors')
ylabel('Importance')
title('Predictor Importance for the 2^{nd} model random forest')