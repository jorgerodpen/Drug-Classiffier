function AUC = ...
    crossvalidationrf(Xtrain, ytrain, folds, leafsize, predictors, trees)
% Function to obtain the AUC and the confusion matrix from cross
% validation
% It performs cross validation and then evaluates the AUC and the confusion
% matrix.
% It works for bagged random forest models. 
% inputs:
    % Xtrain     : Table containing the independent variables
    % ytrain     : Table containin the target data
    % folds      : Number of folds to perform in cross validation
    % leafsize   : Number of elements per leaf
    % predictors : Number of predictors sampled at each node
    % trees      : Number of trees

% outputs:
    % AUC
%
%
% Created by Jorge Rodriguez Peña
% Github: https://github.com/jorgerodpen
rng(2898) % For replication

    % Partitions
    cvp = cvpartition(ytrain{:,:}, 'KFold', folds);

    % Data to fill
    AUC = zeros(1,folds); % AUC

    % Loop
    for i = 1:folds

        % Train and test sets
        Xcv = Xtrain(cvp.training(i),:);
        ycv = ytrain(cvp.training(i),:);
        Xtestcv = Xtrain(cvp.test(i),:);
        ytestcv = ytrain(cvp.test(i),:);

        % Fitting the model
        basetree = templateTree('MinLeafSize', leafsize, ... % Size of each leaf  
        'NumPredictorstoSample', predictors); % Number of predictors sampled at each node
        rf = fitcensemble(Xcv, ycv, 'Method', 'Bag', ...
        'Learners', basetree, 'ClassNames', [0; 1], ...
        'NumLearningCycles', trees); % Number of trees 

        % Predicting
        [~,scorecv] = predict(rf, Xtestcv);

        % Evaluation of each model
        %= AUC
        [~,~,~,AUCcv] = perfcurve(ytestcv{:,:},scorecv(:,2),'1');
        AUC(i) = AUCcv;
    end

end

