function A = myLDA(Samples, Labels, NewDim)
% Input:    
%   Samples: The Data Samples 
%   Labels: The labels that correspond to the Samples
%   NewDim: The New Dimension of the Feature Vector after applying LDA
    
	[NumSamples NumFeatures] = size(Samples);
    NumLabels = length(Labels);
    if(NumSamples ~= NumLabels) then
        fprintf('\nNumber of Samples are not the same with the Number of Labels.\n\n');
        exit
    end
    Classes = unique(Labels);
    NumClasses = length(Classes); %The number of classes
    
    Sw = zeros;
    P = zeros;
    m = zeros(NumClasses, NumFeatures);
    
    %For each class i
	%Find the necessary statistics
    for i = 1:NumClasses
        %Calculate the Class Prior Probability
        P(i) = sum(Labels==i-1) / NumSamples;
        
        %Calculate the Class Mean 
        mu(i,:) = mean(Samples(Labels==i-1,:));
        
        %Calculate the Within Class Scatter Matrix
        Sw= Sw + P(i) .* cov(Samples(Labels==i-1,:));
    end;
    
    %Calculate the Global Mean
    m0= sum(m)./NumClasses;
    
    %Calculate the Between Class Scatter Matrix
    % Total scatter of samples - Within Class Scatter Matrix
	Sb = cov(Samples) - Sw;
    
    %Eigen matrix EigMat=inv(Sw)*Sb
    EigMat = inv(Sw)*Sb;
    
    [V,D] = eig(EigMat);
    
       
  
    %Select the NewDim eigenvectors corresponding to the top NewDim
    %eigenvalues (Assuming they are NewDim<=NumClasses-1)
	%% You need to return the following variable correctly.
	A=zeros(NumFeatures,NewDim);  
    
    eigvalues = diag(D);
    %Sort the eigenvalues and keep a pivot of sorting order
    [eigv_sorted, piv] = sort(eigvalues, 1, 'descend');
    
    %Sort the eigenvectors based on the sorting of eigenvalues
    eigvectors = V(:,piv);
    
    % Return the LDA projection vectors to the top NewDim
    A = eigvectors(:,1:NewDim);
    
    
    
    
    
    
    
