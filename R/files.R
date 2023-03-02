require(rJava)


#' Ensemble file handling functions
#'
#' @param filename
#' @param type "SQLite" (default) or "DSS" to determine what type of file to open
#' @param create.mode "append" (default), "new" which prevents opening an existing file, or "overwrite" which deletes existing and creates a new file
#'
#' @return Java object for ensemble file
#' @export
#'
#' @examples
openEnsemblesFile <- function(filename, type="SQLite", create.mode="append"){
  # TODO: create function for each file type and call from here
  if(type == "SQLite"){
    if(tolower(create.mode)=="overwrite" & file.exists(filename)){
      file.remove(filename)
    }
    jCreateMode = list("new"=J("hec.SqliteDatabase")$CREATION_MODE$CREATE_NEW, "overwrite"=J("hec.SqliteDatabase")$CREATION_MODE$CREATE_NEW, "append"=NULL)[create.mode]
    db = .jnew("hec/SqliteDatabase", ensembleFilename, J("hec.SqliteDatabase")$CREATION_MODE$CREATE_NEW)

    return(db)
  } else {
    warning(sprintf("file type %s not currently supported", type))
  }
}

#' Ensemble file handling functions
#'
#' @param ensemblesFile java object
#'
#' @export
#'
#' @examples
closeEnsemblesFile <- function(ensemblesFile){
  ensemblesFile$close()
}

#' Title
#'
#' @param ensemblesFile
#'
#' @return
#' @export
#'
#' @examples
writeToEnsemblesFile <- function(ensemblesFile, object){
  ensemblesFile$write(obj)
}

#' Get catalog of records in file
#'
#' @param ensemblesFile
#'
#' @return data.frame of file catalog
#' @export
#'
#' @examples
getCatalog <- function(ensemblesFile){
  return(data.frame())
}


#' Manage records in file
#'
#' @param filename
#'
#' @return data.frame of locations in file
#' @export
#'
#' @examples
getRecords <- function(filename){
  return(data.frame())
}

#' Manages records in file
#'
#' @param filename
#' @param location
#' @param parameter
#'
#' @export
#'
#' @examples
addRecord <- function(filename, location, parameter){
  recordID = .jnew("hec/RecordIdentifier", location, parameter)
}

#' Manages records in a file
#'
#' Deletes records from within a file
#'
#' @param filename
#' @param location
#' @param parameter
#'
#' @return true if successful
#' @export
#'
#' @examples
deleteRecord <-function(filename, location, parameter){
 # TODO implement deleteRecord
}
