# Generate a new price based on the previous price
#
# The new price can be up one-tick or down one-tick, each with equal probabilities
# ^ this can be changed by updating the threshold parameter
#
# The up or down movements can be adjusted as well
generate_price = function(old_price, 
                          up = 0.01, 
                          down = -0.01, 
                          threshold = 0.5
                          ) {
  rand = runif(1)
  
  if (rand <= threshold) {
    old_price * (1 + up)
  } else {
    old_price * (1 + down)
  }
}

# n - number of simulations for one path
# m - number of simulated paths
n = 1000
m = 100

prices = matrix(0, nrow = n, ncol = m)

# Set the starting price
prices[1, ] = 100

for (row_index in 2:n) {
  for (col_index in 1:m) {
    prices[row_index, col_index] = generate_price(prices[row_index - 1, col_index])
  }
}

# Time axis
time = 1:n

# Making sure that all the value can be seen in the graph
tol = 0.05
max_val = max(prices) * (1 + tol)
min_val = min(prices) * (1 - tol)

plot(time, prices[, 1], xlab = "Time (in days)", ylab = "Price", type = "l", col = 1, lty = 1, ylim = c(min_val, max_val))

for (col_index in 2:m) {
  temp_price = prices[, col_index]
  lines(time, temp_price, type = "l", col = col_index)  
}