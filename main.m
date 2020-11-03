clear all; close all; clc

% Importing the file
filename = "drug_consumption.data";
A = importdata(filename);
cols = importdata('columnnames.txt');

% Reding the file into a dataframe
nrows = length(A);
ncols = length(split(cell2mat(A(1)),','));

% Check if rows have different number of columns
for i=2:nrows;
    if length(strsplit(cell2mat(A(i)),','))~=ncols;
        emsg = "Some rows do not have the same number of columns.";
        emsg = emsg + "\n";
        emsg = emsg + "Unable to read the file.";
        emsg = compose(emsg)
        error(emsg)
    end
end

% Creating the cell array structure
B = cell(nrows, ncols);
for i=1:nrows;
    row = split(cell2mat(A(i)),',');
    for j=1:ncols;
        B(i,j)=row(j);
    end
end

% Converting to a dataset
dataset = cell2table(B,'VariableNames',cols);