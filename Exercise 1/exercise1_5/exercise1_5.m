close all;
clear;
clc;

data_file = './data/mnist.mat';

data = load(data_file);

% 
% Read the train data  and reshape the images as 2 dimensional 28-by-28 pixel arrays
[train_C1_indices, train_C2_indices,train_C1_images,train_C2_images] = read_data(data.trainX,data.trainY.');
% Read the test data  and reshape the images as 2 dimensional 28-by-28 pixel arrays
[test_C1_indices, test_C2_indices,test_C1_images,test_C2_images] = read_data(data.testX,data.testY.');


% Plot two images of digits 
figure();
subplot(1,2,1);
image1 = squeeze(train_C1_images(431,:,:));
plotImage(image1);
image2 = squeeze(train_C2_images(87,:,:));
subplot(1,2,2);
plotImage(image2);

% Compute Aspect Ratio
% We will use the train data to calculate the aspect ratio

arC1= zeros;
arC2= zeros;
% Calculate tha aspect ratios of C1 images (TRAIN)
for i=1:size(train_C1_images)
    resi = computeAspectRatio(squeeze(train_C1_images(i,:,:)));
    arC1(i) = resi(1);
end 

% Calculate the aspect ratios of C2 images (TRAIN)
for j=1:size(train_C2_images)
    resj = computeAspectRatio(squeeze(train_C2_images(j,:,:)));
    arC2(j) = resj(1);
end

% Select the min and max from the two sets of aspect ratios 
minAspectRatio = min(min(arC1),min(arC2));
maxAspectRatio= max(max(arC1),max(arC2));

fprintf('The minimun aspect ratio found in the dataset = %0.3f\n',minAspectRatio);
fprintf('The maximum aspect ratio found in the dataset = %0.3f\n',maxAspectRatio);


% Prior Probabilities
PC1 = size(train_C1_images) / (size(train_C1_images)+size(train_C2_images));
PC2 = size(train_C2_images) / (size(train_C1_images)+size(train_C2_images));

fprintf('The prior P(C1) probability = %0.2f\n',PC1);
fprintf('The prior P(C2) probability = %0.2f\n\n',PC2);


% Mean of the aspect ratios by class
m1 = mean(arC1);
m2 = mean(arC2);


% Standard deviation of the aspect ratios by class
sigma1 = sqrt( mean((arC1 - m1).^2));
sigma2 = sqrt( mean((arC2 - m2).^2));

%Calculation of the bound probabilities P(X_i | C1) & P(X_i | C2)

    arC1_tst= zeros;
    arC2_tst= zeros;

    % Calculate tha aspect ratios of C1 images (TEST)
    for z=1:size(test_C1_images)
        resz = computeAspectRatio(squeeze(test_C1_images(z,:,:)));
        arC1_tst(z) = resz(1);
    end 

    % Calculate the aspect ratios of C2 images (TEST)
    for w=1:size(test_C2_images)
        resw = computeAspectRatio(squeeze(test_C2_images(w,:,:)));
        arC2_tst(w) = resw(1);
    end

    test_aratio = [arC1_tst arC2_tst];
    % Likelihoods
    PgivenC1 = normpdf(test_aratio, m1, sigma1);
    PgivenC2 = normpdf(test_aratio, m2, sigma2);
    
    % Posterior Probabilities
    PC1givenL = PC1 * PgivenC1;
    PC2givenL = PC2 * PgivenC2;
    

% Bayes Classificator
testSample = cat(1,test_C1_images, test_C2_images);

for i = 1: size(testSample,1)
   if PC1givenL(i) >= PC2givenL(i)
       BayesClass(i) = 1;
   else
       BayesClass(i) = 2;
   end;
end;

count_errors_c1 = sum(BayesClass(1:size(test_C1_images,1))==2);
count_errors_c2 = sum(BayesClass(size(test_C1_images)+1:end)==1);
count_errors = count_errors_c1 + count_errors_c2;

Error = 100 * (count_errors/size(testSample,1));


fprintf('The classification error is : %.2f\n', Error);

    
