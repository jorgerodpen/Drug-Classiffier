clear all; close all; clc

% Importing the file
A = importdata('drug_consumption.data');
cols = importdata('columnnames.txt');

% Number of rows and columns of the dataset
nrows = length(A);
ncols = length(split(cell2mat(A(1)),','));

% Creating the cell array structure
B = cell(nrows, ncols);
for i = 1:nrows
    row = split(cell2mat(A(i)),',');
    for j=1:ncols
        B(i,j)=row(j);
    end
end

% Converting to a dataset
dataset = cell2table(B);

% Converting to numerical columns
for i = 1:13
    dataset.(i) = str2double(dataset{:,i});
end

% Converting numerical to categorical variables
    % Variable names
agevars = {'18-24','25-34','35-44','45-54','55-64','+64'};
gendervar = {'Male','Female'};
eduvars = {'leftbefore16','left16','left17','left18','somecollege',...
    'professional','university','masters','doctorate'};
ctrvars = {'USA','NewZealand','OtherC','Australia','Ireland','Canada','UK'};
etnvars = {'Black','Asian','White','WhiteBlack','OtherE','WhiteAsian','BlackAsian'};

    % Score values
N = 12:60;
E = [16, 18:56, 58, 59];
O = [24, 26, 28:60];
A = [12, 16, 18, 23:60];
C = [17, 19:57, 59];
I = 0:9;
SS = 0:10;

    % Final list of values
finaldata = {agevars, gendervar, eduvars, ctrvars, etnvars,...
    N, E, O, A, C, I, SS};

% Generating cleaned dataset
cleaned= dataset(:,1);

for i = 2:13
    vars = finaldata{i-1};
    vars = repmat(vars,1,nrows);
    un = unique(dataset{:,i});
    index = un == dataset{:,i}';
    cleaned(:,i) = array2table(vars(index)');
end

% Drung consumption
for j = 14:ncols
    value = dataset{:,j};
    value = cellfun(@druguser, value);
    dataset{:,j} = value; 
end

% Giving the column names to the dataset
cleaned = [cleaned, dataset(:,14:end)];
cleaned.Properties.VariableNames = cols;
cleaned = cleaned(:,[2:13,19]);

% Generating file
writetable(cleaned,'cleaned_drug_consumption.csv')
disp('cleaned_drug_consumption.csv created')

% Function to determine if it is a user or no
function drug = druguser(str)
    % Values for criteria:
    % 0: Have used
    % 1: Decade-base user
    % 2: Year-base user
    % 3: Month-base user
    % 4: Week-base user
    % 5: Day-base user
    last = str(end);
    drug = {str2double(last) > 2};
end 