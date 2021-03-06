
#-----------------------------------------------------------------------------------#
# Haggard et al. "High -throughput H295R steroidogenesis assay: utility as an
# alternative and a statistical approach to characterize effects on steroidogenesis"


#This script generates formatted data including Agnes' and the new H295R data for OECD manuscript


rm(list=ls())

library(data.table)
library(reshape2)
library(stringr)
library(tcpl)

#######################
##Load in Agnes' Data##
#######################

setwd("L:/Lab/ToxCast_Data/toxcast_data/files/ceetox/Conc Response")

#-----Make a place holder hold all data
adat <- list()

#-----Process TO2 (Phase 1 - 96 chems)
data.files <- list.files(file.path("RawData_CR_TO2/DH_correctedData"), pattern = ".csv",
                         full.names = TRUE)

datlist <- lapply(data.files, fread, header = TRUE, nrows = 56, select = 1:14)
datlist <- lapply(1:length(datlist),
                  function(x) datlist[[x]][ , srcf := basename(data.files)[x]])
dat <- rbindlist(datlist)
setnames(dat, "Sample Name", "sample_name")

dat <- melt.data.table(dat,
                       id.vars = c("sample_name", "srcf"),
                       variable.name = "acsn",
                       value.name = "rval")
dat[] <- lapply(dat, function(x) gsub("^\\s+|\\s+$", "", x))

dat[ , ceetox_raw := rval]
dat[ , acsn := paste0("CEETOX_H295R_", acsn)]

sample_info <- strsplit(dat$sample_name, split = " ", fixed = TRUE)

dat$apid <- paste(sapply(sample_info, "[", 1), "Plate",
                  sapply(sample_info, "[", 3), sep = ".")

dat$well <- sapply(sample_info, "[", 4)
dat[ , rowi := match(sub('[0-9]+', "", well), LETTERS)]
dat[ , coli := as.integer(sub('[A-Z]', "", well))]

dat$spid <- sapply(sample_info, "[", 5)

dat[ , conc_index := sapply(sample_info, "[", 6)]

adat <- rbindlist(list(adat, dat))

rm(list = ls()[!ls() %in% c("adat")])

#-----Process TO3 (Phase 2 - 345 chems)
data.files <- list.files(file.path("RawData_CR_345"),
                         pattern = ".csv", full.names = TRUE)

datlist <- lapply(data.files, fread, header = TRUE, nrows = 54, select = 1:14)
datlist <- lapply(1:length(datlist),
                  function(x) datlist[[x]][ , srcf := basename(data.files)[x]])
dat <- rbindlist(datlist)
setnames(dat, "Sample Name", "sample_name")

dat <- melt.data.table(dat,
                       id.vars = c("sample_name", "srcf"),
                       variable.name = "acsn",
                       value.name = "rval")
dat[] <- lapply(dat, function(x) gsub("^\\s+|\\s+$", "", x))

dat[ , ceetox_raw := rval]
dat[ , acsn := paste0("CEETOX_H295R_", acsn)]

sample_info <- strsplit(dat$sample_name, split = " ", fixed = TRUE)

dat$apid <- paste(sapply(sample_info, "[", 1), "Plate",
                  sapply(sample_info, "[", 3), sep = ".")

dat$well <- sapply(sample_info, "[", 4)
dat[ , rowi := match(sub('[0-9]+', "", well), LETTERS)]
dat[ , coli := as.integer(sub('[A-Z]', "", well))]

dat$spid <- sapply(sample_info, "[", 5)

dat[ , conc_index := sapply(sample_info, "[", 7)]

adat <- rbindlist(list(adat, dat))

rm(list = ls()[!ls() %in% c("adat", "data.dir")])

#-----Process TO3 (Phase 3/e1k - 86 chems)
data.files <- list.files(file.path("RawData_CR_86"),
                         pattern = ".csv", full.names = TRUE)

datlist <- lapply(data.files, fread, header = TRUE, nrows = 54, select = 1:14)
datlist <- lapply(1:length(datlist),
                  function(x) datlist[[x]][ , srcf := basename(data.files)[x]])
dat <- rbindlist(datlist)
setnames(dat, "Sample Name", "sample_name")

dat <- melt.data.table(dat,
                       id.vars = c("sample_name", "srcf"),
                       variable.name = "acsn",
                       value.name = "rval")
dat[] <- lapply(dat, function(x) gsub("^\\s+|\\s+$", "", x))

dat[ , ceetox_raw := rval]
dat[ , acsn := paste0("CEETOX_H295R_", acsn)]

sample_info <- strsplit(dat$sample_name, split = " ", fixed = TRUE)

dat$apid <- paste(sapply(strsplit(dat$srcf, " "), "[", 8), "Plate",
                  sapply(sample_info, "[", 2), sep = ".")

dat$well <- sapply(sample_info, "[", 3)
dat[ , rowi := match(sub('[0-9]+', "", well), LETTERS)]
dat[ , coli := as.integer(sub('[A-Z]', "", well))]

dat$spid <- sapply(sample_info, "[", 4)

dat[ , conc_index := sapply(sample_info, "[", 6)]

adat <- rbindlist(list(adat, dat))

rm(list = ls()[!ls() %in% c("adat", "data.dir")])

#-----Process TO3 (Final 165 chems)
data.files <- list.files(file.path("RawData_CR_165"),
                         pattern = ".csv", full.names = TRUE)

datlist <- lapply(data.files, fread, header = TRUE, nrows = 54, select = 1:14)
datlist <- lapply(1:length(datlist),
                  function(x) datlist[[x]][ , srcf := basename(data.files)[x]])
dat <- rbindlist(datlist)
setnames(dat, "Sample Name", "sample_name")

dat <- melt.data.table(dat,
                       id.vars = c("sample_name", "srcf"),
                       variable.name = "acsn",
                       value.name = "rval")
dat[] <- lapply(dat, function(x) gsub("^\\s+|\\s+$", "", x))

dat[ , ceetox_raw := rval]
dat[ , acsn := paste0("CEETOX_H295R_", acsn)]

sample_info <- strsplit(dat$sample_name, split = " ", fixed = TRUE)

dat$apid <- paste(sapply(strsplit(dat$srcf, " "), "[", 4), "Plate",
                  sapply(sample_info, "[", 2), sep = ".")

dat$well <- sapply(sample_info, "[", 3)
dat[ , rowi := match(sub('[0-9]+', "", well), LETTERS)]
dat[ , coli := as.integer(sub('[A-Z]', "", well))]

dat$spid <- sapply(sample_info, "[", 4)

dat[ , conc_index := sapply(sample_info, "[", 6)]

adat <- rbindlist(list(adat, dat))

rm(list = ls()[!ls() %in% c("adat", "data.dir")])

#-----Add testing concentrations and clean-up annotation across all data
conc.map.files <- c("CEETOX_ConfirmedDoses_TO2_96chem.csv",
                    "CEETOX_ConfirmedDoses_TO3_431chem.csv",
                    "CEETOX_ConfirmedDoses_TO3_165chem.csv")
conc.map <- lapply(file.path(conc.map.files), fread, header = TRUE)
conc.map <- lapply(conc.map,
                   function(x) {
                     x[ , .SD, .SDcols = c("sample_id", paste0("CONC", 1:6))]
                   })
conc.map <- rbindlist(conc.map)
conc.map <- melt.data.table(conc.map,
                            value.name = "conc",
                            id.vars = "sample_id",
                            variable.name = "conc_index")
setnames(conc.map, "sample_id", "spid")
conc.map <- conc.map[ , list(conc = min(conc)), by = list(spid, conc_index)]

#clean up conc_index
adat[ , conc_index := gsub(".d", "", conc_index)]
adat[ , conc_index := gsub("r","",conc_index)]

setkeyv(conc.map, c("spid", "conc_index"))
setkeyv(adat, c("spid", "conc_index"))
adat <- conc.map[adat]

#clean up control naming and well type for control wells
adat[spid %in% conc.map$spid, wllt := "t"]
adat[spid %in% c("VC.d", "VCr", "VC", "DMSO"), c("spid", "wllt") := list("DMSO", "n")]
adat[spid %in% c("PRO", "3", "P"), c("spid", "wllt") := list("PRO", "m")]
adat[spid %in% c("FOR", "10", "F"), c("spid", "wllt") := list("FOR", "p")]

#add concentrations for controls (make DMSO 0)
adat[spid == "DMSO", conc := 0.0]
adat[spid == "PRO", conc := 3]
adat[spid == "FOR", conc := 10]

## add descriptors for values that had qualifiers
adat[ , lower.limit := grepl("\\(", ceetox_raw)]
adat[ , upper.limit := grepl("\\[", ceetox_raw)]
adat[ , not.detected := grepl('[A-Z]', ceetox_raw) | is.na(ceetox_raw)]
adat[ , interference := grepl("\\{", ceetox_raw)]
adat[ , suppression := grepl('[:*:]', ceetox_raw)]
## ( )  Result Estimate ? Lower Limit of Quantification
## [ ]  Result Estimate > Upper Limit of Quantification
## ND  Not Detected
## NR  Not Reportable due to Sample Error
## NQ  Not Quatifiable (below limit)
## { }	Interference detected in analyte chromatogram
## *	Internal standard suppression detected OR analyte interference
## -	Result Estimate ? Lower Limit of Quantification


## accept all data except that which was NOT DETECTED or NOT QUANTIFIABLE
adat[ , wllq := 1]
#adat[which(not.detected), wllq := 0]

## set rval as numeric and remove any qualifier notations
adat[ , rval := as.numeric(gsub("[^0-9.]", "", ceetox_raw))]
adat[ , rval := (gsub("[^0-9.,A-Z.]", "", ceetox_raw))] #retain NR, ND, and NQ data
adat[is.na(rval), rval := NA] #make all NR to NA
adat[is.na(rval), wllq := 0] ##fix wllq to reflect change in ND and NQ values

#-----fix the legacy spids with the new spids
load("C:/Users/dhaggard/Desktop/H295R Project/Woody Code/CeeToxCRData.RData") #Woody's RData file has the legacy spids mapped
dat0 <- as.data.table(dat0)

dat0 <- dat0[order(spid_legacy),]
adat <- adat[order(spid),]

adat[spid %in% dat0[,spid_legacy], spid := dat0[,spid]]

#################################################
##Load in the new H295R data from Apr. 11, 2017##
#################################################

setwd("L:/Lab/Toxcast_Data/toxcast_data/files/ceetox/Conc Response/RawData_CYP1118_R11_TO3") #revise to L drive later

#-----Read in data files
data_dir <- "L:/Lab/Toxcast_Data/toxcast_data/files/ceetox/Conc Response/RawData_CYP1118_R11_TO3/CR Formatted Data"

data_file_list <- list.files(path = data_dir, pattern = ".txt", full.names = TRUE)

datlist <- lapply(data_file_list, fread, header = TRUE, nrows = 56, select = 1:14)
datlist <- lapply(1:length(datlist),
                  function(x) datlist[[x]][ , srcf := basename(data_file_list)[x]])

data_all <- rbindlist(datlist) #rbinds the list into a data.table

setnames(data_all, "Sample Name", "sample_name")

#-----convert from wide to long format
data_all_long <- melt.data.table(data = data_all, id.vars = c("sample_name", "srcf"),
                                 variable.name = "acsn", value.name = "rval")

#-----remove any hidden white spaces
data_all_long[] <- lapply(data_all_long, function(x) gsub("^\\s+|\\s+$", "", x))

#-----assign some tcpl-relevant columns
data_all_long[ , ceetox_raw := rval]
data_all_long[ , acsn := paste0("CEETOX_H295R_", acsn, "_noMTC")]

sample_info <- strsplit(data_all_long$sample_name, split = " ", fixed = TRUE)

data_all_long$apid <- paste("04112017", "Plate",
                            sapply(sample_info, "[", 2), sep = ".")

data_all_long$well <- sapply(sample_info, "[", 3)

data_all_long[,coli := str_replace(data_all_long$well, "[A-Z]", "")]
data_all_long[,rowi := match(str_replace_all(data_all_long$well, "[0-9]", ""), LETTERS)]

data_all_long$spid <- sapply(sample_info, "[", 4)

#-----add control spids
data_all_long[spid == "VC", spid := "DMSO"]
data_all_long[spid == "3", spid := "PRO"]
data_all_long[spid == "10", spid := "FOR"]

data_all_long$conc_index <- sapply(sample_info, "[", 6)

# #clean up control conc index
# data_all_long[spid == "DMSO", conc_index := ]
# data_all_long[spid == "FOR", conc_index := 10]
# data_all_long[spid == "PRO", conc_index := "Prochloraz"]

#-----add control concs
data_all_long[spid == "DMSO", conc := 0.0]
data_all_long[spid == "FOR", conc := 10]
data_all_long[spid == "PRO", conc := 3]

#-----add well type info
data_all_long[, wllt := "t"]
data_all_long[spid == "DMSO", wllt := "n"]
data_all_long[spid == "FOR", wllt := "p"]
data_all_long[spid == "PRO", wllt := "m"]

#-----add descriptors for values that had qualifiers
data_all_long[ , lower.limit := grepl("\\(", ceetox_raw)]
data_all_long[ , upper.limit := grepl("\\[", ceetox_raw)]
data_all_long[ , not.detected := grepl('[A-Z]', ceetox_raw) | is.na(ceetox_raw)]
data_all_long[ , interference := grepl("\\{", ceetox_raw)]
data_all_long[ , suppression := grepl('[:*:]', ceetox_raw)]
## ( )  Result Estimate ? Lower Limit of Quantification
## [ ]  Result Estimate > Upper Limit of Quantification
## ND  Not Detected
## NR  Not Reportable due to Sample Error
## NQ  Not Quatifiable (below limit)
## { }	Interference detected in analyte chromatogram
## *	Internal standard suppression detected OR analyte interference
## -	Result Estimate ? Lower Limit of Quantification

#-----accept all data except that which was NOT DETECTED or NOT QUANTIFIABLE
data_all_long[ , wllq := 1]
#data_all_long[which(not.detected), wllq := 0]


#-----Fix the two spids that have missing MTT data
data_all_long[spid == "TP0001672B03" & rowi == 7 & coli == 7 | spid == "TP0001672D10" & rowi == 6 & coli == 11, c("rval", "ceetox_raw") := "NR"]

#-----set rval as numeric and remove any flag symbols
data_all_long[,rval := as.numeric(gsub("[^0-9.]", "", ceetox_raw))]
data_all_long[,rval := (gsub("[^0-9,A-Z.]", "", ceetox_raw))] #retain NR, ND, and NQ data
data_all_long[rval == "NR", rval:= NA] #make all NR to NA
data_all_long[is.na(rval), wllq := 0] #fix wllq to reflect change in ND and NQ values

#-----read in concentration map
conc_map <- fread("corrected_compound_concentrations_041717.txt")
conc_map$CONC1 <- as.numeric(conc_map$CONC1)

conc_map_long <- melt.data.table(data = conc_map, id.vars = c("Sample Name", "Stock_conc"), variable.name = "conc_index", value.name = "conc")

#-----add all conc values
for(x in unique(conc_map_long[, `Sample Name`])){
  for(y in unique(conc_map_long[,conc_index])){
    data_all_long[spid == x & conc_index == y, conc := conc_map_long[`Sample Name`==x & conc_index == y, conc]]
  }
}

#-----reorder rows according to Agnes' level 0 data
data_all_long <- data_all_long[,c("spid", "conc_index", "conc", "sample_name", "srcf", "acsn",
                                  "rval", "ceetox_raw", "apid", "well", "rowi", "coli", "wllt",
                                  "lower.limit", "upper.limit", "not.detected", "interference", "suppression", 
                                  "wllq")]


#####################################################################################################
##Combine Agnes' and the new H295R data, add, chemical names, add LLOQ/sqrt(2) for ND/NQ data, andconvert response to uM##
#####################################################################################################

setwd("L:/Lab/NCCT_ToxCast/Derik Haggard/OECD Analysis/R Project/Master Data Table")

dat0 <- rbind(adat, data_all_long)

dat0[, steroid := str_replace(acsn, "CEETOX_H295R_", "")]
dat0[, steroid := str_replace(steroid, "_noMTC", "")]

#-----geneate summary table of NR/ND/NQ percentage for each steroid

flag_stats <- matrix(data = 0, nrow = 5, ncol = 13)
flag_stats <- as.data.table(flag_stats)
colnames(flag_stats) <- unique(dat0[,steroid])
rownames(flag_stats) <- c("NR", "ND", "NQ", "Sum", "Total")

flag_data <- dat0[rval == "NR" | rval == "ND" | rval == "NQ",]
#flag_data <- flag_data[spid == "DMSO",]
flag_data <- dat0[spid != "FOR" & spid != "PRO" ]

x <- 1
for(y in unique(dat0[,steroid])){
  flag_stats[1, x] <- flag_data[steroid == y & rval == "NR", .N]
  flag_stats[2, x] <- flag_data[steroid == y & rval == "ND", .N]
  flag_stats[3, x] <- flag_data[steroid == y & rval == "NQ", .N]
  flag_stats[4, x] <- colSums(flag_stats[c(1:3), x, with = FALSE])
  flag_stats[5, x] <- flag_data[steroid == y, .N]
  x <- x + 1
}

fwrite(flag_stats, file = "H295R_flags_table_noPositiveControls.txt", sep = "\t", row.names = TRUE)

#-----remove NR data from analysis
dat0[rval == "NR", rval := NA]

dat0_filtered <- dat0[!is.na(rval),]

#-----generate LOQ and LOQuM tables
MW <- numeric(13)
names(MW) <- c("11-deoxycortisol", "Androstenedione", "Corticosterone", 
               "Cortisol", "DHEA", "DOC", "Estradiol", "Estrone", 
               "OH-Pregnenolone", "OH-Progesterone", "Pregnenolone",
               "Progesterone", "Testosterone")
MW["Pregnenolone"] <- 316.4776
MW["Progesterone"] <- 314.46
MW["DOC"] <- 330.4611
MW["Corticosterone"] <- 346.461
MW["OH-Pregnenolone"] <- 332.477
MW["OH-Progesterone"] <- 330.4611
MW["11-deoxycortisol"] <- 346.4605
MW["Cortisol"] <- 362.460
MW["DHEA"] <- 288.424
MW["Androstenedione"] <- 286.409
MW["Estrone"] <- 270.366
MW["Testosterone"] <- 288.424
MW["Estradiol"] <- 272.382

LOQ <- data.frame(acsn = sort(unique(names(MW))),
                  LLOQ = numeric(13),
                  ULOQ = numeric(13))

LOQ[1,2:3] <- c(5,1000)
LOQ[2,2:3] <- c(1,200)
LOQ[3,2:3] <- c(0.5,100)
LOQ[4,2:3] <- c(0.5,100)
LOQ[5,2:3] <- c(3,600)
LOQ[6,2:3] <- c(0.5,100)
LOQ[7,2:3] <- c(0.03,6)
LOQ[8,2:3] <- c(0.03,6)
LOQ[9,2:3] <- c(5,1000)
LOQ[10,2:3] <- c(0.2,40)
LOQ[11,2:3] <- c(2,400)
LOQ[12,2:3] <- c(0.2,40)
LOQ[13,2:3] <- c(0.1,20)

#-----convert to uM
LOQuM <- LOQ[2:3]
rownames(LOQuM) <- as.character(LOQ$acsn)
LOQuM <- as.data.table(sweep(LOQuM, 1, 1/MW, "*")) #data with no detection will be LOQuM/sqrt(2)
rownames(LOQuM) <- sort(unique(names(MW)))

LOQ <- data.table(LOQ)

#-----Convert any non-detect rval to LLOQ/sqrt(2), regardless of treatment

dat0_filtered[,rval := str_replace(rval, ",", "")]
dat0_filtered[,rval := as.numeric(rval)] #convert ND and NQ to NA for easier manipulation

for(x in unique(dat0_filtered[,steroid])){
  dat0_filtered[steroid == x & is.na(rval) == TRUE, rval := LOQ[acsn == x, LLOQ]/sqrt(2)]
}

#-----Generate uM data
for(x in unique(dat0_filtered[,steroid])){
  dat0_filtered[steroid == x, uM := rval/MW[x]]
}

#-----add chemical names and cas no.

chems <- tcplLoadChem(field = "spid", val = unique(dat0_filtered[spid != "DMSO" & spid != "FOR" & spid != "PRO",spid]))

for(x in unique(chems[,spid])){
  dat0_filtered[spid == x, c("chnm", "casn") := .(chems[spid == x, chnm], chems[spid == x, casn])]
}

#-----clean up the data
dat0_filtered <- dat0_filtered[spid != "FOR" & spid != "PRO",] #remove neg and pos controls

#OPTIONAL: level 0 data for tcpl
acids <- tcplLoadAcid("asid",8)
out_cols <- c("spid", "conc", "srcf", "acid", "rval", "apid",
              "wllt", "rowi", "wllq", "coli")

dat0_combined <- dat0_filtered[, out_cols, with = FALSE]

dat0_combined <- dat0_filtered[,c(1, 22, 23, 9, 6, 20, 2, 3, 11:13, 8, 7, 21),]

#-----Load in level 3 MTT data and filter based on 70% viability or wllt == 0
acid <- 1017
aeid <- tcplLoadAeid(fld = "acid", acid) #1633 is the aeid we want

H295R_MTT_mc3 <- tcplPrepOtpt(tcplLoadData(lvl = 3L, fld = "aeid", val = 1663, type = "mc"))

H295R_MTT_mc3_filtered <- H295R_MTT_mc3[wllt == "t" & resp <= 30,]

#H295R_MTT_mc3_filtered <- H295R_MTT_mc3[wllt == "t" & resp >= 30,]


#use spid_rowi_coli to remove data with viability problems
H295R_MTT_mc3_filtered[, spid_rowi_coli := paste(spid, rowi, coli, sep = "_")]

#-----filter dat0_combined on viability
dat0_combined[, spid_rowi_coli := paste(spid, rowi, coli, sep = "_")] #define key to filter

dat0_combined <- dat0_combined[spid_rowi_coli %in% unique(H295R_MTT_mc3_filtered[, spid_rowi_coli]) | spid == "DMSO",] 

dat0_combined <- dat0_combined[,-15]

#-----remove colchicine, digoxigenin, bad DINP replicate sample, and bad DMSO samples (plate with bad viability data)
dat0_combined <- dat0_combined[spid != "TP0001057A09" | spid == "DMSO",]
dat0_combined <- dat0_combined[spid != "TP0001672H10" | spid == "DMSO",]
dat0_combined <- dat0_combined[apid != "20130320.Plate.1"] #remove plate DMSO values for bad viability plate
dat0_combined <- dat0_combined[!c(chnm == "DINP branched" & conc_index == "CONC4" & rowi == 5 & coli == 4),]

#-----save the data
save(dat0_combined, file = paste0("../RData/H295R_master_table_", Sys.Date(), ".RData"))
fwrite(dat0_combined, file = paste0("H295R_master_table_", Sys.Date(), ".txt"), sep = "\t")








