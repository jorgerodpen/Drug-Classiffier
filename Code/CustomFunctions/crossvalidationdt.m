function AUC = crossvalidationdt(Xtrain, ytrain, folds, leafsize, parents)
% Function to obtain the AUC from cross validation.
% It performs cross validation and then evaluates the AUC. 
% It works for logistic regression models. 
% inputs:
    % Xtrain     : Table containing the independent variables
    % ytrain     : Table containin the target data
    % folds      : Number of folds to perform in cross validation
    % leafsize   : Number of elements per leaf
    % parents    : Number of node observations

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
        dt = fitctree(Xcv, ycv, 'MinLeafSize', leafsize, ... % Size of each leaf  
        'MinParentSize', parents);

        % Predicting
        [~,scorecv] = predict(dt, Xtestcv);

        % Evaluation of each model
        %= AUC
        [~,~,~,AUCcv] = perfcurve(ytestcv{:,:},scorecv(:,2),'1');
        AUC(i) = AUCcv;
    end

end