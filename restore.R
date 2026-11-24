# Run once from the repository root: Rscript restore.R
if (!requireNamespace("renv", quietly=TRUE))
  install.packages("renv", repos="https://cloud.r-project.org")
dir.create("renv/library", recursive=TRUE, showWarnings=FALSE)
# Reuse an already installed package only when its version matches the lockfile.
lock <- renv::lockfile_read("renv.lock")
available <- installed.packages()
matching <- names(Filter(function(record) {
  any(available[,"Package"]==record$Package & available[,"Version"]==record$Version)
}, lock$Packages))
if (length(matching))
  renv::hydrate(packages=matching, sources=.libPaths(), library="renv/library", prompt=FALSE)
renv::restore(lockfile="renv.lock", library="renv/library", prompt=FALSE)
