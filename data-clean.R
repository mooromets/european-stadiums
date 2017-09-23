# Clean cities
csvInput <- "../worldcitiespop.txt"
gzInput <- paste0(csvInput, ".gz")
csvOutput <- "data/cities.csv"
uefaCodes <- tolower(c("AL", "AD", "AM", "AT", "BY", "BE", "BA", "BG", "CH", 
            "CY", "CZ", "DE", "DK", "EE", "ES", "FO", "FI", "FR", "GB", "GE", 
            "GI", "GR", "HU", "HR", "IE", "IS", "IT", "LT", "LU", "LV", "PL", 
            "MC", "MK", "MT", "NO", "NL", "PO", "PT", "RO", "RU", "SE", "RS",
            "SI", "SK", "SM", "TR", "UA", "VA", "AZ", "KZ", "IL", "ME"))

if (!file.exists(csvOutput)) {
  require(R.utils)
  if (!file.exists(csvInput))
    R.utils::gunzip(filename = gzInput, remove = FALSE)
  print("Reading full cities' data...")
  cities <- read.csv(csvInput)
  print("Removing NA-s...")
  clean <- na.omit(cities)
  require(dplyr)
  clean <- filter(clean, Country %in% uefaCodes) %>%
            select(Country, City, Latitude, Longitude)
  print("Saving data...")
  write.csv(clean, csvOutput, row.names = FALSE)
  rm(cities)
  rm(clean)
  file.remove(csvInput)
}
