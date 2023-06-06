% Generate random data points
rng(0); % Set random seed for reproducibility
numPoints = 1000;
data = [randn(numPoints, 2); randn(numPoints, 2) + 4];

% Perform k-means clustering
k = 2; % Number of clusters
opts = statset('Display','final');
[idx, centers] = kmeans(data, k, 'Options', opts);

% Plot the results
figure;
gscatter(data(:, 1), data(:, 2), idx, 'rg', '.', 12);
hold on;
plot(centers(:, 1), centers(:, 2), 'kx', 'MarkerSize', 15, 'LineWidth', 3);
legend('Cluster 1', 'Cluster 2', 'Centroids');
title('K-means Clustering');
hold off;
