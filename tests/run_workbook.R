# Teacher check: run every R and TERMINAL block of the published workbook, in page order,
# in this RStudio session on ERDA. Usage (R console):
#   source("https://raw.githubusercontent.com/mutwil/bioinformatik-module4-transcriptomics/main/tests/run_workbook.R")
# Log: ~/work/module4_test_log.txt. Uses a made-up GRN.txt for the mini-project and
# deletes the downloaded reads at the end, as the workbook tells students to.
local({
  url <- "https://raw.githubusercontent.com/mutwil/bioinformatik-module4-transcriptomics/main/index.qmd"
  txt <- paste(readLines(url, warn = FALSE, encoding = "UTF-8"), collapse = "\n")
  blocks <- gregexpr("(?s)```(r|bash)\\n(.*?)```", txt, perl = TRUE)[[1]]
  heads  <- gregexpr("(?m)^#{1,2} [^\\n]*", txt, perl = TRUE)[[1]]
  head_txt <- regmatches(txt, list(heads))[[1]]
  log_file <- path.expand("~/work/module4_test_log.txt")
  say <- function(...) { line <- paste0(...); message(line); cat(line, "\n", file = log_file, append = TRUE) }
  cat("", file = log_file)
  say("Workbook test started ", format(Sys.time()), " on ", Sys.info()[["nodename"]], " — ", R.version.string)
  fails <- 0
  for (i in seq_along(blocks)) {
    start <- blocks[i]; len <- attr(blocks, "match.length")[i]
    block <- substr(txt, start, start + len - 1)
    lang  <- sub("(?s)^```(r|bash)\\n.*", "\\1", block, perl = TRUE)
    code  <- sub("(?s)^```(?:r|bash)\\n(.*?)```$", "\\1", block, perl = TRUE)
    where <- substr(tail(head_txt[heads < start], 1), 1, 60)
    if (lang == "r" && grepl("to_node <- function", code, fixed = TRUE))
      writeLines(c("TF\ttarget\trelationship", "AT1G32770_SND1\tAT5G17420_CESA7\tactivation",
                   "AT4G28500 (SND2)\tAT5G44030_CESA4\tactivation", "MYB46\tAT4G18780_CESA8\tactivation"),
                 path.expand("~/work/module4/GRN.txt"))
    t0 <- Sys.time()
    if (lang == "bash") {
      f <- tempfile(fileext = ".sh"); writeLines(code, f)
      out <- suppressWarnings(system2("bash", f, stdout = TRUE, stderr = TRUE))
      status <- attr(out, "status"); ok <- is.null(status) || status == 0
      # kallisto without arguments prints its usage and exits with 1 on purpose
      if (!ok && grepl("^cd ~/work/module4\n\\./bin/kallisto\n?$", code)) ok <- TRUE
      detail <- tail(out, 3)
    } else {
      res <- tryCatch({ source(exprs = parse(text = code), local = globalenv(),
                               print.eval = TRUE, echo = FALSE); "ok" },
                      error = function(e) paste("ERROR:", conditionMessage(e)))
      ok <- identical(res, "ok"); detail <- res
    }
    secs <- round(as.numeric(difftime(Sys.time(), t0, units = "secs")))
    say(sprintf("%s %2d/%d [%-4s %4ds] %s", if (ok) "OK  " else "FAIL", i, length(blocks), lang, secs, where))
    if (!ok) { fails <- fails + 1; say("     ", paste(detail, collapse = "\n      ")) }
  }
  unlink(path.expand("~/work/module4/reads"), recursive = TRUE)
  unlink(path.expand("~/work/module4/GRN.txt"))
  say("Workbook test finished ", format(Sys.time()), " — FAILS: ", fails, " of ", length(blocks), " blocks")
})
