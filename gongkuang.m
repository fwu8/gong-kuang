% read csv file
data = csvread('data.csv');
data = [data(:,1),data(:,3),data(:,5)];
[row, col] = size(data);
label = zeros(row, 1);
for i = 1:row
    label(i) = floor((i-1)/50)+1;
end

% apply PCA to orginal data
[COEFF,SCORE,latent] = pca(data);
COEFF = COEFF(:,1:2);
data = data*COEFF;

figure; hold on;
h1 = plot(data(1:50,1),data(1:50,2),'ob');
h2 = plot(data(51:100,1),data(51:100,2),'og');
h3 = plot(data(101:150,1),data(101:150,2),'or');
h4 = plot(data(151:200,1),data(151:200,2),'+b');
h5 = plot(data(201:250,1),data(201:250,2),'+r');
title('5 class feature using PCA (reduce dimension from 6 to 2)')
xlabel('dimension 1');
ylabel('dimension 2');
legend([h1, h2, h3, h4, h5], 'class 1','class 2','class 3',...
    'class 4','class 5');

data = csvread('feat.csv');
figure; hold on;
h1 = plot(data(1:50,1),data(1:50,2),'ob');
h2 = plot(data(51:100,1),data(51:100,2),'og');
h3 = plot(data(101:150,1),data(101:150,2),'or');
h4 = plot(data(151:200,1),data(151:200,2),'+b');
h5 = plot(data(201:250,1),data(201:250,2),'+r');
title('5 class feature using Stacked AE (reduce dimension from 6 to 2)')
xlabel('dimension 1');
ylabel('dimension 2');
axis([0,1,0,1]);
legend([h1, h2, h3, h4, h5], 'class 1','class 2','class 3',...
    'class 4','class 5');