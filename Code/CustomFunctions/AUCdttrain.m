function AUC = AUCdttrain(params, Xtrain, ytrain)
    AUC1 = bootstrapdt(Xtrain, ytrain, 5, ...
        params.minLeafSize, params.numParents);

    AUC2 = crossvalidationdt(Xtrain, ytrain, 5, ...
        params.minLeafSize, params.numParents);
    
    % Extracting values
    %= AUC
    AUC = mean([AUC1, AUC2]); 
    AUC = 1 - AUC; 
end