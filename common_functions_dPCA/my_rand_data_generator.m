function samples = my_rand_data_generator(X_mean,sigma,nsamples)

% X_mean = required mean of the data samples
% sigma = required covariance matrix of data samples
% nsamples = number of samples required
X_mean = X_mean(:);
m = length(sigma);
samples = chol(sigma)*randn(m,nsamples) + repmat(X_mean,1,nsamples);