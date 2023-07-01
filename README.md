# Metropolis-Hastings-type sampling of phylogenetic distributions

![image](https://github.com/maxbiostat/phylogenetic_MH/assets/2875083/83cf4f1a-f88a-49fc-b98a-b657c8aa5ebb)

![image](https://github.com/maxbiostat/phylogenetic_MH/assets/2875083/820c504d-7080-45ec-965b-b1387b2ce2bc)



This repository will hold code and data for a large-ish experiment on MH for phylogenetic trees for small numbers of taxa. For `n=4, 5, 6` and `7` taxa, we will run neighbourhood-ratio-based MH and a lazyfied version with various values of the lazy coefficient `rho`.

Needs
```r
remotes::install_github("maxbiostat/PhyloMarkovChains")
```
to work. 
