function AUC = bootstrapdt(Xtrain, ytrain, examples, leafsize, parents)
% Function to obtain the AUC from bootstrap validation.
% It performs bootstrap validation and then evaluates the AUC. 
% It works for logistic regression models. 
% inputs:
    % Xtrain     : Table containing the independent variables
    % ytrain     : Table containin the target data
    % example    : Number of bootstraps to perform for validation
    % leafsize   : Number of elements per leaf
    % parents    : Number of node observations

% outputs:
    % AUC
%
%
% Created by Jorge Rodriguez Peña
% Github: https://github.com/jorgerodpen
rng(2898) % For replication

    % Parameters
    [nrows, ncols] = size(Xtrain); % Number of rows in the dataset
    bootrows = round(nrows/examples); % Length of each bootstrap (equal)

    % Data to fill
    AUC = zeros(1,examples); % AUC

    % Loop
    for i = 1:examples

        % Empty bootstrap sets
        Xb = cell(bootrows,ncols); % To fill with the bootstrapped independent data
        yb = zeros(bootrows,1); % To fill with the bootstrapped dependent data
        indexes = zeros(bootrows,1); % To fill with the bootstrapped indexes

        % Filling the bootstrap
        for j = 1:bootrows
            index = randi(bootrows); % Random generated index
            Xb(j,:) = table2cell(Xtrain(index,:));
            yb(j) = ytrain{index,:};
            indexes(j) = index;
        end

        % Converting to tables for model training
        predictors = Xtrain.Properties.VariableNames;
        target = ytrain.Properties.VariableNames;
        Xb = cell2table(Xb, 'VariableNames', predictors);
        yb = array2table(yb, 'VariableNames', target);

        % Removing bootstrapped rows from the training set
        trainindex = setdiff(1:nrows,indexes); % Indexes not contained
        Xtb = Xtrain(trainindex,:); 
        ytb = ytrain(trainindex,:);

        % Training our model
        dt = fitctree(Xtb, ytb, 'MinLeafSize', leafsize, ... % Size of each leaf  
        'MinParentSize', parents);

        % Predicting with our model
        [~,scoreb] = predict(dt, Xb); 

            % Evaluation of each model
            %= AUC
            [~,~,~,AUCcv] = perfcurve(yb{:,:},scoreb(:,2),'1');
            AUC(i) = AUCcv;   
    end
end