library("xml2")


# This script parses vmstat's XML output manually using xml2.

# The following two lines would be the easy way, but we need to exclude the
# <device> elements in the vmstat output, so it doesn't work.
#vmstatdf <- xmlToDataFrame("vmstat.xml")
#write.csv(vmstatdf,"vmstat.csv", row.names = FALSE)

args = commandArgs(trailingOnly = TRUE)

if (length(args) != 1) {
  stop("Specify one xml file. Use xargs to specify more than one.: (input file).n", call.=FALSE)
}

document_name <- strsplit(args[[1]], "[.]")[[1]][1]

vmstat_xml <- read_xml(args[1])

vmstat <- xml_find_all(vmstat_xml, "..//statistics")

vmstat_processes <- xml_find_all(vmstat, ".//processes")
vmstat_memory <- xml_find_all(vmstat, ".//memory")
vmstat_pagingrates <- xml_find_all(vmstat, ".//paging-rates")
vmstat_faultrates <- xml_find_all(vmstat, ".//fault-rates")
vmstat_cpustatistics <- xml_find_all(vmstat, ".//cpu-statistics")

vmstat_processes_runnable <- xml_find_all(vmstat_processes, ".//runnable")
vmstat_processes_waiting <- xml_find_all(vmstat_processes, ".//waiting")
vmstat_processes_swappedout <- xml_find_all(vmstat_processes, ".//swapped-out")

vmstat_memory_availablememory <- xml_find_all(vmstat_memory, ".//available-memory")
vmstat_memory_freememory <- xml_find_all(vmstat_memory, ".//free-memory")
vmstat_memory_totalpagefaults <- xml_find_all(vmstat_memory, ".//total-page-faults")

vmstat_pagingrates_pagereactivated <- xml_find_all(vmstat_pagingrates, ".//page-reactivated")
vmstat_pagingrates_pagedin <- xml_find_all(vmstat_pagingrates, ".//paged-in")
vmstat_pagingrates_pagedout <- xml_find_all(vmstat_pagingrates, ".//paged-out")
vmstat_pagingrates_freed <- xml_find_all(vmstat_pagingrates, ".//freed")
vmstat_pagingrates_scanned <- xml_find_all(vmstat_pagingrates, ".//scanned")

vmstat_faultrates_interrupts <- xml_find_all(vmstat_faultrates, ".//interrupts")
vmstat_faultrates_systemcalls <- xml_find_all(vmstat_faultrates, ".//system-calls")
vmstat_faultrates_contextswitches <- xml_find_all(vmstat_faultrates, ".//context-switches")

vmstat_cpustatistics_user <- xml_find_all(vmstat_cpustatistics, ".//user")
vmstat_cpustatistics_system <- xml_find_all(vmstat_cpustatistics, ".//system")
vmstat_cpustatistics_idle <- xml_find_all(vmstat_cpustatistics, ".//idle")

vmstat_colnames <- c(
    "processes_runnable",
    "processes_waiting",
    "processes_swappedout",
    "memory_availablememory",
    "memory_freememory",
    "memory_totalpagefaults",
    "pagingrates_pagereactivated",
    "pagingrates_pagedin",
    "pagingrates_pagedout",
    "pagingrates_freed",
    "pagingrates_scanned",
    "faultrates_interrupts",
    "faultrates_systemcalls",
    "faultrates_contextswitches",
    "cpustatistics_user",
    "cpustatistics_system",
    "cpustatistics_idle"
)

vmstat_columns <- list(
    vmstat_processes_runnable,
    vmstat_processes_waiting,
    vmstat_processes_swappedout,
    vmstat_memory_availablememory,
    vmstat_memory_freememory,
    vmstat_memory_totalpagefaults,
    vmstat_pagingrates_pagereactivated,
    vmstat_pagingrates_pagedin,
    vmstat_pagingrates_pagedout,
    vmstat_pagingrates_freed,
    vmstat_pagingrates_scanned,
    vmstat_faultrates_interrupts,
    vmstat_faultrates_systemcalls,
    vmstat_faultrates_contextswitches,
    vmstat_cpustatistics_user,
    vmstat_cpustatistics_system,
    vmstat_cpustatistics_idle
)

vmstat_columns_text <- lapply(vmstat_columns, xml_text)
vmstat_columns_numeric <- lapply(vmstat_columns_text, as.numeric)
vmstat_matrix <- do.call(cbind, vmstat_columns_numeric)
df = as.data.frame(vmstat_matrix)
names(df) <- vmstat_colnames

write.csv(df, paste(document_name,".csv",sep=""), row.names = FALSE)
