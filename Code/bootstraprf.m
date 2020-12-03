function AUC = bootstraprf(Xtrain, ytrain, leafsize, predictors, trees)
% Function to obtain the AUC and the confusion matrix from bootstrap
% validation.
% It performs bootstrap validation and then evaluates the AUC and the 
% confusion matrix.
% It works for bagged random forests models. 
% inputs:
    % Xtrain   : Table containing the independent variables
    % ytrain   : Table containin the target data

% outputs:
    % [AUC, accuracy, recall, specificity]
%
%
% Created by Jorge Rodriguez Peña
% Github: https://github.com/jorgerodpen
rng(2898) % For replication

% Out of bag validation
    % Fitting the model
    basetree = templateTree('MinLeafSize', leafsize, ... % Size of each leaf  
    'NumPredictorstoSample', predictors); % Number of predictors sampled at each node
    rf = fitcensemble(Xtrain, ytrain, 'Method', 'Bag', ...
    'Learners', basetree, 'ClassNames', [0; 1], ...
    'NumLearningCycles', trees); % Number of trees 

    % Predicting with our model
    [~,scoreb] = oobPredict(rf); 
    
    % Extracting values
    %= AUC
    [~,~,~,AUC] = perfcurve(ytrain{:,:},scoreb(:,2),'1');  
end