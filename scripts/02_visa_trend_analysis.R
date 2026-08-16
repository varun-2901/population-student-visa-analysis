library(tidyverse)
library(ggplot2)
library(zoo)

cat("\n================================================================================\n")
cat("STUDENT VISA TREND ANALYSIS\n")
cat("================================================================================\n\n")

# Load visa data
visas <- read_csv("data/raw/student_visas_total.csv", show_col_types = FALSE) %>%
  mutate(year = as.numeric(substr(financial_year, 1, 4))) %>%
  select(year, visas_granted) %>%
  rename(visas = visas_granted) %>%
  arrange(year) %>%
  mutate(
    yoy_change = visas - lag(visas),
    yoy_pct = (visas - lag(visas)) / lag(visas) * 100,
    ma_3yr = rollmean(visas, 3, na.pad = TRUE)
  )

cat("Visa data loaded:", nrow(visas), "years\n\n")
print(visas)

# Save
write_csv(visas, "data/processed/visa_analysis.csv")
cat("\n✓ Saved to: data/processed/visa_analysis.csv\n")