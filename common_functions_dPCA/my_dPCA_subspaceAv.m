function U_dist = my_dPCA_subspaceAv (X_sites, K, R, epsilon, delta)

    % U_dist = top-r eigenvectors of the sample covariance matrix as if the
    % data were centralized

    % X_sites = structure that contains the samples in each cell. samples are 
    % d x n_i dimensional at site i. 

    % r = target dimension

    % function for computing singular vectors in distributed setting according
    % to djICA paper

    % U_dist = right singular subspace estimated from distributed data
    % X_sites = cell structure of data. each site has one cell. each cell has data samples in columns
    % K = target dimension
    % R = intermediate dimension
    % epsilon, delta = privacy parameters; epsilon = 0 triggers non-priv computation
    
    if nargin < 3
        epsilon = 0;
        R = 2*K;
    end

    nsites = length(X_sites);
    U_curr_av = 0;
    for site_id = 1:nsites
        data = X_sites{site_id};
        U_site = myLocalPCA(data, R, epsilon/nsites, delta/nsites);
        if U_curr_av ~= 0
            U_curr_av = my_subspaceAV(U_site, U_curr_av);
        else
            U_curr_av = U_site;
        end
    end
    U_dist = U_curr_av(:, 1:K);
end

function [U_site, S_site] = myLocalPCA(data, k, epsilon, delta)
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
    S_site = sqrt(S(1:k, 1:k));
    U_site = U(:, 1:k);
end

function U_av = my_subspaceAV(X,Y, maxIter)
    % this function tries to find U, V and Z such that X'*Z = U*S*V', where X
    % is a given orthogonal matrix and S is a given diagonal matrix. We can
    % minimize \|X'*Z - U*S*V'\|_F subject to Z'*Z = eye(k), but the problem is
    % not convex in three variables. So, we propose to solve it alternatingly.
    % X, Y and Z are d x k; U, S and V are k x k matrices.

    % X - subspace 1
    % Y - subspace 2
    % maxIter - maximum number of iteration allowed
    % U_av - average subspace of X and Y
    if nargin < 3
        maxIter = 512;
    end

    [d,k] = size(X);
    [U,S,V] = svd(X'*Y);
    temp = diag(S);
    ang = acos(temp);
    target_ang = ang/2;
    sigma = diag(target_ang);
    J = 1;

    while J <= maxIter
        % updating Z
        A = X';
        B = U*sigma*V';
        cvx_begin
            variables Z(d,k)
            minimize (norm(A*Z - B,'fro'))
            subject to
                norm(Z' - inv(Z)) <= 1e-5;
        cvx_end

        % updating U
        A = sigma*V';
        B = X'*Z;
        cvx_begin
            variables U(k,k)
            minimize (norm(U*A - B,'fro'))
            subject to
                norm(U'*U - eye(k)) <= 1e-5;
        cvx_end

        % updating V
        A = sigma*U';
        B = Z'*X;
        cvx_begin
            variables V(k,k)
            minimize (norm(V*A - B,'fro'))
            subject to
                norm(V'*V - eye(k)) <= 1e-5;
        cvx_end

        J = J+1;
    end
    U_av = Z;   
end