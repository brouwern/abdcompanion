library(readxl)

spreadsheet <- "~/1_R/git/git-courses_2018_2019/biostatistics_2018/BOOKS_in_prep/BOOK_Companion_to_Analysis_of_Bio_Data/06-frog_p_value.xlsx"

sheets <- excel_sheets(spreadsheet)

sheets.list <- as.list(sheets)

for(i in 1:length(sheets)){
  sheets.list[[i]] <- read_excel(spreadsheet, range = "A1:H20", 
                                 na = "NA",
                                 sheet = sheets[i])
}


save(sheets.list, file = "06-frog_p_value_raw.RData")


my.round <- function(x){
  if(is.numeric(x) == TRUE){round(x,3)}
  return(x)
  }


#round

for(i in 1:length(sheets.list)){
  
  for(j in 1:ncol(sheets.list[[i]])){
    sheets.list[[i]][,j] <- my.round(sheets.list[[i]][,j])
  }
}


#convert to character data
for(i in 1:length(sheets.list)){
  
  sheets.list[[i]] <- apply(sheets.list[[i]],2,as.character)
}



# convert NAs to ""
## <<ugly code alert>>
for(i in 1:length(sheets.list)){
  for(j in 1:ncol(sheets.list[[i]])){
    sheets.list[[i]][is.na(sheets.list[[i]][,j]),j] <- ""
  }
}

save(sheets.list, file = "06-frog_p_value_char.RData")
