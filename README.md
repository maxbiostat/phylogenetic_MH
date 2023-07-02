# Metropolis-Hastings-type sampling of phylogenetic distributions

![image](https://github.com/maxbiostat/phylogenetic_MH/assets/2875083/226d07b4-5ba7-4e9d-9fc6-8354ae3b234c)


![image](https://github.com/maxbiostat/phylogenetic_MH/assets/2875083/820c504d-7080-45ec-965b-b1387b2ce2bc)

---

This repository will hold code and data for a large-ish experiment on MH for phylogenetic trees for small numbers of taxa. For `n=4, 5, 6` and `7` taxa, we will run neighbourhood-ratio-based MH and a lazyfied version with various values of the lazy coefficient `rho`.

For each pair of `rho` and `n` we ran `J = 500` chains of `M = 10, 000` iterations. To compute the clade indicators we took out a burnin of `b = 1000` and used [this](https://github.com/maxbiostat/phylogenetic_MH/blob/main/code/get_clademaps.sh) script to process the resulting `.trees` files, which are not themselves present in this repository due to being too large. 

---
Needs
```r
remotes::install_github("maxbiostat/PhyloMarkovChains")
```
to work. 
For more on the workflow of the code, see the [README](https://github.com/maxbiostat/phylogenetic_MH/blob/main/code/README.md) in the code folder.
