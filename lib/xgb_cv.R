xgb_cv <- function(dat_train, K = 5, par=NULL){
  
  source("../lib/xgb_train.R")
  source("../lib/xgb_test.R")
  
  n = nrow(dat_train)
  n.fold = floor(n/K)
  s = sample(rep(1:K, c(rep(n.fold, K-1), n-(K-1)*n.fold)))  
  cv.error = rep(NA, K)
  
  for (i in 1:K){
    
    train.data = dat_train[s != i,]
    test.label = as.numeric(dat_train[s == i,]$label)
    test.data = dat_train[s == i, 1:(length(dat_train)-1)]
    
    fit.model = xgb_train(train.data, par = par)[[1]]
    
    pred = xgb_test(fit.model, test.data)[[1]]
    
    cv.error[i] = mean(pred != test.label)
    
  }		
  
  return(list(error = mean(cv.error), sd = sd(cv.error), error_list = cv.error) )
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
}