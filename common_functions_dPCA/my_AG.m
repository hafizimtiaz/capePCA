function [Ahat, E] = my_AG(A, N, epsilon, delta)
    D = (1 / (N * epsilon)) * sqrt(2 * log(1.25 / delta));
    m = length(A);
    temp = normrnd(0,D,m,m);
    temp2 = triu(temp);
    temp3 = temp2';
    temp4 = tril(temp3,-1);
    E = temp2+temp4;
    Ahat = A + E;
end