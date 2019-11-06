function [U_dist, U_loc] = my_dPCA_hafiz_ver3 (X_sites, K, R, epsilon, delta)
    % function for computing singular vectors in distributed setting

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

    S = length(X_sites);                    % number of sites
    Ac = 0;
    
    for s = 1:S
        data = X_sites{s};
        [D, Ns] = size(data);               % Ns = number of samples in this site
        As = (1/Ns) * (data * data');
        Es = 0;
        
        % private case
        if epsilon ~= 0
            As = my_AG(As, Ns, epsilon, delta);
            
            % generate noise matrix
            sigma = (1 / (Ns * epsilon)) * sqrt(2 * log(1.25 / delta));
            temp = normrnd(0, sigma, D, D);
            temp2 = triu(temp);
            temp3 = temp2';
            temp4 = tril(temp3,-1);
            Es = temp2+temp4;
        end
        
        Ac = Ac + As - Es;
    end
    [Us, ~, ~] = svd(As);
    U_loc = Us(:, 1:min(K,R));
    
    % computation at the central site
    Ac = (1/S) * Ac;
    [U_dist, ~, ~] = svd(Ac);
    U_dist = U_dist(:, 1:K);
end

function Ahat = my_AG(A, N, epsilon, delta)
    D = (1 / (N * epsilon)) * sqrt(2 * log(1.25 / delta));
    m = length(A);
    temp = normrnd(0,D,m,m);
    temp2 = triu(temp);
    temp3 = temp2';
    temp4 = tril(temp3,-1);
    E = temp2+temp4;
    Ahat = A + E;
end
