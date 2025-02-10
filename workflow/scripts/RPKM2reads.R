# You need to run reformat_rpkm.ipynb first to achieve the reformatted RPKM table reformatted contig length table
# Load necessary libraries (install if missing)
install_if_missing <- function(pkg) {
  if (!require(pkg, quietly = TRUE, character.only = TRUE)) {
    install.packages(pkg, repos = "http://cran.us.r-project.org")
    library(pkg, character.only = TRUE)
  }
}

install_if_missing("argparse")
install_if_missing("dplyr")

suppressMessages(library(argparse))
suppressMessages(library(dplyr))

# Argument parser setup
parser <- ArgumentParser(description = "Processes RPKM data")

parser$add_argument("--rpkm", "-r", required = TRUE, help = "Formatted contigs RPKM table")
parser$add_argument("--contig_length", "-cl", required = TRUE, help = "Contig length table")
parser$add_argument("--sample_total_reads", "-str", required = TRUE, help = "Sample total reads table")
parser$add_argument("--output", "-o", required = TRUE, help = "Output file path")

# Parse arguments
xargs <- parser$parse_args()
rpkm_path <- xargs$rpkm
contig_length_path <- xargs$contig_length
sample_total_reads_path <- xargs$sample_total_reads
output_name <- xargs$output

# Check if all input files exist
files <- c(rpkm_path, contig_length_path, sample_total_reads_path)
missing_files <- files[!file.exists(files)]
if (length(missing_files) > 0) {
  stop("Error: The following input file(s) do not exist:\n", paste(missing_files, collapse = "\n"))
}

# Load data
rpkm <- read.csv(rpkm_path, row.names = 1)
contig_length <- read.csv(contig_length_path, header = TRUE)
sample_total_reads <- read.csv(sample_total_reads_path, sep = ",", header = FALSE)

sample_order <- colnames(rpkm)
contig_order <- rownames(rpkm)

# Reorder sample_total_reads to match rpkm columns
sample_total_reads <- sample_total_reads %>%
  filter(V1 %in% sample_order) %>%
  arrange(match(V1, sample_order))

# Reorder contig_length to match rpkm rownames
contig_length <- contig_length %>%
  filter(X %in% contig_order) %>%
  arrange(match(X, contig_order))

colnames(contig_length) <- c("contig_id", "contig_length")
rownames(contig_length) <- contig_length$contig_id

contig_length_vector <- setNames(contig_length$contig_length, contig_length$contig_id)
sample_total_reads_vector <- setNames(sample_total_reads[,2], sample_total_reads[,1])

# Compute RPKM reads
rpkm_reads <- sweep(rpkm, 2, sample_total_reads_vector, FUN = "*")  # Multiply by sample reads
rpkm_reads <- sweep(rpkm_reads, 1, contig_length_vector, FUN = "*") # Multiply by contig length
rpkm_reads <- rpkm_reads / 1e6                                      # Normalize by 1,000,000

write.csv(rpkm_reads, output_name, row.names = TRUE)

message("Processing complete. Output saved to: ", output_name)
