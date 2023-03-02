.onLoad <- function(libname, pkgname){
  require(rJava)

  Sys.setenv(JAVA_HOME=scriptConfig$java_config$java_home)

  # TODO add dss jars if needed, javaHeclib.dll
  .jpackage(pkgname, jars="FIRO_TSEnsembles-1.0.1.jar", nativeLibrary=TRUE, own.loader=TRUE)
  # TODO: use .jnew("myClass", class.loader=.rJava.class.loader) to create objects
  packageStartupMessage("Successfully loaded FIRO-TSEnsembles jar")
}
