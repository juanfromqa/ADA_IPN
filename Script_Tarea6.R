system("defaults write org.R-project.R force.LANG en_US.UTF-8")
setwd("/Users/DirectorioDeTrabajo/")

DIR <- "/Users/DirectorioDeTrabajo/Descargas"

if( !dir.exists(DIR) ) {
	dir.create(file.path(DIR), recursive=TRUE) 
    print("Se ha creado la carpeta de descargas para los archivos .CSV")
  } else {
  	print("La carpeta de descargas ya existe!")
  }

FILES <- list.files(path=DIR, pattern="*.csv")

