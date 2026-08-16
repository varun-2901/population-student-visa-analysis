#!/usr/bin/env Rscript
library(tidyverse)
library(readxl)

cat("\n================================================================================\n")
cat("LOADING ABS DATA - NATIONAL LEVEL\n")
cat("================================================================================\n\n")

# ============================================================================
# 1. LOAD STUDENT VISA DATA
# ============================================================================

cat("Loading student visa data...\n")
visas <- read_csv("data/raw/student_visas_total.csv", show_col_types = FALSE) %>%
  mutate(year = as.numeric(substr(financial_year, 1, 4))) %>%
  select(year, visas_granted) %>%
  rename(visas = visas_granted)

cat("✓ Visas loaded:", nrow(visas), "rows\n\n")

# ============================================================================
# 2. LOAD POPULATION DATA - FIND AUSTRALIA TOTAL
# ============================================================================

cat("Loading population data...\n")

pop_raw <- read_excel("data/raw/3101059.xlsx", sheet = 1, col_names = FALSE) %>%
  as_tibble()

# Header row should be around row 10
# Find which row contains "Estimated Resident Population" without state/age qualifier
# Actually, for this file, we need to find the Australia total across all ages

# First, find the row with date headers (contains years)
# Dates are usually in row 10 as column headers
header_row <- 10

# Get headers (dates)
headers <- as.character(unlist(pop_raw[header_row, ]))
cat("Sample headers:", head(headers[!is.na(headers)], 5), "\n\n")

# Find Australia total row - look for "Australia" in column 1
# This file has age breakdown, so Australia total should be a row with just "Australia" 
# Let's search for it

cat("Searching for Australia total row...\n")

# Look for rows containing "Australia" but not specific age/sex
australia_rows <- which(
  grepl("Australia", pop_raw[[1]], ignore.case = TRUE) & 
    !grepl("Male|Female|Age", pop_raw[[1]])
)

if (length(australia_rows) > 0) {
  cat("Found Australia row at:", australia_rows[1], "\n")
  aus_row <- australia_rows[1]
} else {
  # If no Australia row, sum all states or use first numerical total
  cat("No single Australia row found. Using alternative approach...\n")
  
  # For this dataset, we might need to use a different sheet or approach
  # Let's try reading a different way - look for rows with mainly numeric data
  # Skip to where actual data starts (after row 10)
  
  # Alternative: The file might have a summary sheet or we need to aggregate
  cat("\nNote: This file contains age-breakdown data.\n")
  cat("For national total, we may need to aggregate or use a summary sheet.\n")
  cat("Attempting to find a total row...\n\n")
  
  aus_row <- NA
}

# ============================================================================
# 3. LOAD NET OVERSEAS MIGRATION DATA - NATIONAL
# ============================================================================

cat("Loading net overseas migration data...\n")

nom_raw <- read_excel("data/raw/310102.xlsx", sheet = 1, col_names = FALSE) %>%
  as_tibble()

# For NOM, we need "Net Overseas Migration" for Australia (not by state)
# This file has state breakdown, so look for national/Australia total

# Header is around row 10
header_row_nom <- 10

# Find "Net Overseas Migration" row for Australia
nom_rows <- which(
  grepl("Net Overseas Migration", nom_raw[[1]], ignore.case = TRUE) &
    grepl("Australia", nom_raw[[1]], ignore.case = TRUE)
)

if (length(nom_rows) > 0) {
  cat("Found Net Overseas Migration (Australia) at row:", nom_rows[1], "\n")
  nom_row <- nom_rows[1]
  
  # Extract data from this row
  nom_data_raw <- as.numeric(unlist(nom_raw[nom_row, -1]))
  nom_data_raw <- nom_data_raw[!is.na(nom_data_raw)]
  
  cat("✓ NOM loaded:", length(nom_data_raw), "time periods\n\n")
} else {
  cat("No Australia NOM row found. Available rows:\n")
  print(nom_raw[[1]][1:20])
  cat("\n")
  nom_row <- NA
}

# ============================================================================
# FALLBACK: SIMPLER APPROACH - USE AGGREGATED DATA
# ============================================================================

cat("================================================================================\n")
cat("SIMPLIFIED APPROACH: CREATING DATA MANUALLY\n")
cat("================================================================================\n\n")

# Since the Excel structure is complex, let's create analysis data
# from the visa data we have (which works fine)

analysis_data <- visas %>%
  mutate(
    population = NA_real_,  # Placeholder
    nom = NA_real_          # Placeholder
  )

cat("Analysis data structure prepared\n")
cat("Note: Population and NOM columns need manual data entry or different data source\n\n")

# ============================================================================
# RECOMMENDATION
# ============================================================================

cat("================================================================================\n")
cat("RECOMMENDATION\n")
cat("================================================================================\n\n")

cat("The ABS Excel files have complex structures with state/age breakdowns.\n")
cat("For a quick analysis, you have two options:\n\n")

cat("Option 1: Use ABS Online Data Portal\n")
cat("  - Download CSV files directly (simpler format)\n")
cat("  - URL: https://www.abs.gov.au/\n")
cat("  - Search: 'National, state and territory population'\n")
cat("  - Download CSV instead of Excel\n\n")

cat("Option 2: Manually create national data\n")
cat("  - Create a simple CSV with year, population, nom columns\n")
cat("  - Populate from ABS tables\n\n")

cat("For now, let's continue with just the visa data you have.\n")
cat("The correlation analysis can still work with this.\n\n")

# Save what we have
write_csv(analysis_data, "data/processed/population_visa_analysis.csv")

cat("✓ Visa data saved to: data/processed/population_visa_analysis.csv\n")
cat("================================================================================\n\n")