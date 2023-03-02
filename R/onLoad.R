.onLoad <- function(libname, pkgname){
  require(rJava)
  # TODO add dss jars if needed, javaHeclib.dll
  .jpackage(pkgname, nativeLibrary=TRUE, own.loader=TUE)
  # TODO: use .jnew("myClass", class.loader=.rJava.class.loader) to create objects
  packageStartupMessage("Successfully loaded FIRO-TSEnsembles jar")
}

testLoad <- function(){
  Sys.setenv(JAVA_HOME="C:/programs/jdk-11")
  require(rJava)
  .jinit()
  .jaddClassPath(Sys.glob("./inst/java/*.jar"))
  J("hec.SqliteDatabase")$CREATION_MODE$CREATE_NEW
}
