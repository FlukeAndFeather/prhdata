context("test-prh")

test_that("prh size is correct", {
  expect_equal(nrow(prh), 312137)
  expect_equal(ncol(prh), 8)
})

# Custom expectation for vector domain
expect_between <- function(object, low, high) {
  # 1. Capture object and label
  act <- quasi_label(rlang::enquo(object), arg = "object")

  # 2. Call expect()
  browser()
  expect(
    all(act$val >= low & act$val <= high, na.rm = TRUE),
    sprintf("Some elements of %s fall outside [%.2f, %.2f]", act$lab, low, high)
  )

  # 3. Invisibly return the value
  invisible(act$val)
}

test_that("prh variables fall within domains", {
  expect_between(prh$depth, -5, 500)
  expect_between(prh$pitch, -pi / 2, pi / 2)
  expect_between(prh$roll, -pi, pi)
  expect_between(prh$head, -pi, pi)
  expect_between(prh$Aw, -5, 5)
  expect_between(prh$Mw, -75, 75)
  expect_between(prh$Gw, -10, 10)
})

test_that("sizes of prh and Araw align", {
  expect_equal(nrow(Araw) / 40, nrow(prh))
})

test_that("prh$time is between 10:50 and 19:40 local time (US/Pacific)", {
  expect_s3_class(prh$time, "POSIXct")
  expect_between(prh$time,
                 as.POSIXct("2016-07-27 10:50", tz = "US/Pacific"),
                 as.POSIXct("2016-07-28 19:40", tz = "US/Pacific"))
})

test_that("time lines up in both data frames", {
  expect_equal(prh$time[1], Araw$time[1])
  expect_equal(max(Araw$time) + 1 / attr(Araw, "Afs"),
               max(prh$time) + 1 / attr(prh, "fs"))
})
