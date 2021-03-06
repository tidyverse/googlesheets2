# for development only
str1 <- function(x, ...) utils::str(x, ..., max.level = 1)

noNA <- Negate(anyNA)
allNA <- function(x) all(is.na(x))
notNA <- Negate(is.na)

isFALSE <- function(x) identical(x, FALSE)

is_string <- function(x) is.character(x) && length(x) == 1L

is_integerish <- function(x) {
  floor(x) == x
}

check_data_frame <- function(x, nm = deparse(substitute(x))) {
  if (!is.data.frame(x)) {
    gs4_abort(c(
      "{.arg {nm}} must be a {.cls data.frame}:",
      x = "{.arg {nm}} has class {.cls {class(x)}}."
    ))
  }
  x
}

check_string <- function(x, nm = deparse(substitute(x))) {
  check_character(x, nm = nm)
  check_length_one(x, nm = nm)
  x
}

maybe_string <- function(x, nm = deparse(substitute(x))) {
  if (is.null(x)) {
    x
  } else {
    check_string(x, nm = nm)
  }
}

check_length_one <- function(x, nm = deparse(substitute(x))) {
  if (length(x) != 1) {
    gs4_abort("{.arg {nm}} must have length 1, not length {length(x)}.")
  }
  x
}

check_has_length <- function(x, nm = deparse(substitute(x))) {
  if (length(x) < 1) {
    gs4_abort("{.arg {nm}} must have length greater than zero.")
  }
  x
}

check_character <- function(x, nm = deparse(substitute(x))) {
  if (!is.character(x)) {
    gs4_abort(c(
      "{.arg {nm}} must be {.cls character}:",
      x = "{.arg {nm}} has class {.cls {class(x)}}."
    ))
  }
  x
}

maybe_character <- function(x, nm = deparse(substitute(x))) {
  if (is.null(x)) {
    x
  } else {
    check_character(x, nm = nm)
  }
}

check_non_negative_integer <- function(i, nm = deparse(substitute(i))) {
  if (length(i) != 1 || !is.numeric(i) ||
      !is_integerish(i) || is.na(i) || i < 0) {
    gs4_abort(c(
      "{.arg {nm}} must be a positive integer:",
      x = "{.arg {nm}} has class {.cls {class(i)}}."
    ))
  }
  i
}

maybe_non_negative_integer <- function(i, nm = deparse(substitute(i))) {
  if (is.null(i)) {
    i
  } else {
    check_non_negative_integer(i, nm = nm)
  }
}

check_bool <- function(bool, nm = deparse(substitute(bool))) {
  if (!is_bool(bool)) {
    gs4_abort("{.arg {nm}} must be either {.code TRUE} or {.code FALSE}.")
  }
  bool
}

maybe_bool <- function(bool, nm = deparse(substitute(bool))) {
  if (is.null(bool)) {
    bool
  } else {
    check_bool(bool, nm = nm)
  }
}

vlookup <- function(this, data, key, value) {
  stopifnot(is_string(key), is_string(value))
  m <- match(this, data[[key]])
  data[[value]][m]
}

## avoid the name `trim_ws` because it's an argument of several functions in
## this package
ws_trim <- function(x) {
  sub("\\s*$", "", sub("^\\s*", "", x))
}

enforce_na <- function(x, na = "") {
  stopifnot(is.character(x), is.character(na))
  out <- x
  if (length(na) > 0) {
    out[x %in% na] <- NA_character_
  }
  if (!("" %in% na)) {
    out[is.na(x)] <- ""
  }
  out
}

groom_text <- function(x, na = "", trim_ws = TRUE) {
  if (isTRUE(trim_ws)) {
    x <- ws_trim(x)
  }
  enforce_na(x, na)
}
