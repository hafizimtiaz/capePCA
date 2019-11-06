Distributed Differentially-private PCA (capePCA)
=====================================
This repository includes MATLAB/Python implementation of the capePCA algorithm that can achieve the same utility as the pooled-data scenario in an honest-but-curious model. Please see the original paper: https://ieeexplore.ieee.org/document/8509100 

* capePCA.py -- the file contains a simple example with implementation of capePCA algorithm. It generates some synthetic data and performs the capePCA. It also computes the PCA subspaces using conventional distributed differentially-private scheme. Then it generates a plot of captured energy in the produced PCA subspace for different $$\epsilon$$ values.
* common_functions_dPCA -- MATLAB functions needed for the simulations
* datasets -- synthetic and real datasets used for the simulations 
* plots -- codes for generating plots from saved results
* vs delta -- codes for variation of performance with $$\delta$$
* vs epsilon -- codes for variation of performance with $$\epsilon$$
* vs samples -- codes for variation of performance with number of samples

Feedback
--------

Please send bug reports, comments, or questions to [Hafiz Imtiaz](mailto:hafiz.imtiaz@outlook.com).
Contributions and extentions with new algorithms are welcome.
