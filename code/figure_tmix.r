n <- 4

fcmd <- paste0(
  "ls ../derived_data/transition_matrices/MH_matrix_n=", n, "_rho*.csv"
)

matfiles <- system(fcmd, intern = TRUE)

the.mats <- lapply(matfiles, read.csv)
Rhos <- unlist(
  lapply(strsplit(matfiles, "_rho="),
         function(x) as.numeric(gsub(".csv", "", x[2])))
)

K <- ncol(the.mats[[1]])

Eps <- 0.05 * 1/K

times <- lapply(the.mats, function(m){
  PhyloMarkovChains::t_mix_bounds(Tr_mat = m,
                                  varepislon = Eps,
                                  pi_min = 1/K)
})


times.df <- data.frame(
  cbind( rho = Rhos,
         do.call(rbind, times))
)
colnames(times.df) <- c("rho", "t_l", "t_u")

write.csv(times.df, 
          file = paste0("../derived_data/mixing_times_n=", n, ".csv"))

library(ggplot2)

tmix.df <- reshape2::melt(times.df,
                          id.vars = "rho",
                          variable.name = "bound")

mixplot <- ggplot(tmix.df,
       aes(x = rho, y = value, colour = bound)) +
  geom_point() +
  geom_line() +
  scale_x_continuous(expression(rho)) +
  scale_y_continuous("Mixing time",
                     expand = c(0, 0)) +
  ggtitle(paste0("n=", n)) +
  theme_bw(base_size = 16)


ggsave(
  plot = mixplot,
  filename = paste0("../figures/mixing_time_bounds_n=", n, ".pdf"),
  scale = 1,
  width = 297,
  height = 210,
  units = "mm",
  dpi = 300
)
