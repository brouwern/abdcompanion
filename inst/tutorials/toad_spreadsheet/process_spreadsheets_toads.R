
# Set upd spread sheets

library(readxl)
library(here)

file.<- "toad_hypothesis_test_XLSX.xlsx"
spreadsheet.path <- here::here("inst/tutorials/toad_spreadsheet",
                               file.)

#get names of sheets
sheet.names <- excel_sheets(spreadsheet.path)

#turn into list
sheets.list <- as.list(sheet.names)

#load sheets into list
## each sheet in seperate list element
for(i in 1:length(sheets.list)){
  sheets.list[[i]] <- read_excel(spreadsheet.path,
                                 range = "A1:H20",
                                 na = "NA",
                                 sheet = sheet.names[i])

  sheets.list[[i]] <- data.frame(sheets.list[[i]])
}


# save .RData w/ spreadsheets
save(sheets.list, file = "toads_raw.RData")

#function to round data
my.round <- function(x){
  if(is.numeric(x) == TRUE){
    x <- round(x,3)
    }
  return(x)
  }



# round numeric values
## nest for loops over list elements and columns w/in each list element
for(i in 1:length(sheets.list)){

  for(j in 1:ncol(sheets.list[[i]])){
    sheets.list[[i]][,j] <- my.round(sheets.list[[i]][,j])
  }
}

sheets.list[[i]][,j]


#convert to character data
for(i in 1:length(sheets.list)){

  sheets.list[[i]] <- apply(sheets.list[[i]],2,as.character)
}



# convert NAs to ""
## <<ugly code alert>>
for(i in 1:length(sheets.list)){
  for(j in 1:ncol(sheets.list[[i]])){
    sheets.list[[i]][is.na(sheets.list[[i]][,j]),j] <- " "
  }
}

save(sheets.list, file = "./inst/tutorials/toad_spreadsheet/toad_as_character.RData")
