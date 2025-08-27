# Matching two
library(tidyverse)
library(readxl)

finallist <- read_excel("/home/gam/workbench/EPA-2025-GW_Quality_Well_List_2025_Monitoring.xlsx", sheet = "GW_Quality_well list 2025-26") %>%
    filter(!(GOWN_NO %in% c("SUBTOTAL", NA)))
summary <- read_excel("/home/gam/workbench/Summary_DNP_sampling_target_2025.xlsx", sheet = "2025_Target") %>%
    rename(c('GOWN_NO' = 'gown_no', 'NAME' = 'COLLECTIONWELL_NAME' )) %>%
    mutate(GOWN_NO = as.character(GOWN_NO))
submittedlist <- read_excel("/home/gam/workbench/List.xlsx", sheet="Sheet1", col_names = FALSE)
colnames(submittedlist)<-c('GOWN_NO','NAME','office','Strouss','Planned')
submittedlist <- submittedlist %>%
    mutate(GOWN_NO = as.character(GOWN_NO),
        Strouss = as.character(Strouss)
    )

missedwells <- submittedlist %>%
    anti_join(finallist, by=c('GOWN_NO','NAME','Strouss')) %>%
    left_join(summary, by=c('GOWN_NO','NAME','office'))
write.csv(missedwells, "/home/gam/workbench/missedwells.csv")

missedwells <- missedwells %>%
    select(GOWN_NO,NAME,office,Lithology,Strouss,Planned,Latitude,Longitude)

