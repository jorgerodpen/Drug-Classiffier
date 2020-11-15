function [Xtest, Xtrain, ytest, ytrain] = traintestsplit(X, y, pct)
% Function to separate the train from the test data. 
% inputs:
    %X   : Data containing the variables
    %y   : Target data
    %pct : Percentage of test data

% outputs:
    % Xtest, Xtrain, ytest, ytrain
%
%
% Created by Jorge Rodriguez Peña
% Github: https://github.com/jorgerodpen
%
    if length(X) ~= length(y)
        error("X and y do not have the same length. \n Check the length and try again.")
    else
        data_len=length(y);
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