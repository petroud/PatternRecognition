function [X_norm, mu, sigma] = featureNormalize(X)
%FEATURENORMALIZE Normalizes the features in X 
%   FEATURENORMALIZE(X) returns a normalized version of X where
%   the mean value of each feature is 0 and the standard deviation
%   is 1. This is often a good preprocessing step to do when
%   working with learning algorithms.


mu = mean(X); % mean of each column (feature)
sigma = std(X); % standart deviation of each column
X_norm = X; % normalize each column independently

for i=1 : size(X,2) % For each X column
    % Calculating normalized value for each column using the formula
    % provided
    X_norm(:,i) = (X_norm(:,i)-mu(1,i)) ./ sigma(1,i);
end
% ============================================================

end
