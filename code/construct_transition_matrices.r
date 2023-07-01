library(PhyloMarkovChains)

export_transition_matrices <- function(n,
                                       Rhos = c(.01, .025, .05, 1:9 / 10)) {
  load(paste0("../data/SPR_matrix_n=", n, ".RData"))
  MH.base <- PhyloMarkovChains::make_MH_matrix(SPR.mat)
  write.csv(
    MH.base,
    paste0(
      "../derived_data/transition_matrices/MH_matrix_n=",
      n,
      "_rho=",
      0,
      ".RData"
    ),
    row.names = FALSE
  )
  LMHs <- parallel::mclapply(Rhos, function(r) {
    PhyloMarkovChains::make_lazy_MH_matrix(MHMat = MH.base,
                                           rho = r)
  }, mc.cores = 10)
  for (i in seq_along(Rhos)) {
    write.csv(
      LMHs[[i]],
      paste0(
        "../derived_data/transition_matrices/MH_matrix_n=",
        n,
        "_rho=",
        Rhos[i],
        ".csv"
      ),
      row.names = FALSE
    )
  }
}

Ns <- c(4, 5, 6, 7)
sapply(Ns, export_transition_matrices)