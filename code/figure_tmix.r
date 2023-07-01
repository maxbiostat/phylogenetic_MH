n <- 4

paste0(
  "../derived_data/transition_matrices/MH_matrix_n=", n, "_rho*"
)

MH.base <- read.csv(

)

K <- ncol(MH.base)

Eps <- 0.05 * 1/K

times <- lapply(LMHs, function(m){
  PhyloMarkovChains::t_mix_bounds(Tr_mat = m,
                                  varepislon = Eps,
                                  pi_min = 1/K)
})


times.df <- data.frame(
  cbind( rho = Rhos,
         do.call(rbind, times))
)


colnames(times.df) <- c("rho", "t_l", "t_u")

plot(t_u ~ rho, times.df, type = "b",
     ylim = c(0, max(times.df$t_u)), 
     xlab = expression(rho),
     ylab = "Mixing time")
lines(t_l ~ rho, times.df, type = "b", col = 2)