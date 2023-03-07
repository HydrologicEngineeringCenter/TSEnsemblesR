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
openEnsemblesFile <- function(filename, type="SQLite", mode="append"){
  # TODO: create function for each file type and call from here
  if(type == "SQLite"){
    if(tolower(mode)=="overwrite" & file.exists(filename)){
      file.remove(filename)
    }
    # append = create new or open existing
    # new = only create a new file
    # overwrite = create a new file, delete the old one first
    # open = only open, do not create new
    jMode = list("append"="CREATE_NEW_OR_OPEN_EXISTING_UPDATE",
                 "new"="CREATE_NEW",
                 "overwrite"="CREATE_NEW",
                 "open"="OPEN_EXISTING_UPDATE")
    file.mode = .jfield(J("hec.SqliteDatabase")$CREATION_MODE, name=jMode[[mode]], convert=FALSE)

    db = .jnew("hec/SqliteDatabase", filename, file.mode) # class.loader=.rJava.class.loader)
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

#' Ensemble file handling functions
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

#' Ensemble file handling functions
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
