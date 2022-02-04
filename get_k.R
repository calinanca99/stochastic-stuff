# Setup
a = 1
b = 4
c = 9

# Store avg. k (numbers drawn until sum is higher than c) for each c
ks = rep(0, c)

reps = 1e2 # number of repetitions

for (i in 1:c) {
  k = 0
  
  for (j in 1:reps) {
    sum = 0
    count = 0
    
    while (sum <= i) {
      sum = sum + runif(1, a, b)
      count = count + 1
    }
    
    k = k + count 
  }
  
  ks[i] = k / reps # store average k for c = i
}

plot(1:c, ks)
