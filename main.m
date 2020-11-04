clear global; close all; clc

% Importing the file
disp("Loading data...")
filename = "drug_consumption.data";
colsfilename = "columnnames.txt";
A = importdata(filename);
cols = importdata(colsfilename);

% Number of rows and columns of the dataset
nrows = length(A);
ncols = length(split(cell2mat(A(1)),','));

% Check if rows have different number of columns t
for i=2:nrows
    if length(strsplit(cell2mat(A(i)),','))~=ncols
        emsg = "Some rows do not have the same number of columns.";
        emsg = emsg + "\n"+ "Unable to read the file.";
        emsg = emsg + "\n"+"Row number: " + num2str(i);
        emsg = compose(emsg);
        error(emsg)
    end
end

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
disp("Data loaded")
disp("Cleaning data...")
% Converting numerical columns
for i = 1:13
    dataset.(i) = str2double(dataset{:,i});
end

% Converting numerical columns to categorical variables
disp("Cleaning categorical variables...")
for i = 1:nrows
    % Age
    % 0 = 18-24
    % 1 = 25-34
    % 2 = 35-44
    % 3 = 45-54
    % 4 = 55-64
    % 5 = +65
    if dataset{i,2}<=-0.5
        dataset{i,2} = 0;
    elseif dataset{i,2}>-0.5 && dataset{i,2}<=0
        dataset{i,2} = 1;
    elseif dataset{i,2}>0.3 && dataset{i,2}<=0.9 
        dataset{i,2} = 2;
    elseif dataset{i,2}>0.9 && dataset{i,2}<=1.3
        dataset{i,2} = 3;
    elseif dataset{i,2}>1.5 && dataset{i,2}<=2
        dataset{i,2} = 4;
    elseif dataset{i,2}>2
        dataset{i,2} = 5;
    else
        dataset{i,2} = NaN;
    end 
    
    % Gender
    % 0 = Male
    % 1 = Female
    if dataset{i,3}<0
        dataset{i,3} = 0;
    elseif dataset{i,3}>0
        dataset{i,3} = 1;
    else
        dataset{i,3} = NaN;
    end 
    
    % Education
    % 0 = Left school before 16 years
    % 1 = Left school at 16 years
    % 2 = Left school at 17 years
    % 3 = Left school at 18 years
    % 4 = Some college or university, no certificate or degree
    % 5 = Some college or university, no certificate or degree
    % 6 = University degree
    % 7 = Masters degree
    % 8 = Doctorate degree
    if dataset{i,4}<-2.3
        dataset{i,4} = 0;
    elseif dataset{i,4}>-1.8 && dataset{i,4}<-1.6
        dataset{i,4} = 1;
    elseif dataset{i,4}>-1.6 && dataset{i,4}<-1.4
        dataset{i,4} = 2;
    elseif dataset{i,4}>-1.4 && dataset{i,4}<-1.2
        dataset{i,4} = 3;
    elseif dataset{i,4}>-1 && dataset{i,4}<-0.5
        dataset{i,4} = 4;
    elseif dataset{i,4}>-0.5 && dataset{i,4}<0.2
        dataset{i,4} = 5;
    elseif dataset{i,4}>0.3 && dataset{i,4}<1
        dataset{i,4} = 6;
    elseif dataset{i,4}>1 && dataset{i,4}<1.5
        dataset{i,4} = 7;
    elseif dataset{i,4}>1.5 && dataset{i,4}<2
        dataset{i,4} = 8;
    else
        dataset{i,4} = NaN;
    end 
    
    % Country
    % 0 = USA
    % 1 = New Zealand
    % 2 = Other
    % 3 = Australia
    % 4 = Republic of Ireland
    % 5 = Canada
    % 6 = UK
    if dataset{i,5}<-0.5
        dataset{i,5} = 0;
    elseif dataset{i,5}>-0.5 && dataset{i,5}<-0.4
        dataset{i,5} = 1;
    elseif dataset{i,5}>-0.3 && dataset{i,5}<-0.2
        dataset{i,5} = 2;
    elseif dataset{i,5}>-0.1 && dataset{i,5}<0
        dataset{i,5} = 3;
    elseif dataset{i,5}>0.21 && dataset{i,5}<0.22
        dataset{i,5} = 4;
    elseif dataset{i,5}>0.24 && dataset{i,5}<0.25
        dataset{i,5} = 5;
    elseif dataset{i,5}>0.9
        dataset{i,5} = 6;
    else
        dataset{i,5}=NaN;
    end
    
    % Ethnicity
    % 0 = Black
    % 1 = Asian
    % 2 = White
    % 3 = Mixed-White/Black
    % 4 = Other
    % 5 = Mixed-White/Asian
    % 6 = Mixed-Black/Asian
    if dataset{i,6}<-1
        dataset{i,6} = 0;
    elseif dataset{i,6}>-0.6 && dataset{i,6}<-0.5
        dataset{i,6} = 1;
    elseif dataset{i,6}>-0.4 && dataset{i,6}<-0.3
        dataset{i,6} = 2;
    elseif dataset{i,6}>-0.3 && dataset{i,6}<-0.2
        dataset{i,6} = 3;
    elseif dataset{i,6}>0.11 && dataset{i,6}<0.12
        dataset{i,6} = 4;
    elseif dataset{i,6}>0.12 && dataset{i,6}<0.4
        dataset{i,6} = 5;
    elseif dataset{i,6}>1
        dataset{i,6} = 6;
    else
        dataset{i,6}=NaN;
    end 
end

% Mapping non-numerical columns to numbers
disp("Cleaning drug use...")
for i = 14:ncols
    for j = 1:nrows
        if dataset{j,i}=="CL0"
            dataset{j,i} = {0};
        elseif dataset{j,i}=="CL1"
            dataset{j,i} = {1};
        elseif dataset{j,i}=="CL2"
            dataset{j,i} = {2};
        elseif dataset{j,i}=="CL3"
            dataset{j,i} = {3};
        elseif dataset{j,i}=="CL4"
            dataset{j,i} = {4};
        elseif dataset{j,i}=="CL5"
            dataset{j,i} = {5};
        else
            dataset{j,i} = {6};
        end
    end
end
disp("Data cleaned")