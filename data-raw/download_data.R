# Download and unzip
data_permalink <- "https://stacks.stanford.edu/file/druid:gd922zq9141/Example%20Data.zip"
data_dest <- "data-raw/Example\ Data.zip"
download.file(data_permalink, data_dest)
unzip(data_dest, overwrite = TRUE, exdir = "data-raw")

# Create R objects
prh_mat <- R.matlab::readMat("data-raw/Example Data/mn160727-11 10Hzprh.mat")
# 10 Hz PRH
time <- as.POSIXct((prh_mat$DN - 719529) * 86400,
                   origin = "1970-01-01",
                   tz = "US/Pacific")
depth <- prh_mat$p
pitch <- prh_mat$pitch
roll <- prh_mat$roll
head <- prh_mat$head
Aw <- prh_mat$Aw
Mw <- prh_mat$Mw
Gw <- prh_mat$Gw
fs <- prh_mat$fs[[1]]
mn160727_11 <- data.frame(time, depth, pitch, roll, head)
mn160727_11$Aw <- Aw
mn160727_11$Mw <- Mw
mn160727_11$Gw <- Gw
attr(mn160727_11, "fs") <- fs
# 400 Hz raw acceleration
A_mat <- R.matlab::readMat("data-raw/Example Data/mn160727-11Adata.mat")
Afs <- A_mat$Afs[[1]]
Atime <- time[1] + (seq(nrow(A_mat$A)) - 1) / Afs
mn160727_11_A <- data.frame(time = Atime)
mn160727_11_A$A <- A_mat$A
attr(mn160727_11_A, "Afs") <- Afs

# Save objects
usethis::use_data(mn160727_11, mn160727_11_A)
