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
dataset = cell2table(B,'VariableNames',cols);

% Converting to numerical columns
for i = 1:13
    dataset.(i) = str2double(dataset{:,i});
end

%Cleaning gender
dataset.Gender = dataset.Gender < 0;

% Generating the final dataset with dummy variables
tabledummies = dataset(:,[1,3]);

% Converting numerical columns to dummy variables
    % Column names
agecols = {'18to24','25to34','35to44','45to54','55to64','more64'};
educols = {'leftbefore16','left16','left17','left18','somecollege',...
    'professional','university','masters','doctorate'};
ctrcols = {'USA','NewZealand','OtherC','Australia','Ireland','Canada','UK'};
etncols = {'Black','Asian','White','WhiteBlack','OtherE','WhiteAsian','BlackAsian'};
colnames = {agecols, educols, ctrcols, etncols};
cols = [2,4:6];

for i=1:4
    filter = round((dataset{:,cols(i)}+5)*100);
    dummy = dummyvar(filter);
    index = sum(dummy)~=0;
    dummy = dummy(:,index);
    joint = [tabledummies,array2table(dummy,'VariableNames',colnames{i})];
    tabledummies = joint;
end

% Score values
N = 12:60;
E = [16, 18:56, 58, 59];
O = [24, 26, 28:60];
A = [12, 16, 18, 23:60];
C = [17, 19:57, 59];
I = 0:9;
SS = 0:10;
cols = 7:13;
tests = {N, E, O, A, C, I, SS};
for i = 1:length(cols)
    col = cols(i);
    test = tests{i};
    test = repmat(test,1,1885);
    un = unique(dataset{:,col});
    index = un == dataset{:,col}';
    dataset{:,col} = test(index)';
end

% Drung consumption
for j = 14:ncols
    for i = 1:nrows
        value = dataset{i,j};
        value = value{1};
        value = value(end);
        value = str2double(value) > 1; % Drug consumer 
        % Values for criteria:
        % 0: Have used
        % 1: Decade-base user
        % 2: Year-base user
        % 3: Month-base user
        % 4: Week-base user
        % 5: Day-base user
        dataset{i,j} = {value};
    end
end

tabledummies = [tabledummies, dataset(:,7:end)];

% Generating file
writetable(tabledummies,'cleaned_drug_consumption.csv')
disp('cleaned_drug_consumption.csv created')