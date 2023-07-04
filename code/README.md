## Code

- [`construct_transition_matrices.r`](https://github.com/maxbiostat/phylogenetic_MH/blob/main/code/construct_transition_matrices.r)
  
Doing
```bash
Rscript construct_transition_matrices.r
```
should generate a bunch of `.csv` files. These are compressed into `tar.gz` using [this](https://github.com/maxbiostat/phylogenetic_MH/blob/main/derived_data/transition_matrices/compress_matrices.sh) script.


- [`run_chains.r`](https://github.com/maxbiostat/phylogenetic_MH/blob/main/code/run_chains.r)

  
Doing
```bash
Rscript run_chains.r
```
should generate `13 x 500 = 6500` NEXUS files (`.trees`). 

**WARNING**: this step is compute- and storage- intensive. Consider downloading the processed output files instead.
