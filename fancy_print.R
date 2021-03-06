print_obscure <- function (x, digits = getOption("digits"), prefix = "\t", ...) 
{
  cat("\n")
  cat(strwrap(x$method, prefix = prefix), sep = "\n")
  cat("\n")
  cat("data:  ", x$data.name, "\n", sep = "")
  out <- character()
  if (!is.null(x$statistic)) {
    if(!is.numeric(x$statistic)) {
      out <- c(out, paste(names(x$statistic), "=", x$statistic))
    } else {
          out <- c(out, paste(names(x$statistic), "=", format(signif(x$statistic, 
                                                               max(1L, digits - 2L)))))
    }
  }
  if (!is.null(x$parameter)) {
    if(!is.numeric(x$parameter)) {
      out <- c(out, paste(names(x$parameter), "=", x$parameter))
    } else {
    out <- c(out, paste(names(x$parameter), "=", format(signif(x$parameter, 
                                                               max(1L, digits - 2L)))))
    }
  }
  if (!is.null(x$p.value)) {
    if(!is.numeric(x$p.value)) {
      out <- c(out, paste("p-value", "=", x$p.value)) 
    } else {
      fp <- format.pval(x$p.value, digits = max(1L, digits - 
                                                3L))
      out <- c(out, paste("p-value", if (substr(fp, 1L, 1L) == 
                                       "<") fp else paste("=", fp)))
    }
  }
  cat(strwrap(paste(out, collapse = ", ")), sep = "\n")
  if (!is.null(x$alternative)) {
    cat("alternative hypothesis: ")
    if (!is.null(x$null.value)) {
      if (length(x$null.value) == 1L) {
        alt.char <- switch(x$alternative, two.sided = "not equal to", 
                           less = "less than", greater = "greater than")
        cat("true ", names(x$null.value), " is ", alt.char, 
            " ", x$null.value, "\n", sep = "")
      }
      else {
        cat(x$alternative, "\nnull values:\n", sep = "")
        print(x$null.value, digits = digits, ...)
      }
    }
    else cat(x$alternative, "\n", sep = "")
  }
  if (!is.null(x$conf.int)) {
    cat(format(100 * attr(x$conf.int, "conf.level")), " percent confidence interval:\n", 
        " ", paste(format(c(x$conf.int[1L], x$conf.int[2L])), 
                   collapse = " "), "\n", sep = "")
  }
  if (!is.null(x$estimate)) {
    cat("sample estimates:\n")
    print(x$estimate, digits = digits, ...)
  }
  cat("\n")
  invisible(x)
}