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
    
    %Neutoriticism
    if dataset{i,7}<-3.4
        dataset{i,7} = 12;
    elseif dataset{i,7}>-3.4 && dataset{i,7}<-3.1
        dataset{i,7} = 13;
    elseif dataset{i,7}>-3.1 && dataset{i,7}<-2.7
        dataset{i,7} = 14;
    elseif dataset{i,7}>-2.7 && dataset{i,7}<-2.5
        dataset{i,7} = 15;
    elseif dataset{i,7}>-2.5 && dataset{i,7}<-2.4
        dataset{i,7} = 16;
    elseif dataset{i,7}>-2.4 && dataset{i,7}<-2.3
        dataset{i,7} = 17;
    elseif dataset{i,7}>-2.3 && dataset{i,7}<-2.2
        dataset{i,7} = 18;
    elseif dataset{i,7}>-2.2 && dataset{i,7}<-2
        dataset{i,7} = 19;
    elseif dataset{i,7}>-2 && dataset{i,7}<-1.8
        dataset{i,7} = 20;
    elseif dataset{i,7}>-1.8 && dataset{i,7}<-1.6
        dataset{i,7} = 21;
    elseif dataset{i,7}>-1.6 && dataset{i,7}<-1.5
        dataset{i,7} = 22;
    elseif dataset{i,7}>-1.5 && dataset{i,7}<-1.4
        dataset{i,7} = 23;
    elseif dataset{i,7}>-1.4 && dataset{i,7}<-1.3
        dataset{i,7} = 24;
    elseif dataset{i,7}>-1.3 && dataset{i,7}<-1.1
        dataset{i,7} = 25;
    elseif dataset{i,7}>-1.1 && dataset{i,7}<-1
        dataset{i,7} = 26;        
    elseif dataset{i,7}>-1 && dataset{i,7}<-0.9
        dataset{i,7} = 27;  
    elseif dataset{i,7}>-0.9 && dataset{i,7}<-0.7
        dataset{i,7} = 28;  
    elseif dataset{i,7}>-0.7 && dataset{i,7}<-0.6
        dataset{i,7} = 29; 
    elseif dataset{i,7}>-0.6 && dataset{i,7}<-0.5
        dataset{i,7} = 30; 
    elseif dataset{i,7}>-0.5 && dataset{i,7}<-0.4
        dataset{i,7} = 31; 
    elseif dataset{i,7}>-0.4 && dataset{i,7}<-0.3
        dataset{i,7} = 32;
    elseif dataset{i,7}>-0.3 && dataset{i,7}<-0.2
        dataset{i,7} = 33;
    elseif dataset{i,7}>-0.2 && dataset{i,7}<-0.1
        dataset{i,7} = 34;
    elseif dataset{i,7}>-0.1 && dataset{i,7}<0
        dataset{i,7} = 35;
    elseif dataset{i,7}>0 && dataset{i,7}<0.1
        dataset{i,7} = 36;
    elseif dataset{i,7}>0.1 && dataset{i,7}<0.2
        dataset{i,7} = 37;
    elseif dataset{i,7}>0.2 && dataset{i,7}<0.3
        dataset{i,7} = 38;
    elseif dataset{i,7}>0.3 && dataset{i,7}<0.4
        dataset{i,7} = 39;
    elseif dataset{i,7}>0.4 && dataset{i,7}<0.5
        dataset{i,7} = 40;
    elseif dataset{i,7}>0.5 && dataset{i,7}<0.6
        dataset{i,7} = 41;
    elseif dataset{i,7}>0.6 && dataset{i,7}<0.7
        dataset{i,7} = 42;
    elseif dataset{i,7}>0.7 && dataset{i,7}<0.8
        dataset{i,7} = 43;
    elseif dataset{i,7}>0.8 && dataset{i,7}<0.9
        dataset{i,7} = 44;
    elseif dataset{i,7}>0.9 && dataset{i,7}<1
        dataset{i,7} = 45;
    elseif dataset{i,7}>1 && dataset{i,7}<1.1
        dataset{i,7} = 46;
    elseif dataset{i,7}>1 && dataset{i,7}<1.1
        dataset{i,7} = 46;
    elseif dataset{i,7}>1.1 && dataset{i,7}<1.2
        dataset{i,7} = 47;
    elseif dataset{i,7}>1.2 && dataset{i,7}<1.3
        dataset{i,7} = 48;
    elseif dataset{i,7}>1.3 && dataset{i,7}<1.4
        dataset{i,7} = 49;
    elseif dataset{i,7}>1.4 && dataset{i,7}<1.5
        dataset{i,7} = 50;
    elseif dataset{i,7}>1.5 && dataset{i,7}<1.7
        dataset{i,7} = 51;
    elseif dataset{i,7}>1.7 && dataset{i,7}<1.8
        dataset{i,7} = 52;
    elseif dataset{i,7}>1.8 && dataset{i,7}<1.9
        dataset{i,7} = 53;
    elseif dataset{i,7}>1.9 && dataset{i,7}<2
        dataset{i,7} = 54;
    elseif dataset{i,7}>2 && dataset{i,7}<2.2
        dataset{i,7} = 55;
    elseif dataset{i,7}>2.2 && dataset{i,7}<2.3
        dataset{i,7} = 56;
    elseif dataset{i,7}>2.3 && dataset{i,7}<2.5
        dataset{i,7} = 57;
    elseif dataset{i,7}>2.5 && dataset{i,7}<2.7
        dataset{i,7} = 58;
    elseif dataset{i,7}>2.7 && dataset{i,7}<2.9
        dataset{i,7} = 59;
    elseif dataset{i,7}>2.9
        dataset{i,7} = 60;
    else
        dataset{i,7}=NaN;
    end 
    
    % Extraversion
    if dataset{i,8}<-3.2
        dataset{i,8} = 16;
    elseif dataset{i,8}>-3.2 && dataset{i,8}<-3
        dataset{i,8} = 18;
    elseif dataset{i,8}>-3 && dataset{i,8}<-2.7
        dataset{i,8} = 19;
    elseif dataset{i,8}>-2.7 && dataset{i,8}<-2.5
        dataset{i,8} = 20;
    elseif dataset{i,8}>-2.5 && dataset{i,8}<-2.4
        dataset{i,8} = 21;
    elseif dataset{i,8}>-2.4 && dataset{i,8}<-2.3
        dataset{i,8} = 22;
    elseif dataset{i,8}>-2.3 && dataset{i,8}<-2.2
        dataset{i,8} = 23;
    elseif dataset{i,8}>-2.2 && dataset{i,8}<-2.1
        dataset{i,8} = 24;
    elseif dataset{i,8}>-2.1 && dataset{i,8}<-2
        dataset{i,8} = 25;
    elseif dataset{i,8}>-2 && dataset{i,8}<-1.9
        dataset{i,8} = 26;
    elseif dataset{i,8}>-1.9 && dataset{i,8}<-1.7
        dataset{i,8} = 27;
    elseif dataset{i,8}>-1.7 && dataset{i,8}<-1.6
        dataset{i,8} = 28;
    elseif dataset{i,8}>-1.6 && dataset{i,8}<-1.5
        dataset{i,8} = 29;
    elseif dataset{i,8}>-1.5 && dataset{i,8}<-1.3
        dataset{i,8} = 30;
    elseif dataset{i,8}>-1.3 && dataset{i,8}<-1.2
        dataset{i,8} = 31;        
    elseif dataset{i,8}>-1.2 && dataset{i,8}<-1
        dataset{i,8} = 32;  
    elseif dataset{i,8}>-1 && dataset{i,8}<-0.9
        dataset{i,8} = 33;  
    elseif dataset{i,8}>-0.9 && dataset{i,8}<-0.8
        dataset{i,8} = 34; 
    elseif dataset{i,8}>-0.8 && dataset{i,8}<-0.6
        dataset{i,8} = 35; 
    elseif dataset{i,8}>-0.6 && dataset{i,8}<-0.5
        dataset{i,8} = 36; 
    elseif dataset{i,8}>-0.5 && dataset{i,8}<-0.4
        dataset{i,8} = 37;
    elseif dataset{i,8}>-0.4 && dataset{i,8}<-0.3
        dataset{i,8} = 38;
    elseif dataset{i,8}>-0.3 && dataset{i,8}<-0.1
        dataset{i,8} = 39;
    elseif dataset{i,8}>-0.1 && dataset{i,8}<0.1
        dataset{i,8} = 40;
    elseif dataset{i,8}>0 && dataset{i,8}<0.1
        dataset{i,8} = 36;
    elseif dataset{i,8}>0.1 && dataset{i,8}<0.2
        dataset{i,8} = 41;
    elseif dataset{i,8}>0.2 && dataset{i,8}<0.4
        dataset{i,8} = 42;
    elseif dataset{i,8}>0.4 && dataset{i,8}<0.5
        dataset{i,8} = 43;
    elseif dataset{i,8}>0.5 && dataset{i,8}<0.7
        dataset{i,8} = 44;
    elseif dataset{i,8}>0.7 && dataset{i,8}<0.9
        dataset{i,8} = 45;
    elseif dataset{i,8}>0.9 && dataset{i,8}<1.1
        dataset{i,8} = 46;
    elseif dataset{i,8}>1.1 && dataset{i,8}<1.2
        dataset{i,8} = 47;
    elseif dataset{i,8}>1.2 && dataset{i,8}<1.3
        dataset{i,8} = 48;
    elseif dataset{i,8}>1.3 && dataset{i,8}<1.5
        dataset{i,8} = 49;
    elseif dataset{i,8}>1.5 && dataset{i,8}<1.6
        dataset{i,8} = 50;
    elseif dataset{i,8}>1.6 && dataset{i,8}<1.8
        dataset{i,8} = 51;
    elseif dataset{i,8}>1.8 && dataset{i,8}<2
        dataset{i,8} = 52;
    elseif dataset{i,8}>2 && dataset{i,8}<2.2
        dataset{i,8} = 53;
    elseif dataset{i,8}>2.2 && dataset{i,8}<2.4
        dataset{i,8} = 54;
    elseif dataset{i,8}>2.4 && dataset{i,8}<2.6
        dataset{i,8} = 55;
    elseif dataset{i,8}>2.6 && dataset{i,8}<2.9
        dataset{i,8} = 56;
    elseif dataset{i,8}>2.9 && dataset{i,8}<3.1
        dataset{i,8} = 58;
    elseif dataset{i,8}>3.1
        dataset{i,8} = 59;
    else
        dataset{i,8}=NaN;
    end
    
    % Opennes
    if dataset{i,9}<-3.2
        dataset{i,9} = 24;
    elseif dataset{i,9}>-3.2 && dataset{i,9}<-2.8
        dataset{i,9} = 26;
    elseif dataset{i,9}>-2.8 && dataset{i,9}<-2.6
        dataset{i,9} = 28;
    elseif dataset{i,9}>-2.6 && dataset{i,9}<-2.3
        dataset{i,9} = 29;
    elseif dataset{i,9}>-2.3 && dataset{i,9}<-2.2
        dataset{i,9} = 30;
    elseif dataset{i,9}>-2.2 && dataset{i,9}<-2
        dataset{i,9} = 31;
    elseif dataset{i,9}>-2 && dataset{i,9}<-1.9
        dataset{i,9} = 32;
    elseif dataset{i,9}>-1.9 && dataset{i,9}<-1.8
        dataset{i,9} = 33;
    elseif dataset{i,9}>-1.8 && dataset{i,9}<-1.6
        dataset{i,9} = 34;
    elseif dataset{i,9}>-1.6 && dataset{i,9}<-1.5
        dataset{i,9} = 35;
    elseif dataset{i,9}>-1.5 && dataset{i,9}<-1.4
        dataset{i,9} = 36;
    elseif dataset{i,9}>-1.4 && dataset{i,9}<-1.2
        dataset{i,9} = 37;
    elseif dataset{i,9}>-1.2 && dataset{i,9}<-1.1
        dataset{i,9} = 38;
    elseif dataset{i,9}>-1.1 && dataset{i,9}<-0.9
        dataset{i,9} = 39;
    elseif dataset{i,9}>-0.9 && dataset{i,9}<-0.8
        dataset{i,9} = 40;        
    elseif dataset{i,9}>-0.8 && dataset{i,9}<-0.7
        dataset{i,9} = 41;  
    elseif dataset{i,9}>-0.7 && dataset{i,9}<-0.5
        dataset{i,9} = 42;  
    elseif dataset{i,9}>-0.5 && dataset{i,9}<-0.4
        dataset{i,9} = 43; 
    elseif dataset{i,9}>-0.4 && dataset{i,9}<-0.3
        dataset{i,9} = 44; 
    elseif dataset{i,9}>-0.3 && dataset{i,9}<-0.1
        dataset{i,9} = 45; 
    elseif dataset{i,9}>-0.1 && dataset{i,9}<0
        dataset{i,9} = 46;
    elseif dataset{i,9}>0 && dataset{i,9}<0.2
        dataset{i,9} = 47;
    elseif dataset{i,9}>0.2 && dataset{i,9}<0.3
        dataset{i,9} = 48;
    elseif dataset{i,9}>0.3 && dataset{i,9}<0.5
        dataset{i,9} = 49;
    elseif dataset{i,9}>0.5 && dataset{i,9}<0.7
        dataset{i,9} = 50;
    elseif dataset{i,9}>0.7 && dataset{i,9}<0.8
        dataset{i,9} = 51;
    elseif dataset{i,9}>0.8 && dataset{i,9}<0.9
        dataset{i,9} = 52;
    elseif dataset{i,9}>0.9 && dataset{i,9}<1.1
        dataset{i,9} = 53;
    elseif dataset{i,9}>1.1 && dataset{i,9}<1.3
        dataset{i,9} = 54;
    elseif dataset{i,9}>1.3 && dataset{i,9}<1.5
        dataset{i,9} = 55;
    elseif dataset{i,9}>1.5 && dataset{i,9}<1.7
        dataset{i,9} = 56;
    elseif dataset{i,9}>1.7 && dataset{i,9}<1.9
        dataset{i,9} = 57;
    elseif dataset{i,9}>1.9 && dataset{i,9}<2.2
        dataset{i,9} = 58;
    elseif dataset{i,9}>2.2 && dataset{i,9}<2.5
        dataset{i,9} = 59;
    elseif dataset{i,9}>2.5
        dataset{i,9} = 60;
    else
        dataset{i,9}=NaN;
    end

    % Agreeableness
    if dataset{i,10}<-3.4
        dataset{i,10} = 12;
    elseif dataset{i,10}>-3.4 && dataset{i,10}<-3.1
        dataset{i,10} = 16;
    elseif dataset{i,10}>-3.1 && dataset{i,10}<-3
        dataset{i,10} = 18;
    elseif dataset{i,10}>-3 && dataset{i,10}<-2.9
        dataset{i,10} = 23;
    elseif dataset{i,10}>-2.9 && dataset{i,10}<-2.78
        dataset{i,10} = 24;
    elseif dataset{i,10}>-2.78 && dataset{i,10}<-2.6
        dataset{i,10} = 25;
    elseif dataset{i,10}>-2.6 && dataset{i,10}<-2.5
        dataset{i,10} = 26;
    elseif dataset{i,10}>-2.5 && dataset{i,10}<-2.3
        dataset{i,10} = 27;
    elseif dataset{i,10}>-2.3 && dataset{i,10}<-2.2
        dataset{i,10} = 28;
    elseif dataset{i,10}>-2.2 && dataset{i,10}<-2
        dataset{i,10} = 29;
    elseif dataset{i,10}>-2 && dataset{i,10}<-1.9
        dataset{i,10} = 30;
    elseif dataset{i,10}>-1.9 && dataset{i,10}<-1.7
        dataset{i,10} = 31;
    elseif dataset{i,10}>-1.7 && dataset{i,10}<-1.6
        dataset{i,10} = 32;
    elseif dataset{i,10}>-1.6 && dataset{i,10}<-1.4
        dataset{i,10} = 33;
    elseif dataset{i,10}>-1.4 && dataset{i,10}<-1.3
        dataset{i,10} = 34;
    elseif dataset{i,10}>-1.3 && dataset{i,10}<-1.2
        dataset{i,10} = 35;
    elseif dataset{i,10}>-1.2 && dataset{i,10}<-1
        dataset{i,10} = 36;
    elseif dataset{i,10}>-1 && dataset{i,10}<-0.9
        dataset{i,10} = 37;
    elseif dataset{i,10}>-0.9 && dataset{i,10}<-0.7
        dataset{i,10} = 38;
    elseif dataset{i,10}>-0.7 && dataset{i,10}<-0.6
        dataset{i,10} = 39;
    elseif dataset{i,10}>-0.6 && dataset{i,10}<-0.4
        dataset{i,10} = 40;
    elseif dataset{i,10}>-0.4 && dataset{i,10}<-0.3
        dataset{i,10} = 41;
    elseif dataset{i,10}>-0.3 && dataset{i,10}<-0.1
        dataset{i,10} = 42;
    elseif dataset{i,10}>-0.1 && dataset{i,10}<0
        dataset{i,10} = 43;
    elseif dataset{i,10}>0 && dataset{i,10}<0.2
        dataset{i,10} = 44;
    elseif dataset{i,10}>0.2 && dataset{i,10}<0.4
        dataset{i,10} = 45;
    elseif dataset{i,10}>0.4 && dataset{i,10}<0.5
        dataset{i,10} = 46;
    elseif dataset{i,10}>0.5 && dataset{i,10}<0.6
        dataset{i,10} = 47;
    elseif dataset{i,10}>0.6 && dataset{i,10}<0.8
        dataset{i,10} = 48;
    elseif dataset{i,10}>0.8 && dataset{i,10}<1.1
        dataset{i,10} = 49;
    elseif dataset{i,10}>1.1 && dataset{i,10}<1.2
        dataset{i,10} = 50;
    elseif dataset{i,10}>1.2 && dataset{i,10}<1.3
        dataset{i,10} = 51;
    elseif dataset{i,10}>1.3 && dataset{i,10}<1.5
        dataset{i,10} = 52;
    elseif dataset{i,10}>1.5 && dataset{i,10}<1.8
        dataset{i,10} = 53;
    elseif dataset{i,10}>1.8 && dataset{i,10}<2
        dataset{i,10} = 54;
    elseif dataset{i,10}>2 && dataset{i,10}<2.2
        dataset{i,10} = 55;
    elseif dataset{i,10}>2.2 && dataset{i,10}<2.4
        dataset{i,10} = 56;
    elseif dataset{i,10}>2.4 && dataset{i,10}<2.6
        dataset{i,10} = 57;
    elseif dataset{i,10}>2.6 && dataset{i,10}<2.8
        dataset{i,10} = 58;
    elseif dataset{i,10}>2.8 && dataset{i,10}<3.2
        dataset{i,10} = 59;
    elseif dataset{i,10}>3.2
        dataset{i,10} = 60;
    else
        dataset{i,10}=NaN;
    end
    
    % Conscientiousness
    if dataset{i,11}<-3.4
        dataset{i,11} = 17;
    elseif dataset{i,11}>-3.4 && dataset{i,11}<-3.1
        dataset{i,11} = 19;
    elseif dataset{i,11}>-3.1 && dataset{i,11}<-2.9
        dataset{i,11} = 20;
    elseif dataset{i,11}>-2.9 && dataset{i,11}<-2.7
        dataset{i,11} = 21;
    elseif dataset{i,11}>-2.7 && dataset{i,11}<-2.5
        dataset{i,11} = 22;
    elseif dataset{i,11}>-2.5 && dataset{i,11}<-2.4
        dataset{i,11} = 23;
    elseif dataset{i,11}>-2.4 && dataset{i,11}<-2.3
        dataset{i,11} = 24;
    elseif dataset{i,11}>-2.3 && dataset{i,11}<-2.1
        dataset{i,11} = 25;    
    elseif dataset{i,11}>-2.1 && dataset{i,11}<-2
        dataset{i,11} = 26;
    elseif dataset{i,11}>-2 && dataset{i,11}<-1.9
        dataset{i,11} = 27;
    elseif dataset{i,11}>-1.9 && dataset{i,11}<-1.7
        dataset{i,11} = 28;
    elseif dataset{i,11}>-1.7 && dataset{i,11}<-1.6
        dataset{i,11} = 29;
    elseif dataset{i,11}>-1.6 && dataset{i,11}<-1.5
        dataset{i,11} = 30;
    elseif dataset{i,11}>-1.5 && dataset{i,11}<-1.3
        dataset{i,11} = 31;
    elseif dataset{i,11}>-1.3 && dataset{i,11}<-1.2
        dataset{i,11} = 32;
    elseif dataset{i,11}>-1.2 && dataset{i,11}<-1.1
        dataset{i,11} = 33;
    elseif dataset{i,11}>-1.1 && dataset{i,11}<-1
        dataset{i,11} = 34;
    elseif dataset{i,11}>-1 && dataset{i,11}<-0.8
        dataset{i,11} = 35;
    elseif dataset{i,11}>-0.8 && dataset{i,11}<-0.7
        dataset{i,11} = 36;
    elseif dataset{i,11}>-0.7 && dataset{i,11}<-0.6
        dataset{i,11} = 37;
    elseif dataset{i,11}>-0.6 && dataset{i,11}<-0.5
        dataset{i,11} = 38;
    elseif dataset{i,11}>-0.5 && dataset{i,11}<-0.4
        dataset{i,11} = 39;
    elseif dataset{i,11}>-0.4 && dataset{i,11}<-0.2
        dataset{i,11} = 40;
    elseif dataset{i,11}>-0.2 && dataset{i,11}<-0.1
        dataset{i,11} = 41;
    elseif dataset{i,11}>-0.1 && dataset{i,11}<0
        dataset{i,11} = 42;
    elseif dataset{i,11}>0 && dataset{i,11}<0.2
        dataset{i,11} = 43;
    elseif dataset{i,11}>0.2 && dataset{i,11}<0.3
        dataset{i,11} = 44;
    elseif dataset{i,11}>0.3 && dataset{i,11}<0.5
        dataset{i,11} = 45;
    elseif dataset{i,11}>0.5 && dataset{i,11}<0.7
        dataset{i,11} = 46;
    elseif dataset{i,11}>0.7 && dataset{i,11}<0.8
        dataset{i,11} = 47;
    elseif dataset{i,11}>0.8 && dataset{i,11}<1
        dataset{i,11} = 48;
    elseif dataset{i,11}>1 && dataset{i,11}<1.2
        dataset{i,11} = 49;
    elseif dataset{i,11}>1.2 && dataset{i,11}<1.4
        dataset{i,11} = 50;
    elseif dataset{i,11}>1.4 && dataset{i,11}<1.5
        dataset{i,11} = 51;
    elseif dataset{i,11}>1.5 && dataset{i,11}<1.7
        dataset{i,11} = 52;
    elseif dataset{i,11}>1.7 && dataset{i,11}<1.9
        dataset{i,11} = 53;
    elseif dataset{i,11}>1.9 && dataset{i,11}<2.1
        dataset{i,11} = 54;
    elseif dataset{i,11}>2.1 && dataset{i,11}<2.4
        dataset{i,11} = 55;
    elseif dataset{i,11}>2.4 && dataset{i,11}<2.7
        dataset{i,11} = 56;
    elseif dataset{i,11}>2.7 && dataset{i,11}<3.1
        dataset{i,11} = 57;
    elseif dataset{i,11}>3.1
        dataset{i,11} = 59;
    else
        dataset{i,11}=NaN;
    end    

    % Impulsiveness
    if dataset{i,12}<-2.5
        dataset{i,12} = 0;
    elseif dataset{i,12}>-2.5 && dataset{i,12}<-1.3
        dataset{i,12} = 1;
    elseif dataset{i,12}>-1.3 && dataset{i,12}<-0.7
        dataset{i,12} = 2;
    elseif dataset{i,12}>-0.7 && dataset{i,12}<-0.2
        dataset{i,12} = 3;
    elseif dataset{i,12}>-0.2 && dataset{i,12}<0.2
        dataset{i,12} = 4;
    elseif dataset{i,12}>0.2 && dataset{i,12}<0.6
        dataset{i,12} = 5;
    elseif dataset{i,12}>0.6 && dataset{i,12}<0.9
        dataset{i,12} = 6;
    elseif dataset{i,12}>0.9 && dataset{i,12}<1.3
        dataset{i,12} = 7;
    elseif dataset{i,12}>1.3 && dataset{i,12}<1.9
        dataset{i,12} = 8;
    elseif dataset{i,12}>1.9
        dataset{i,12} = 9;
    else
        dataset{i,12} = NaN;
    end
    
    % Sensation seeking
    if dataset{i,13}<-2.1
        dataset{i,13} = 0;
    elseif dataset{i,13}>-2.1 && dataset{i,13}<-1.5
        dataset{i,13} = 1;
    elseif dataset{i,13}>-1.5 && dataset{i,13}<-1.1
        dataset{i,13} = 2;
    elseif dataset{i,13}>-1.1 && dataset{i,13}<-0.8
        dataset{i,13} = 3;
    elseif dataset{i,13}>-0.8 && dataset{i,13}<-0.5
        dataset{i,13} = 4;
    elseif dataset{i,13}>-0.5 && dataset{i,13}<-0.2
        dataset{i,13} = 5;
    elseif dataset{i,13}>-0.2 && dataset{i,13}<0.1
        dataset{i,13} = 6;
    elseif dataset{i,13}>0.1 && dataset{i,13}<0.5
        dataset{i,13} = 7;
    elseif dataset{i,13}>0.5 && dataset{i,13}<0.8
        dataset{i,13} = 8;
    elseif dataset{i,13}>0.8 && dataset{i,13}<1.3
        dataset{i,13} = 9;
    elseif dataset{i,13}>1.3
        dataset{i,13} = 10;
    else
        dataset{i,13} = NaN;
    end
end
disp("Data cleaned")
disp("Creating cleaned_drug_consumption.csv...")
writetable(dataset,"cleaned_drug_consumption.csv")
disp("cleaned_drug_consumption.csv created")