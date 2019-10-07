data_permalink <- "https://stacks.stanford.edu/file/druid:gd922zq9141/Example%20Data.zip"
data_dest <- "data-raw/Example\ Data.zip"
download.file(data_permalink, data_dest)
unzip(data_dest, overwrite = TRUE)
