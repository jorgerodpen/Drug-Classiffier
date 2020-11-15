clear all; close all; clc

% Importing the file
dataset = readtable("cleaned_drug_consumption.csv","VariableNamingRule","preserve");

x = dataset{:,1:38};
y = categorical(dataset{:,39});
B = mnrfit(x,y)