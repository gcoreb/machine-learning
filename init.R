
webdir = Sys.getenv('R_WEB_DIR')
filename = paste(webdir, '/init.png', sep="")
png(filename)
plot(0,0)
#todo make the points random
x1 = runif(1,-1,1)
x2 = runif(1,-1,1)
y1 = runif(1,-1,1)
y2 = runif(1,-1,1)
points(x1,y1)
points(x2,y2)
m = (y2 - y1) / (x2 - x1)
b = y2 - m * x2
abline(b,m, col="purple")
xSet = runif(100,-1,1)
ySet = runif(100,-1,1)
zSet = c(1:100)
for (i in 1:100) {
  if (ySet[i] > (m * xSet[i] + b)) {
    points(xSet[i], ySet[i],col="green", pch = "+")
    zSet[i] = 1
  } else {
    points(xSet[i], ySet[i], col="red",pch = "-")
    zSet[i] = -1
  }
}
#weight vector
pt = 0
i = 0
count = 0
j = 0
w = c(0,0,0)

#signclassify is working as intended.
#takes in weight vector and x vector with format [1,x, y] and outputs sign.
pla.signClassify <- function(w,x) {
  z = 0
  for (i in 1:3) {
    z = z + w[i] * x[i]
  }
  s = sign(z)
  return(s)
}
# PLA
l = 0
count = 0
pla.train = function(time){
while (j < time) {
  wrongPoints = 0
  count = count + 1
  for (i in 1:100) {
    pt = c(1,xSet[i], ySet[i])
    sign = pla.signClassify(w, pt)
    if (zSet[i] != sign) {
      w = w + zSet[i] * pt
      wrongPoints = wrongPoints + 1
      m0 = -w[2] / w[3]
      b0 = -w[1]/w[3]
      abline(b0, m0, col="black")
      break
    }
  }
    j = j + 1
  

# given weight vector [1,x,y] equation w[0] + x*w[2] + y*w[3] = 0 
if (wrongPoints == 0) {
  m0 = -w[2] / w[3]
  b0 = -w[1]/w[3]
  abline(b0, m0, col="blue")
  print(count)
  j = time
} 
}
}

pla.train(1000)
garbage = dev.off()
