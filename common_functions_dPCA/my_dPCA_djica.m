function [U_dist, U_loc] = my_dPCA_djica (X_sites, K, R, epsilon, delta)
    % function for computing singular vectors in distributed setting according
    % to djICA paper

    % U_dist = right singular subspace estimated from distributed data
    % U_loc = right singular subspace estimated from one site's data
    % X_sites = cell structure of data. each site has one cell. each cell has data samples in columns
    % K = target dimension
    % R = intermediate dimension
    % epsilon, delta = privacy parameters; epsilon = 0 triggers non-priv computation
    
    if nargin < 3
        epsilon = 0;
        R = 2*K;
    end
    Km = min(K,R);
    S = length(X_sites);         % number of sites
    sites = randperm(S);
    P = cell(S);
    [P{1}, U_loc] = my_local_pca(X_sites{sites(1)}, min(R, rank(X_sites{sites(1)})), epsilon, delta);
    for j = 2:S
        id = sites(j);
        kp = min(R, rank(X_sites{id}));
        [Pp, ~] = my_local_pca(X_sites{id}, kp, epsilon, delta);
        kp = max(kp, rank(P{j-1}));
        [P{j}, ~] = my_local_pca([Pp P{j-1}], kp);
    end
    rp = min(Km, rank(P{S}));
    U = P{S};
    U_dist = normc(U(:, 1:rp));
    U_loc = U_loc(:, 1:Km);
end

function [P_site, U_red] = my_local_pca(data, k, epsilon, delta)
    if nargin < 3
        epsilon = 0;
    end
    
    A = data * data';
    if epsilon ~= 0
        sigma = (1 / epsilon) * sqrt(2 * log(1.25 / delta));
        m = length(A);
        temp = normrnd(0, sigma, m, m);
        temp2 = triu(temp);
        temp3 = temp2';
        temp4 = tril(temp3, -1);
        E = temp2 + temp4;
        A = A + E;
    end

    [U, S, ~] = svd(A);
    S_red = S(1:k, 1:k);
    U_red = U(:, 1:k);
    P_site = U_red * sqrt(S_red);
end