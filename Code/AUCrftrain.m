function AUC = AUCrftrain(params, Xtrain, ytrain)
    basetree = templateTree('MinLeafSize', params.minLeafSize, ... % Size of each leaf  
        'NumPredictorstoSample', params.numPredictors); % Number of predictors sampled at each node
    rf = fitcensemble(Xtrain, ytrain, 'Method', 'Bag', ...
        'Learners', basetree, 'ClassNames', [0; 1], ...
        'NumLearningCycles', params.numTrees); % Number of trees 

    % Predicting with our model
    [~,scoreb] = oobPredict(rf); 
    
    % Extracting values
    %= AUC
    [~,~,~,AUC] = perfcurve(ytrain{:,:},scoreb(:,2),'1');
    AUC = 1 - AUC; 
end