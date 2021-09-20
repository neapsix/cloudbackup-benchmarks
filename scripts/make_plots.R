library(ggplot2)
library(gdata)
library(dplyr)

# *** (1 of 4) Edits to select netstat or vmstat start here.

# *** Select one of the following blocks of file names, depending on
# whether you're plotting netstat output or vmstat output.

df_duplicity_0_netstat <- read.csv("duplicity-tests_0-initial_netstat.csv")
df_restic_0_netstat <- read.csv("restic-tests_0-initial_netstat.csv")
df_rclone_0_netstat <- read.csv("rclone-test_0-initial_netstat.csv")
df_b2sync_0_netstat <- read.csv("b2-sync-tests_0-initial_netstat.csv")

df_duplicity_1_netstat <- read.csv("duplicity-tests_1-add_files_netstat.csv")
df_restic_1_netstat <- read.csv("restic-tests_1-add_files_netstat.csv")
df_rclone_1_netstat <- read.csv("rclone-test_1-add_files_netstat.csv")
df_b2sync_1_netstat <- read.csv("b2-sync-tests_1-add_files_netstat.csv")

df_duplicity_2_netstat <- read.csv("duplicity-tests_2-modify_files_netstat.csv")
df_restic_2_netstat <- read.csv("restic-tests_2-modify_files_netstat.csv")
df_rclone_2_netstat <- read.csv("rclone-test_2-modify_files_netstat.csv")
df_b2sync_2_netstat <- read.csv("b2-sync-tests_2-modify_files_netstat.csv")

df_duplicity_3_netstat <- read.csv("duplicity-tests_3-touch_files_netstat.csv")
df_restic_3_netstat <- read.csv("restic-tests_3-touch_files_netstat.csv")
df_rclone_3_netstat <- read.csv("rclone-test_3-touch_files_netstat.csv")
df_b2sync_3_netstat <- read.csv("b2-sync-tests_3-touch_files_netstat.csv")

df_duplicity_4_netstat <- read.csv("duplicity-tests_4-remove_files_netstat.csv")
df_restic_4_netstat <- read.csv("restic-tests_4-remove_files_netstat.csv")
df_rclone_4_netstat <- read.csv("rclone-test_4-remove_files_netstat.csv")
df_b2sync_4_netstat <- read.csv("b2-sync-tests_4-remove_files_netstat.csv")

df_duplicity_5_netstat <- read.csv("duplicity-tests_5-restore_netstat.csv")
df_restic_5_netstat <- read.csv("restic-tests_5-restore_netstat.csv")
df_rclone_5_netstat <- read.csv("rclone-test_5-restore_netstat.csv")
df_b2sync_5_netstat <- read.csv("b2-sync-tests_5-restore_netstat.csv")

#df_duplicity_0_vmstat <- read.csv("duplicity-tests_0-initial_vmstat.csv")
#df_restic_0_vmstat <- read.csv("restic-tests_0-initial_vmstat.csv")
#df_rclone_0_vmstat <- read.csv("rclone-test_0-initial_vmstat.csv")
#df_b2sync_0_vmstat <- read.csv("b2-sync-tests_0-initial_vmstat.csv")
#
#df_duplicity_1_vmstat <- read.csv("duplicity-tests_1-add_files_vmstat.csv")
#df_restic_1_vmstat <- read.csv("restic-tests_1-add_files_vmstat.csv")
#df_rclone_1_vmstat <- read.csv("rclone-test_1-add_files_vmstat.csv")
#df_b2sync_1_vmstat <- read.csv("b2-sync-tests_1-add_files_vmstat.csv")
#
#df_duplicity_2_vmstat <- read.csv("duplicity-tests_2-modify_files_vmstat.csv")
#df_restic_2_vmstat <- read.csv("restic-tests_2-modify_files_vmstat.csv")
#df_rclone_2_vmstat <- read.csv("rclone-test_2-modify_files_vmstat.csv")
#df_b2sync_2_vmstat <- read.csv("b2-sync-tests_2-modify_files_vmstat.csv")
#
#df_duplicity_3_vmstat <- read.csv("duplicity-tests_3-touch_files_vmstat.csv")
#df_restic_3_vmstat <- read.csv("restic-tests_3-touch_files_vmstat.csv")
#df_rclone_3_vmstat <- read.csv("rclone-test_3-touch_files_vmstat.csv")
#df_b2sync_3_vmstat <- read.csv("b2-sync-tests_3-touch_files_vmstat.csv")
#
#df_duplicity_4_vmstat <- read.csv("duplicity-tests_4-remove_files_vmstat.csv")
#df_restic_4_vmstat <- read.csv("restic-tests_4-remove_files_vmstat.csv")
#df_rclone_4_vmstat <- read.csv("rclone-test_4-remove_files_vmstat.csv")
#df_b2sync_4_vmstat <- read.csv("b2-sync-tests_4-remove_files_vmstat.csv")
#
#df_duplicity_5_vmstat <- read.csv("duplicity-tests_5-restore_vmstat.csv")
#df_restic_5_vmstat <- read.csv("restic-tests_5-restore_vmstat.csv")
#df_rclone_5_vmstat <- read.csv("rclone-test_5-restore_vmstat.csv")
#df_b2sync_5_vmstat <- read.csv("b2-sync-tests_5-restore_vmstat.csv")

# *** End of edits to select netstat or vmstat

# *** (2 of 4) Edits to define the plot, data frames, and test names start here.

# *** Select one of the following sections (a plot name, a list of data frames,
# and a list of test names), depending on which output file and test you're
# plotting:
plot_name <- "0-initial_netstat"
dfs <- list(
 df_duplicity_0_netstat,
 df_restic_0_netstat,
 df_rclone_0_netstat,
 df_b2sync_0_netstat
)
test_names <- c(
 "duplicity_0_netstat",
 "restic_0_netstat",
 "rclone_0_netstat",
 "b2sync_0_netstat"
)

#plot_name <- "1-add_files_netstat"
#dfs <- list(
# df_duplicity_1_netstat,
#    df_restic_1_netstat,
#    df_rclone_1_netstat,
#    df_b2sync_1_netstat
#)
#test_names <- c(
# "duplicity_1_netstat",
#    "restic_1_netstat",
#    "rclone_1_netstat",
#    "b2sync_1_netstat"
#)

#plot_name <- "2-modify_files_netstat"
#dfs <- list(
# df_duplicity_2_netstat,
#    df_restic_2_netstat,
#    df_rclone_2_netstat,
#    df_b2sync_2_netstat
#)
#test_names <- c(
# "duplicity_2_netstat",
#    "restic_2_netstat",
#    "rclone_2_netstat",
#    "b2sync_2_netstat"
#)

#plot_name <- "3-touch_files_netstat"
#dfs <- list(
#  df_duplicity_3_netstat,
#    df_restic_3_netstat,
#    df_rclone_3_netstat,
#    df_b2sync_3_netstat
#)
#test_names <- c(
#  "duplicity_3_netstat",
#    "restic_3_netstat",
#    "rclone_3_netstat",
#    "b2sync_3_netstat"
#)

#plot_name <- "4-remove_files_netstat"
#dfs <- list(
#  df_duplicity_4_netstat,
#     df_restic_4_netstat,
#     df_rclone_4_netstat,
#     df_b2sync_4_netstat
#)
#test_names <- c(
#  "duplicity_4_netstat",
#     "restic_4_netstat",
#     "rclone_4_netstat",
#     "b2sync_4_netstat"
#)

#plot_name <- "5-restore_netstat"
#dfs <- list(
#  df_duplicity_5_netstat,
#     df_restic_5_netstat,
#     df_rclone_5_netstat,
#     df_b2sync_5_netstat
#)
#test_names <- c(
#  "duplicity_5_netstat",
#     "restic_5_netstat",
#     "rclone_5_netstat",
#     "b2sync_5_netstat"
#)

#plot_name <- "0-initial_vmstat_cpu"
#plot_name <- "0-initial_vmstat_mem"
#dfs <- list(
#  df_duplicity_0_vmstat,
#     df_restic_0_vmstat,
#     df_rclone_0_vmstat,
#     df_b2sync_0_vmstat
#)
#test_names <- c(
#  "duplicity_0_vmstat",
#     "restic_0_vmstat",
#     "rclone_0_vmstat",
#     "b2sync_0_vmstat"
#)

#plot_name <- "1-add_files_vmstat_cpu"
#plot_name <- "1-add_files_vmstat_mem"
#dfs <- list(
#  df_duplicity_1_vmstat,
#     df_restic_1_vmstat,
#     df_rclone_1_vmstat,
#     df_b2sync_1_vmstat
#)
#test_names <- c(
#  "duplicity_1_vmstat",
#     "restic_1_vmstat",
#     "rclone_1_vmstat",
#     "b2sync_1_vmstat"
#)

#plot_name <- "2-modify_files_vmstat_cpu"
#plot_name <- "2-modify_files_vmstat_mem"
#dfs <- list(
#  df_duplicity_2_vmstat,
#     df_restic_2_vmstat,
#     df_rclone_2_vmstat,
#     df_b2sync_2_vmstat
#)
#test_names <- c(
#  "duplicity_2_vmstat",
#     "restic_2_vmstat",
#     "rclone_2_vmstat",
#     "b2sync_2_vmstat"
#)

#plot_name <- "3-touch_files_vmstat_cpu"
#plot_name <- "3-touch_files_vmstat_mem"
#dfs <- list(
#  df_duplicity_3_vmstat,
#     df_restic_3_vmstat,
#     df_rclone_3_vmstat,
#     df_b2sync_3_vmstat
#)
#test_names <- c(
#  "duplicity_3_vmstat",
#     "restic_3_vmstat",
#     "rclone_3_vmstat",
#     "b2sync_3_vmstat"
#)

#plot_name <- "4-remove_files_vmstat_cpu"
#plot_name <- "4-remove_files_vmstat_mem"
#dfs <- list(
#  df_duplicity_4_vmstat,
#     df_restic_4_vmstat,
#     df_rclone_4_vmstat,
#     df_b2sync_4_vmstat
#)
#test_names <- c(
#  "duplicity_4_vmstat",
#     "restic_4_vmstat",
#     "rclone_4_vmstat",
#     "b2sync_4_vmstat"
#)

#plot_name <- "5-restore_vmstat_cpu"
#plot_name <- "5-restore_vmstat_mem"
#dfs <- list(
#  df_duplicity_5_vmstat,
#     df_restic_5_vmstat,
#     df_rclone_5_vmstat,
#     df_b2sync_5_vmstat
#)
#test_names <- c(
#  "duplicity_5_vmstat",
#     "restic_5_vmstat",
#     "rclone_5_vmstat",
#     "b2sync_5_vmstat"
#)

# *** End of edits to define the plot, data frames, and test names

# Note: microbenchmark shows that using assignment to add the
# column to the data frame performs better than cbind-ing the
# data frame and the column as below.
bind_name_col <- function(frame, name) {
    frame$test.name <- rep(name, nrow(frame))
    return(frame)
}

# bind_name_col2 <- function(frame, name) {
#     return(
#         cbind(
#             frame,
#             data.frame( test.name = rep( name, nrow(frame) ) )
#         )
#     )
# }

bind_time_col <- function(frame) {
    frame$seconds <- rownames(frame)
    return(frame)
}

dfs <- mapply(bind_name_col, dfs, test_names, SIMPLIFY=FALSE)
dfs <- lapply(dfs, bind_time_col)

# *** (3 of 4) Edits to select the dataset start here.

# *** Uncomment only one of the following sections, depending on whether
# you're plotting netstat outputs or vmstat outputs. Then, within that section,
# uncomment the correct sample rate for the test you're plotting, and uncomment
# only one of the two variables (e.g. either sent bytes or received bytes from
# netstat; either CPU stats or memory stats from vmstat).

# *** For netstat (sent.bytes -or- received.bytes) column:
dfs <- lapply(dfs, function(frame) {
    # *** Uncomment one of the following sample rates:
    sample_rate <- 300 # tests 0 and 1
    #sample_rate <- 120 # tests 2 and 5
    #sample_rate <- 15 # tests 3 and 4

    # *** Uncomment one of the following variables:
    samples <- colMeans(matrix(frame$sent.bytes, nrow=sample_rate)) / 1024^2
    #samples <- colMeans(matrix(frame$received.bytes, nrow=sample_rate)) / 1024^2

    sample_times <- frame$seconds[seq(1, length(frame$seconds), sample_rate)]
    sample_sources <- frame$test.name[seq(1, length(frame$test.name), sample_rate)]

    # *** Uncomment the same variable as above:
    data.frame( seconds=sample_times, sent.bytes=samples, test.name=sample_sources )
    #data.frame( seconds=sample_times, received.bytes=samples, test.name=sample_sources )
})

# *** For vmstat (cpustatistics_user+cpustatistics_system -or- memory_availablememory) column:
#dfs <- lapply(dfs, function(frame) {
#    # *** Uncomment one of the following sample rates:
#    sample_rate <- 300 # tests 0 and 1
#    #sample_rate <- 30 # test 2 only
#    #sample_rate <- 10 # tests 3 and 4
#    #sample_rate <- 60 # test 5 only
#
#    # *** Uncomment one of the following variables:
#    samples <- colMeans(matrix((frame$cpustatistics_user+frame$cpustatistics_system), nrow=sample_rate))
#    #samples <- colMeans(matrix(frame$memory_availablememory, nrow=sample_rate)) / 1024^2
#
#    sample_times <- frame$seconds[seq(1, length(frame$seconds), sample_rate)]
#    sample_sources <- frame$test.name[seq(1, length(frame$test.name), sample_rate)]
#
#    # *** Uncomment the same variable as above:
#    data.frame( seconds=sample_times, user_and_sys_cpu=samples, test.name=sample_sources )
#    #data.frame( seconds=sample_times, mapped_memory=samples, test.name=sample_sources )
#})


# Note: to use all data points instead of sampling, do this instead (this example plots netstat sent.bytes):
# dfs <- lapply(dfs, function(frame) {
#     data.frame( select(frame, seconds, sent.bytes, test.name) )
# })

# *** End of edits to select the dataset

merge_frames <- function(x, y) {
    suf = c( "", paste('.', y$test.name[[1]], sep="") )
    frame <- full_join( x, y, by="seconds", suffix=suf )
    frame <- select( frame, -starts_with("test.name") )
}

df.merged <- Reduce(merge_frames, dfs)

# Fix the name of the first variable column after the time sequence column
# (i.e. column 2), because it wasn't set in the merge function above. The
# following line assumes that the column names are now as follows:
#   [1] X [2] sent.bytes [3] sent.bytes.name_of_test
# So, fix the name of column 2 to match the others.
names(df.merged)[[2]] <- paste(names(df.merged)[[2]], test_names[[1]], sep=".")

# Melt data frame so that each row is keyed on a specific second
df.melted <- reshape2::melt(df.merged, id.var='seconds')

# Set figure size
options(repr.plot.width = 14, repr.plot.height = 8)

# *** (4 of 4) Edits to set the y-axis scale for this dataset start here.

# *** Creating the plot is also dataset-specific. Uncomment the correct y-axis # scale for the variable you selected above.
ggplot(df.melted, aes(x=seconds, y=value, col=variable, group=variable)) +
    scale_y_continuous(name="Data sent (MiB/s)", limits=c(0, 3)) + # netstat bytes.sent
    #scale_y_continuous(name="Data received (MiB/s)", limits=c(0, 50)) + # netstat bytes.received
    #scale_y_continuous(name="Sum user and system CPU time (%)") + # vmstat cpustatiscitcs_user + system
    #scale_y_continuous(name="Total mapped memory (GiB)") + # vmstat memory_availablememory
    scale_x_time(name="Elapsed time (HH:MM:SS)") +
    labs(color="Application and test") +
    geom_line()

# *** End of all edits

# Set the shape of the plot
aspect_ratio <- 1.5
height <- 7

# Save it as an svg file in the working directory
ggsave(
  paste(plot_name, "svg", sep="."),
  plot = last_plot(),
  device = svg,
  height = height,
  width = height * aspect_ratio
  #path = NULL,
  #scale = 1,
  #width = NA,
  #height = NA,
  #units = c("in", "cm", "mm"),
  #dpi = 300,
  #limitsize = TRUE
)
