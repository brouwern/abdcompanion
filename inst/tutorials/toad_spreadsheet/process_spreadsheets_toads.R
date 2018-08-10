
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




#convert to character data
sheets.list.char <- sheets.list
for(i in 1:length(sheets.list.char)){

  sheets.list.char[[i]] <- apply(sheets.list.char[[i]],2,as.character)
}



# convert NAs to ""
## <<ugly code alert>>
for(i in 1:length(sheets.list.char)){
  for(j in 1:ncol(sheets.list.char[[i]])){
    sheets.list.char[[i]][is.na(sheets.list.char[[i]][,j]),j] <- " "
  }
}



for(i in 1:length(sheets.list.char)){
  #extract column names
  col.names <- colnames(sheets.list.char[[i]])

  # add ** to make bold
  col.names <- paste("**",col.names,"**",sep = "")

  # make letters
  column.ids <- toupper(letters[1:ncol(sheets.list.char[[i]])])
  colnames(sheets.list.char[[i]]) <- column.ids

  sheets.list.char[[i]] <- rbind(col.names,
                                 sheets.list.char[[i]])

  row.ids <- c(1:nrow(sheets.list.char[[i]]))
  sheets.list.char[[i]] <- cbind(row.ids,sheets.list.char[[i]])

  colnames(sheets.list.char[[i]])[1] <- ""

  rownames(sheets.list.char[[i]]) <-NULL
}


sheets.list.char[[1]]


sheets.list <- sheets.list.char

save(sheets.list, file = "./inst/tutorials/toad_spreadsheet/toad_as_character.RData")
