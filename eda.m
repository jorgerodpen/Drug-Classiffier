clear all; close all; clc

%% Importing the file
dataset = readtable("cleaned_drug_consumption.csv","VariableNamingRule","preserve");

%% Colormap
colormap = customcolormap([1,0.5,0],...
    {'#004f80','#ffffff','#710e20'},128);
colormap2 = customcolormap([1,0],...
    {'#004f80','#ffffff'},128);
%% Total correlation
c=corr(dataset{:,[2:55,57]});
labels=dataset.Properties.VariableNames;
labels=labels([2:55,57]);
figure(1)
h=heatmap(labels,labels,c,'Colormap',colormap);
h.ColorLimits=[-1,1];

%% Personal data and drug consumption (age and studies not grouped)
x = dataset(:,2:31);
y = dataset(:,[39:55,57]);
c=corr(x{:,:},y{:,:});
labelsx=x.Properties.VariableNames;
labelsy=y.Properties.VariableNames;
figure(2)
h=heatmap(labelsy,labelsx,c,'Colormap',colormap);
h.ColorLimits=[-1,1];

%% Personal data and drug consumption (age and studies grouped)
age = dataset(:,3:8);
for i = 2:length(3:8)
    start = age{:,i};
    age{:,i} = start*i;
end
age = array2table(sum(age{:,:},2),'VariableNames',{'Age'});
studies = dataset(:,9:17);
for i = 2:length(9:17)
    start = studies{:,i};
    studies{:,i} = start*i;
end
studies = array2table(sum(studies{:,:},2),'VariableNames',{'Studies'});
x = [dataset(:,2), age, studies, dataset(:,18:31)];
y = dataset(:,[39:55,57]);
c=corr(x{:,:},y{:,:});
labelsx=x.Properties.VariableNames;
labelsy=y.Properties.VariableNames;
figure(3)
h=heatmap(labelsy,labelsx,c,'Colormap',colormap);
h.ColorLimits=[-1,1];

%% Psychological tests score and drug consumption
x = dataset(:,32:38);
y = dataset(:,[39:55,57]);
c=corr(x{:,:},y{:,:});
labelsx=x.Properties.VariableNames;
labelsy=y.Properties.VariableNames;
figure(4)
h=heatmap(labelsy,labelsx,c,'Colormap',colormap);
h.ColorLimits=[-1,1];

%% Drug consumption relation
c=corr(dataset{:,[39:55,57]});
labels=dataset.Properties.VariableNames;
labels=labels([39:55,57]);
figure(5)
h=heatmap(labels,labels,c,'Colormap',colormap);
h.ColorLimits=[-1,1];

%% Number of drugs consumed (all drugs)
used = sum(dataset{:,[39:55,57]},2);
timesused = unique(used);
counts  = histc(used, timesused);
figure(6)
bar(timesused, counts, 'FaceColor','#004f80')
xlabel('Total number of drugs consumed')
ylabel('Number of users')

%% Number of drugs consumed (illegal drugs)
idxillegal = [40:42, 44, 46:55, 57];
used = sum(dataset{:,idxillegal},2);
timesused = unique(used);
counts  = histc(used, timesused);
figure(7)
bar(timesused, counts, 'FaceColor','#004f80')
xlabel('Total number of drugs consumed')
ylabel('Number of users')

%% Percentage of ussage of each drug
labels = dataset.Properties.VariableNames;
labels = categorical(labels([39:55,57]));
total = sum(dataset{:,[39:55,57]})/1885*100;
figure(8)
ax = axes;
bar(labels, total, 'FaceColor','#004f80')
ytickformat(ax, '%g%%');

%% Difference in mean score of each drug (with sample)
labels = dataset.Properties.VariableNames;

%Five Factor
colsd = [39:55,57];
colsp = 32:36;
labelsd = categorical(labels(colsd));
labelsp = categorical(labels(colsp));
meanval = zeros(length(labelsd), length(labelsp));
meanN = mean(dataset{:,32});
meanE = mean(dataset{:,33});
meanO = mean(dataset{:,34});
meanA = mean(dataset{:,35});
meanC = mean(dataset{:,36});
means = {meanN, meanE, meanO, meanA, meanC};
for i = 1:length(labelsd)
    for j = 1:length(labelsp)
        consumer = dataset{:,colsd(i)}==1;
        test = dataset{:,colsp(j)};
        meanval(i,j) = (mean(test(consumer))-means{j})/means{j}*100;
    end
end
figure(9)
h=heatmap(labelsp, labelsd, meanval,'Colormap',colormap);
h.ColorLimits=[-10,10];
%% Difference in mean score of each drug (with pop)
labels = dataset.Properties.VariableNames;
colsd = [39:55,57];
colsp = 32:36;
labelsd = categorical(labels(colsd));
labelsp = categorical(labels(colsp));
meanval = zeros(length(labelsd), length(labelsp));
means = {28.83, 31.29, 43.29, 44.41, 45.26};
for i = 1:length(labelsd)
    for j = 1:length(labelsp)
        consumer = dataset{:,colsd(i)}==1;
        test = dataset{:,colsp(j)};
        meanval(i,j) = (mean(test(consumer))-means{j})/means{j}*100;
    end
end
figure(10)
h=heatmap(labelsp, labelsd, meanval, 'Colormap',colormap);
h.ColorLimits=[-40,40];

%% Histograms of scores
% Gaussian
x= linspace(12,60,500);
gauss = @(mean, std) 1/(sqrt(2*pi*std^2))*exp(-(x-mean).^2/(2*std^2));

% Plots
h(1) = subplot(3,2,1); histogram(dataset{:,32},'FaceColor','#004f80','Normalization','probability')
hold on
plot(x, gauss(28.83, 7.36),'LineWidth',2,'Color','#990d21')
title('Neuroticism')
grid
xlim([12,60])
ylim([0,0.08])

h(2) = subplot(3,2,2); histogram(dataset{:,33},'FaceColor','#004f80','Normalization','probability')
hold on
plot(x, gauss(31.29, 6.46),'LineWidth',2,'Color','#990d21')
title('Extraversion')
grid
xlim([12,60])
ylim([0,0.08])

h(3) = subplot(3,2,3); histogram(dataset{:,34},'FaceColor','#004f80','Normalization','probability')
hold on
plot(x, gauss(43.29,6.12),'LineWidth',2,'Color','#990d21')
title('Openness')
grid
xlim([12,60])
ylim([0,0.08])

h(4) = subplot(3,2,4); histogram(dataset{:,35},'FaceColor','#004f80','Normalization','probability')
hold on
plot(x, gauss(44.41,5.42),'LineWidth',2,'Color','#990d21')
title('Agreeableness')
grid
xlim([12,60])
ylim([0,0.08])

h(5) = subplot(3,2,5); histogram(dataset{:,36},'FaceColor','#004f80',...
    'Normalization','probability','LineWidth',0.6)
hold on
plot(x, gauss(45.26,6.3),'LineWidth',2,'Color','#990d21')
title('Conscientiousness')
grid
xlim([12,60])
ylim([0,0.08])

pos = get(h,'Position');
new = mean(cellfun(@(v)v(1),pos(1:2)));
set(h(5),'Position',[new,pos{end}(2:end)])