# Demo File for R Scripts and Debugging

fibvec <- function(n){
  fibvec <- vector(mode = "double", length = n)
  for (i in seq_along(fibvec)) {
    if (i > 2) {
      fibvec[[i]] <- fibvec[[i - 1]] + fibvec[[i - 2]]
    } else if (i == 1) {
      fibvec[[i]] <- 0
    } else if (i == 2) {
      fibvec[[i]] <- 1
    }
  }
  return(fibvec)
} #end Function

fibnos <- function(nvec){
  fibnos <- rep(NA, length(nvec))
  for (i in seq(1:length(fibnos))){
    fibnos[[i]] <- fibvec(nvec[[i]])[nvec[i]]
  }
  return(fibnos)
}