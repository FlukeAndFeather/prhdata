#' Pitch-roll-heading data.
#'
#' Example PRH data from Cade et al. 2018 JEB, downsampled to 10 Hz.
#'
#' @format A data frame with 8 variables: \code{time}, \code{depth},
#' \code{pitch}, \code{roll}, \code{head}, \code{Aw}, \code{Mw}, and \code{Gw}.
#' \code{Aw}, \code{Mw}, and \code{Gw} are matrix columns, with three-axis
#' acceleration, magnetometer, and gyroscope data, respectively, rotated into
#' the whale's frame of reference. Includes an attribute: \code{fs},
#' the downsampled sampling frequency (10 Hz).
"prh"

#' Raw acceleration
#'
#' Raw acceleration data from Cade et al. 2018 JEB, collected at 400 Hz.
#'
#' @format A data frame matrix with two columns: \code{time} and \code{A}.
#' \code{A} is a 3-column matrix corresponding to raw acceleration values in the
#' x-, y-, and z-axes. Includes an attribute: \code{Afs}, the raw sampling
#' frequency (400 Hz).
"Araw"
