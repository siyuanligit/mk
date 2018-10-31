### working directory
setwd("C:/Users/Derek/Google Drive/bootcamp/Project2/mk")

### dependencies
library(readr)
library(tidyverse)
library(plotly)
library(recommenderlab)

### load data
mkItems2 = read_csv("mkItems2.csv")

mkItems2 = mkItems2 %>% 
    mutate(price = as.numeric(gsub("[$]", "", price)),
           keyprint = case_when(
               grepl('(Dye Sub PBT)', keycap)==TRUE ~ "Dye-Sub PBT",
               grepl('(Dye Sub ABS)', keycap)==TRUE ~ "Dye-Sub ABS",
               grepl('(Laser Printed ABS)', keycap)==TRUE ~ "Laser-Printed ABS",
               grepl('(Double Shot ABS)', keycap)==TRUE ~ "Double-Shot ABS",
               grepl('(Double Shot PBT)', keycap)==TRUE ~ "Double-Shot PBT",
               grepl('(Pad Printed ABS)', keycap)==TRUE ~ "Pad-Printed ABS",
               grepl('(Pad Printed PBT)', keycap)==TRUE ~ "Pad-Printed PBT",
               grepl('(Laser Engraved PBT)', keycap)==TRUE ~ "Laser-Engraved PBT",
               grepl('(Laser Engraved ABS)', keycap)==TRUE ~ "Laser-Engraved ABS",
               grepl('(UV Printed ABS)', keycap)==TRUE ~ "UV-Printed ABS",
               grepl('(Laser Etched ABS)', keycap)==TRUE ~ "Laser-Etched ABS",
               grepl('(Laser Printed PBT)', keycap)==TRUE ~ "Laser-Printed PBT",
               grepl('(Blank PBT)', keycap)==TRUE ~ "Blank PBT",
               grepl('(Blank ABS)', keycap)==TRUE ~ "Blank ABS")) %>% 
    separate(keycap, into = c("d1", "keycap"), sep = '(: )') %>% 
    separate(keycap, into = c("keycap", "legend"), sep = " with ") %>%
    filter(!is.na(legend)) %>% 
    mutate(legend = gsub("( legends| legend)", "", legend)) %>% 
    separate(keyprint, into = c("print", "material"), sep = " ") %>% 
    select(-d1, -logilayout, -physlayout, -keycap) %>% 
    select(name, brand, model, switch, sku, 
           price, material, legend, print, frcolor, 
           rollover, led, interface, dimension, weight, 
           averating, nreviews, img)

min(mkItems2$price)
max(mkItems2$price)

mkItems2 %>% select(brand, model) %>% distinct()

save(mkItems2, file = "mkItem.rdata")

### plots
# highest rated brands
mkItems2 %>% 
    distinct(name, .keep_all = TRUE) %>% 
    group_by(brand) %>% 
    summarise(AveRating = mean(averating, na.rm = T), NReview = sum(nreviews)) %>% 
    filter(NReview > 10) %>% 
    arrange(desc(AveRating)) %>% 
    top_n(5) %>% 
    ggplot(aes(x = reorder(brand, AveRating), y = AveRating, fill = AveRating)) +
    geom_bar(stat = "identity", fill = "#66CC99") +
    geom_text(aes(label = round(AveRating, 1)), 
              colour = "white", 
              fontface = "bold", 
              hjust = 1.2, 
              vjust = 0.4, 
              size = 12) +
    coord_flip() +
    guides(fill=FALSE) +
    labs(x = "", y ="") +
    theme(axis.text.y = element_text(size = 16),
          axis.text.x = element_blank(),
          axis.ticks = element_blank(),
          panel.grid.major = element_blank(),
          panel.grid.minor = element_blank(),
          panel.background = element_blank())
    

# most review brands
mkItems2 %>% 
    distinct(name, .keep_all = TRUE) %>% 
    group_by(brand) %>% 
    summarise(AveRating = mean(averating, na.rm = T), NReview = sum(nreviews)) %>% 
    filter(NReview > 20) %>% 
    arrange(desc(NReview)) %>% 
    top_n(5) %>% 
    ggplot(aes(x = reorder(brand, NReview), y = NReview)) +
    geom_bar(stat = "identity", fill = "#66CC99") +
    geom_text(aes(label = NReview), 
              colour = "white", 
              fontface = "bold", 
              hjust = 1.2, 
              vjust = 0.4, 
              size = 12) +
    coord_flip() +
    guides(fill=FALSE) +
    labs(x = "", y ="") +
    theme(axis.text.y = element_text(size = 16),
          axis.text.x = element_blank(),
          axis.ticks = element_blank(),
          panel.grid.major = element_blank(),
          panel.grid.minor = element_blank(),
          panel.background = element_blank())

# all offered switch type
mkItems2 %>% 
    group_by(switch) %>% 
    select(switch) %>% 
    add_tally() %>% 
    distinct() %>% 
    mutate(switchBrand = strsplit(switch, " ")[[1]][1]) %>% 
    arrange(n) %>%
    filter(n > 1) %>% 
    ggplot(aes(x = reorder(switch, n), y = n, fill = switchBrand)) + 
    geom_bar(stat = "identity") +
    geom_text(aes(label = n),
              hjust = -0.2,
              size = 4) +
    coord_flip() +
    labs(x = "", y = "") +
    theme(axis.text.y = element_text(size = 9),
          axis.text.x = element_blank(),
          axis.ticks = element_blank(),
          panel.grid.major = element_blank(),
          panel.grid.minor = element_blank(),
          panel.background = element_blank())

# most offered switch type
mkItems2 %>% 
    group_by(switch) %>% 
    select(switch) %>% 
    add_tally() %>% 
    distinct() %>% 
    mutate(switchBrand = strsplit(switch, " ")[[1]][1]) %>% 
    arrange(n) %>%
    tail(10) %>% 
    ggplot(aes(x = reorder(switch, n), y = n, fill = switchBrand)) + 
    geom_bar(stat = "identity") +
    coord_flip()

# switch brand vs price
mkItems2 %>% 
    group_by(switch) %>% 
    mutate(switchBrand = strsplit(switch, " ")[[1]][1]) %>% 
    ungroup() %>% 
    group_by(switchBrand) %>% 
    summarise(avePrice = mean(price, na.rm = T)) %>% 
    arrange(desc(avePrice)) %>% 
    ggplot(aes(x = reorder(switchBrand, avePrice), y = avePrice, fill = switchBrand)) +
    geom_bar(stat = "identity", fill = "#66CC99") +
    geom_text(aes(label = paste0("$", round(avePrice, 0))), 
              colour = "white", 
              fontface = "bold", 
              hjust = 1.2, 
              vjust = 0.4, 
              size = 12) +
    coord_flip() +
    guides(fill=FALSE) +
    labs(x = "", y ="") +
    theme(axis.text.y = element_text(size = 16),
          axis.text.x = element_blank(),
          axis.ticks = element_blank(),
          panel.grid.major = element_blank(),
          panel.grid.minor = element_blank(),
          panel.background = element_blank())

# aveRating vs price
mkItems2 %>% 
    distinct(name, .keep_all = TRUE) %>% 
    select(price, averating, brand, nreviews) %>% 
    filter(!is.na(averating)) %>% 
    group_by(brand) %>% 
    summarise(avePrice = mean(price, na.rm = T), 
              aveRating = mean(averating, na.rm = T),
              NReviews = sum(nreviews)) %>%
    filter(NReviews > 1) %>% 
    ggplot(aes(x = avePrice, y = aveRating, label = brand)) +
    geom_text(check_overlap = TRUE, size = 6) +
    xlim(0, 310) +
    ylim(4,5) +
    guides(fill=FALSE) +
    labs(x = "Average Price", y ="Average Rating") +
    theme(axis.text.y = element_text(size = 8),
          axis.text.x = element_text(size = 8),
          axis.line.x = element_line(),
          axis.line.y = element_line(),
          axis.ticks = element_blank(),
          panel.grid.major = element_blank(),
          panel.grid.minor = element_blank(),
          panel.background = element_blank())

# rgb!
mkItems2 %>% 
    distinct(name, .keep_all = TRUE) %>% 
    mutate(rgb = case_when(led == "RGB" ~ "RGB",
                           TRUE ~ "non-RGB")) %>% 
    group_by(rgb) %>% 
    summarise(avePrice = mean(price, na.rm = T), 
              aveRating = mean(averating, na.rm = T))

mkItems2 %>% 
    distinct(name, .keep_all = TRUE) %>% 
    group_by(led) %>% 
    summarise(avePrice = mean(price, na.rm = T), 
              aveRating = mean(averating, na.rm = T),
              NReviews = sum(nreviews)) %>% 
    filter(NReviews > 5) %>% 
    ggplot(aes(x = reorder(led, avePrice), y = avePrice, fill = led)) +
    geom_col() +
    geom_text(aes(label = paste0("$", round(avePrice, 0))), 
              colour = "white", 
              fontface = "bold", 
              hjust = 1.2, 
              vjust = 0.4, 
              size = 12) +
    coord_flip() +
    scale_fill_manual(values = c("#3300FF", "red", "#666666", "#FF33CC", "#33FF33", "#CCCCCC")) +
    guides(fill=FALSE) +
    labs(x = "", y = "") +
    theme(axis.text.x = element_blank(),
          axis.text.y = element_text(size = 16),
          axis.ticks = element_blank(),
          panel.grid.major = element_blank(),
          panel.grid.minor = element_blank(),
          panel.background = element_blank())

mkItems2 %>% 
    distinct(name, .keep_all = TRUE) %>% 
    group_by(led) %>% 
    summarise(avePrice = mean(price, na.rm = T), 
              aveRating = mean(averating, na.rm = T),
              NReviews = sum(nreviews)) %>% 
    filter(NReviews > 5) %>% 
    ggplot(aes(x = reorder(led, aveRating), y = aveRating, fill = led)) +
    geom_col() +
    geom_text(aes(label = round(aveRating, 1)), 
              colour = "white", 
              fontface = "bold", 
              hjust = 1.2, 
              vjust = 0.4, 
              size = 12) +
    coord_flip() +
    scale_fill_manual(values = c("#3300FF", "red", "#666666", "#FF33CC", "#33FF33", "#CCCCCC")) +
    guides(fill=FALSE) +
    labs(x = "", y = "") +
    theme(axis.text.x = element_blank(),
          axis.text.y = element_text(size = 16),
          axis.ticks = element_blank(),
          panel.grid.major = element_blank(),
          panel.grid.minor = element_blank(),
          panel.background = element_blank())