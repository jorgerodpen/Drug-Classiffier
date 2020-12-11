clear all
close all
clc
% ===================
% Inputs
model_name = 'dt';
model_version = 1;
% ===================

% Loading elements
model_file = join([model_name,'model',num2str(model_version)],'.mat');
Xtest_file = join(['Xtest',num2str(model_version),'.mat']);
ytest_file = join(['ytest',num2str(model_version),'.mat']);

% Loading model
if sum(model_name == 'dt') == 2
    model = load(model_file);
    model = model.dt;
elseif sum(model_name == 'rf') == 2
    model = load(model_file);
    model = model.rf;
else
    display('Error. model_name should be dt or rf')
end

% Loading variables
load(Xtest_file)
load(ytest_file)

% Testing
[y,score] = predict(model, Xtest);

% Getting AUC
[~,~,~,AUC] = perfcurve(ytest{:,:},score(:,2),'1')