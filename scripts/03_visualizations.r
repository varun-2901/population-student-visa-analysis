#!/usr/bin/env Rscript
# ============================================================================
# VISUALIZATIONS - STUDENT VISA ANALYSIS
# ============================================================================

library(tidyverse)
library(ggplot2)

cat("\n================================================================================\n")
cat("CREATING VISUALIZATIONS\n")
cat("================================================================================\n\n")

# ============================================================================
# 1. LOAD DATA
# ============================================================================

cat("Loading visa analysis data...\n")
visas <- read_csv("data/processed/visa_analysis.csv", show_col_types = FALSE)

cat("✓ Data loaded\n\n")

# ============================================================================
# 2. TIME SERIES CHART
# ============================================================================

cat("Creating Chart 1: Time Series...\n")

p1 <- ggplot(visas, aes(x = year, y = visas)) +
  geom_line(color = "#667eea", size = 1.2) +
  geom_point(color = "#667eea", size = 3) +
  geom_smooth(method = "loess", se = TRUE, alpha = 0.2, color = "#764ba2") +
  labs(
    title = "Australian Student Visa Grants Over 21 Years",
    subtitle = "Annual totals (2005-06 to 2025-26)",
    x = "Financial Year",
    y = "Number of Visas Granted",
    caption = "Source: Department of Home Affairs"
  ) +
  theme_minimal() +
  theme(
    plot.title = element_text(size = 16, face = "bold", color = "#667eea"),
    plot.subtitle = element_text(size = 12, color = "#666"),
    axis.title = element_text(size = 11, color = "#333"),
    panel.grid.major = element_line(color = "#f0f0f0"),
    panel.grid.minor = element_blank()
  ) +
  scale_y_continuous(labels = scales::comma)

ggsave("outputs/visualizations/01_time_series.png", p1, width = 10, height = 6, dpi = 300)
cat("✓ Saved: 01_time_series.png\n")

# ============================================================================
# 3. YEAR-ON-YEAR GROWTH CHART
# ============================================================================

cat("Creating Chart 2: YoY Growth...\n")

p2 <- visas %>%
  filter(!is.na(yoy_pct)) %>%
  ggplot(aes(x = year, y = yoy_pct, fill = ifelse(yoy_pct > 0, "Growth", "Decline"))) +
  geom_col() +
  geom_hline(yintercept = 0, color = "#333", size = 0.5) +
  scale_fill_manual(values = c("Growth" = "#2ecc71", "Decline" = "#e74c3c")) +
  labs(
    title = "Year-on-Year Change in Student Visa Grants",
    subtitle = "Percentage change from previous year",
    x = "Financial Year",
    y = "YoY Change (%)",
    fill = "Direction",
    caption = "Source: Department of Home Affairs"
  ) +
  theme_minimal() +
  theme(
    plot.title = element_text(size = 16, face = "bold", color = "#667eea"),
    plot.subtitle = element_text(size = 12, color = "#666"),
    axis.title = element_text(size = 11, color = "#333"),
    panel.grid.major.y = element_line(color = "#f0f0f0"),
    panel.grid.major.x = element_blank(),
    panel.grid.minor = element_blank(),
    legend.position = "top"
  )

ggsave("outputs/visualizations/02_yoy_growth.png", p2, width = 10, height = 6, dpi = 300)
cat("✓ Saved: 02_yoy_growth.png\n")

# ============================================================================
# 4. TREND WITH MOVING AVERAGE
# ============================================================================

cat("Creating Chart 3: Trend with Moving Average...\n")

p3 <- ggplot(visas, aes(x = year)) +
  geom_line(aes(y = visas, color = "Actual"), size = 1, alpha = 0.7) +
  geom_line(aes(y = ma_3yr, color = "3-Year MA"), size = 1.2) +
  geom_point(aes(y = visas, color = "Actual"), size = 2) +
  scale_color_manual(
    values = c("Actual" = "#667eea", "3-Year MA" = "#e74c3c"),
    name = "Trend"
  ) +
  labs(
    title = "Student Visa Grants with 3-Year Moving Average",
    subtitle = "Smoothed trend to identify underlying patterns",
    x = "Financial Year",
    y = "Number of Visas",
    caption = "Source: Department of Home Affairs"
  ) +
  theme_minimal() +
  theme(
    plot.title = element_text(size = 16, face = "bold", color = "#667eea"),
    plot.subtitle = element_text(size = 12, color = "#666"),
    axis.title = element_text(size = 11, color = "#333"),
    panel.grid.major = element_line(color = "#f0f0f0"),
    panel.grid.minor = element_blank(),
    legend.position = "top"
  ) +
  scale_y_continuous(labels = scales::comma)

ggsave("outputs/visualizations/03_trend_ma.png", p3, width = 10, height = 6, dpi = 300)
cat("✓ Saved: 03_trend_ma.png\n")

# ============================================================================
# 5. DISTRIBUTION HISTOGRAM
# ============================================================================

cat("Creating Chart 4: Distribution...\n")

p4 <- ggplot(visas, aes(x = visas)) +
  geom_histogram(fill = "#667eea", color = "white", bins = 8, alpha = 0.8) +
  geom_vline(aes(xintercept = mean(visas), color = "Mean"), 
             linetype = "dashed", size = 1) +
  geom_vline(aes(xintercept = median(visas), color = "Median"), 
             linetype = "dashed", size = 1) +
  scale_color_manual(
    values = c("Mean" = "#e74c3c", "Median" = "#2ecc71"),
    name = "Central Tendency"
  ) +
  labs(
    title = "Distribution of Annual Student Visa Grants",
    subtitle = "Histogram showing frequency of visa numbers across 21 years",
    x = "Number of Visas Granted",
    y = "Frequency",
    caption = "Source: Department of Home Affairs"
  ) +
  theme_minimal() +
  theme(
    plot.title = element_text(size = 16, face = "bold", color = "#667eea"),
    plot.subtitle = element_text(size = 12, color = "#666"),
    axis.title = element_text(size = 11, color = "#333"),
    panel.grid.major.y = element_line(color = "#f0f0f0"),
    panel.grid.major.x = element_blank(),
    panel.grid.minor = element_blank(),
    legend.position = "top"
  ) +
  scale_x_continuous(labels = scales::comma)

ggsave("outputs/visualizations/04_distribution.png", p4, width = 10, height = 6, dpi = 300)
cat("✓ Saved: 04_distribution.png\n")

# ============================================================================
# 6. SUMMARY STATISTICS
# ============================================================================

cat("\n")
cat("================================================================================\n")
cat("SUMMARY STATISTICS\n")
cat("================================================================================\n\n")

cat("Mean annual visas:", round(mean(visas$visas), 0), "\n")
cat("Median annual visas:", round(median(visas$visas), 0), "\n")
cat("Min:", round(min(visas$visas), 0), "\n")
cat("Max:", round(max(visas$visas), 0), "\n")
cat("Std Dev:", round(sd(visas$visas), 0), "\n\n")

cat("YoY Growth Statistics:\n")
cat("Mean growth:", round(mean(visas$yoy_pct, na.rm = TRUE), 2), "%\n")
cat("Max growth:", round(max(visas$yoy_pct, na.rm = TRUE), 2), "%\n")
cat("Max decline:", round(min(visas$yoy_pct, na.rm = TRUE), 2), "%\n\n")

# ============================================================================
# 7. COMPLETE
# ============================================================================

cat("================================================================================\n")
cat("✓ VISUALIZATION COMPLETE\n")
cat("================================================================================\n\n")

cat("Charts created:\n")
cat("  1. 01_time_series.png\n")
cat("  2. 02_yoy_growth.png\n")
cat("  3. 03_trend_ma.png\n")
cat("  4. 04_distribution.png\n\n")

cat("Next: Run 04_forecasting.R\n\n")