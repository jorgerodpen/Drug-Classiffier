function [Xtest, Xtrain, ytest, ytrain] = traintestsplit(X, y, pct)
% Function to separate the train from the test data. 
% It randomly selects rows from the dataset and assign them to the train or
% the test datasets in the desired proportion. 
% inputs:
    %X   : Table containing the independent variables
    %y   : Table containin the target data
    %pct : Percentage of test data

% outputs:
    % Xtest, Xtrain, ytest, ytrain
%
%
% Created by Jorge Rodriguez Peña
% Github: https://github.com/jorgerodpen
rng(2898)
    if height(X) ~= height(y)
        error("X and y do not have the same length. \n Check the length and try again.")
    else
        data_len=height(y);
    end
    num_test=round(data_len*pct);
    index=randperm(data_len);
    index_test=index(1:num_test);
    index_train=index(num_test+1:end);
    Xtest=X(index_test,:);
    Xtrain=X(index_train,:);
    ytest=y(index_test,:);
    ytrain=y(index_train,:);
end