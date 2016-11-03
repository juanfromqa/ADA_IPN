system("defaults write org.R-project.R force.LANG en_US.UTF-8")
#Para MAC: /Users/DirectorioDeTrabajo
#Para Windows: C:/Users/juan.hernandez/DirectorioDeTrabajo
#Declaración de constantes
wd <- "C:/Users/juan.hernandez/DirectorioDeTrabajo"
Descargas <- "C:/Users/juan.hernandez/DirectorioDeTrabajo/Descargas"
Archivos <- "C:/Users/juan.hernandez/DirectorioDeTrabajo/Archivos"
extension=".gz"
rutaDescarga="http://www1.ncdc.noaa.gov/pub/data/swdi/stormevents/csvfiles/"
file1="StormEvents_fatalities-ftp_v1.0_d1985_c20160223.csv"
file2="StormEvents_fatalities-ftp_v1.0_d1986_c20160223.csv"
file3="StormEvents_fatalities-ftp_v1.0_d1987_c20160223.csv"
file4="StormEvents_fatalities-ftp_v1.0_d1988_c20160223.csv"
file5="StormEvents_fatalities-ftp_v1.0_d1989_c20160223.csv"
file6="StormEvents_fatalities-ftp_v1.0_d1990_c20160223.csv"
file7="StormEvents_fatalities-ftp_v1.0_d1991_c20160223.csv"
file8="StormEvents_fatalities-ftp_v1.0_d1992_c20160223.csv"
file9="StormEvents_fatalities-ftp_v1.0_d1993_c20160223.csv"
file10="StormEvents_fatalities-ftp_v1.0_d1994_c20160223.csv"
fileExt <- ""

#Validar si existe el directorio de trabajo
if( !dir.exists(wd) ) {
	dir.create(file.path(wd), recursive=TRUE) 
    setwd(wd)
  	print("Se ha creado y establecido el directorio de trabajo correctamente.")
  } else {
  	setwd(wd)
  	print("Se ha establecido el directorio de trabajo correctamente.")
  }
#Validar si existe la carpeta de descargas donde se guardarán los archivos comprimidos
if( !dir.exists(Descargas) ) {
	dir.create(file.path(Descargas), recursive=TRUE) 
    print("Se ha creado la carpeta de descargas para los archivos .GZ")
  } else {
  	print("La carpeta de descargas ya existe!")
  }
#Validar si existe la carpeta de los archivos csv
if( !dir.exists(Archivos) ) {
	dir.create(file.path(Archivos), recursive=TRUE) 
    print("Se ha creado la carpeta de archivos de datos para los archivos .CSV")
 } else {
  	print("La carpeta de archivos de datos ya existe!")
 }

#Validación de la existencia de los archivos en las carpetas locales
FILES = c(file1,file2,file3,file4,file5,file6,file7,file8,file9,file10)
fileExt<-""
for( file in FILES ){
  # Se valida si el archivo descompactado ya existe en el área de datos.
  setwd(Archivos)
   if( ! file.exists( file )) {
    # Si no existe se busca el archivo compactado en el área de descarga.
    	print("No existe en la carpeta de archivos")
    	print("Buscando en descargas")
   		setwd(Descargas)
   		fileExt <- paste(file,extension,sep="")
   		if( ! file.exists( fileExt ) && !fileExt=="") {
	    # Si no existe se busca el archivo compactado en el área de descarga.
	    	print("No existe en la carpeta de Descargas")
	    	print("Hay que descargar el archivo:")
	   		fileLink <- paste(rutaDescarga,fileExt,sep="")
	   		print(fileLink)
	    } else {
		   	 print("si existe el archivo en la carpeta de descargas")
		   	 print(fileExt)
		   	 setwd(Descargas)
		   	 print("Se descomprime el archivo")
		   	 gzfile(fileExt)
	   }
   } else {
   	 print("si existe el archivo en la carpeta de archivos")
   	 print(file)
   }
}
