.onLoad <- function(libname, pkgname){
  # TODO - Don't do this here!
  #Sys.setenv(JAVA_HOME="C:/programs/jdk-11")
  require(rJava)
  # TODO add dss jars if needed, javaHeclib.dll
  .jpackage(pkgname, nativeLibrary=FALSE, own.loader=FALSE,
            parameters="-Djava.io.tmpdir=C:\\Temp\\FIRO_TSEnsembles",
            morePaths=Sys.glob("./inst/java/*.jar"))
  #.jaddClassPath(Sys.glob("./inst/java/*.jar"))

  # Note: use "own.loader=TRUE" with .jnew("myClass", class.loader=.rJava.class.loader) to create objects
  # need to check if nativeLibrary changes with javaHeclib requirement?
  packageStartupMessage("Successfully loaded FIRO-TSEnsembles jar")
}

# this function exists to assist interactive debugging
testLoad <- function(){
  Sys.setenv(JAVA_HOME="C:/programs/jdk-11")
  require(rJava)
  .jinit()
  .jaddClassPath(Sys.glob("./inst/java/*.jar"))
  J("hec.SqliteDatabase")$CREATION_MODE$CREATE_NEW
}
