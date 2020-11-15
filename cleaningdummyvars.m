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
agevars = {'18to24','25to34','35to44','45to54','55to64','more64'};
eduvars = {'leftbefore16','left16','left17','left18','somecollege',...
    'professional','university','masters','doctorate'};
ctrvars = {'USA','NewZealand','OtherC','Australia','Ireland','Canada','UK'};
etnvars = {'Black','Asian','White','WhiteBlack','OtherE','WhiteAsian','BlackAsian'};
finaldata = {agevars, eduvars, ctrvars, etnvars};
cols = [2,4:6];

for i=1:4
    filter = round((dataset{:,cols(i)}+5)*100);
    dummy = dummyvar(filter);
    index = sum(dummy)~=0;
    dummy = dummy(:,index);
    joint = [tabledummies,array2table(dummy,'VariableNames',finaldata{i})];
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
    value = dataset{:,j};
    value = cellfun(@druguser, value);
    dataset{:,j} = value; 
end

% We will remove unnecessary columns such as:
% more64, leftbefore16, otherC, otherE
% Since we are using dummy values these are redundant. 
% Once the rest of the variables are 0, these variables are inmediately 1
tabledummies = [tabledummies(:,[1:7,10:19,21:28,30:end]), dataset(:,7:end)];

% Generating file
writetable(tabledummies,'cleaned_drug_consumption.csv')
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