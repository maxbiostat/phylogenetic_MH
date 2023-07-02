n <- 4

outFolder <- paste0("../derived_data/chains_n=", n)
dir.create(outFolder)

M <- 1E4
Nrep <- 500
Ncores <- 100

TheTrees <- phangorn::allTrees(n = n, rooted = TRUE)
K <- length(TheTrees)
States <- paste0("tree_", 1:K)

###########
fcmd <-
  paste0("ls ../derived_data/transition_matrices/MH_matrix_n=",
         n,
         "_rho*.csv")

matfiles <- system(fcmd, intern = TRUE)

the.mats <- lapply(matfiles, read.csv)

Rhos <- unlist(lapply(strsplit(matfiles, "_rho="),
                      function(x)
                        as.numeric(gsub(".csv", "", x[2]))))

###########
run_multiple_chains <- function(nit,
                                nchains,
                                transition_matrix,
                                ncores) {
  Chains <- parallel::mclapply(1:nchains,
                               function(i) {
                                 PhyloMarkovChains::run_one_MC(Niter = nit,
                                                               MH_mat = transition_matrix)
                               },
                               mc.cores = ncores)
  return(Chains)
}

run4Rho <- function(rho) {
  rhoIndex <- match(rho, Rhos)
  mm <- the.mats[[rhoIndex]]
  K <- nrow(mm)
  tmat <- as.matrix(mm)
  colnames(tmat) <- rownames(tmat) <- paste0("tree_", 1:K)
  
  out <- run_multiple_chains(nchains = Nrep,
                             nit = M,
                             transition_matrix = tmat,
                             ncores = Ncores)
  
  save(out, 
       file = paste0(outFolder, "/",
                     "tree_indices_n=", n,
                     "_rho=", rho,
                     "_Niter=", M,
                     ".RData"))
  
  parallel::mclapply(1:Nrep,
                     function(k){
                       tfname <- paste0(outFolder, "/",
                                        "trees_n=", n,
                                        "_rho=", rho,
                                        "_Niter=", M,
                                        "_replicate=", k,
                                        ".trees")
                       inds <- match(out[[k]], States)
                       ape::write.nexus(TheTrees[inds],
                                        file = tfname)
                     },
                     mc.cores = Ncores)
  
}

sapply(Rhos, run4Rho)