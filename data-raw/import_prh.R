# README
# Example data is too large to live on GitHub, so you'll have to download it.
# See download_data.R. The raw data is a .mat file. After downloading it,
# export it to .nc using export_prh.m (requires Matlab).

# Import ncdf file
nc_path <- "data-raw/mn160727-11 10Hzprh.nc"
if (!file.exists(nc_path)) {
  stop("Exported PRH (.nc file) not found. Have you run download_data.R and export_prh.m?")
}
if (!requireNamespace("RNetCDF", quietly = TRUE)) {
  stop("Package `RNetCDF` required to import data.")
}
prh_list <- RNetCDF::read.nc(RNetCDF::open.nc(nc_path))

# Convert times to POSIXct
dn_to_posix <- function(dn, tz = "UTC") {
  dn <- as.vector(unlist(dn))
  as.POSIXct((dn - 719529) * 86400,
             origin = as.POSIXct("1970-01-01", tz = tz),
             tz = tz)
}
prh_list$time <- dn_to_posix(prh_list$time, tz = "US/Pacific")

# Collapse scalars
prh_list$fs <- prh_list$fs[[1]]
prh_list$Afs <- prh_list$Afs[[1]]

# Convert 1d arrays to vectors
array_to_vec <- function(a) {
  as.vector(unlist(a))
}
oned_arr <- names(prh_list)[sapply(prh_list, function(x) length(dim(x)) == 1)]
for (e in oned_arr) {
  prh_list[[e]] <- array_to_vec(prh_list[e])
}

# Create PRH data frame with fs attribute
prh <- as.data.frame(prh_list[c("time", "depth", "pitch", "roll", "head")])
prh$Aw <- prh_list$Aw
prh$Mw <- prh_list$Mw
prh$Gw <- prh_list$Gw
attr(prh, "fs") <- prh_list$fs

# Create raw acceleration matrix with Afs attribute
Araw <- prh_list$A
attr(Araw, "Afs") <- prh_list$Afs

usethis::use_data(prh, Araw, overwrite = TRUE)
