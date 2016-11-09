##### Tarea 6: Elementos intermedios de R
##### Juan Hernández Sánchez
##### 9 de noviembre de 2016

Objetivo
--------

El objetivo de esta tarea es familiarizar al alumno de la materia
'Almacenamiento de datos y su administración' con las acciones de
automatización de adquisición de datos en R como una base metódica en la
búsqueda de reproducibilidad de resultados y replicabilidad de acciones
relacionadas con el análisis de datos.

Actividades a realizar
----------------------

La especificación de las actividades se encuentran en el siguiente
enlace: <https://eravilaipnada.wordpress.com/home/organizacion/tarea-6/>
y se resumen a continuación:

##### Crear un script en el lenguaje R que realice lo siguiente:

-   Cargar paquetes necesarios para realizar un análisis y exploración
    de datos de la información publicada en la liga
    <https://www.ncdc.noaa.gov/> acerca de los datos de Clima severo
    (tormentas), en este caso, para las fatalidades causadas por esta
    situación durante una decada específica.

    -   Establecer el directorio de trabajo.

    -   Validar la existencia y crear un directorio de descarga.

    -   El script contará con la lista de los nombres de archivos
        a trabajar. Si el archivo no está presente en el directorio de
        datos deberá buscarse en el directorio de descarga, si no está
        presente deberá descargarse.

    -   Una vez descargado el archivo, y ya presente en el sistema
        deberá descompactarse dejando el archivo de datos en el
        directorio apropiado.

    -   Una vez con todos los archivos presentes, se leerán todos los
        archivos, mostrando por cada uno el número de registros y estos
        archivos se fusionarán en una sola estructura de datos. Para
        esto último es necesario considerar lo siguiente:

        -   Si la intención es que este script pueda ser ejecutado
            varias veces, es importante que la estructura de datos sea
            limpiada en cada ejecución.

        -   La lectura de los archivos debe considerar dos casos:
            -   **La lectura inicial**: En la que la estructura es
                inicialmente llenada con la lectura del primer archivo.
            -   **Las lectura subsecuentes**: Se deben desplegar el
                número de registros del data frame creado, que deberá
                ser la **suma de los registros** de cada archivo.

Ejecución de comandos para obtener los resultados deseados
----------------------------------------------------------

A continuación se presentan los pasos a realizar y su resultado para
llegar al objetivo de esta tarea.

**Nota:** Para poder ejecutar el código que se presenta a partir de
aqui, se debe tener en cuenta que el usuario del sistema operativo donde
se ejecute debe contar con permisos de administrador, esto es, para
ambientes Windows, el programa R se deberá ejecutar como Administrador,
mientras que para ambientes Unix como es el caso de OS X se deberá
ejecutar previamente la siguiente instrucción en una terminal: *sudo
chmod -R 777 /Users*

### Forzar el uso de la codificación UTF-8

Para evitar errores en la lectura de caracteres que no se encuentren en
el codigo ASCII, se forza a **R** para que utilice la codificación UTF-8
con la siguiente línea:

    system("defaults write org.R-project.R force.LANG en_US.UTF-8")

### Declaración de constantes

A continuación se agregan las variables que se van a utilizar a lo largo
del script y que permitirán ahorrar líneas de código para tener una
mejor lectura del mismo.

*Este fragmento de código está oculto para este reporte.*

### Instalación de paquetes

Se valida a continuación que los paquetes *util* y *R.util* se
encuentren cargados en la sesión, de no ser el caso, se procede a
descargarlos e instalarlos,se considera al paquete R.utils debido a que
contiene la función **gunzip()** que más adelante se utilizará:

    for (package in PACKAGES ) {
      if (!require(package, character.only=T, quietly=T)) {
         install.packages(package, repos="https://cran.itam.mx/")
         library(package, character.only=T)
      }else{ print('El paquete se encuentra cargado')}
    }

### Validar si existe el directorio de trabajo

Se verifica que el directorio de trabajo no exista para proceder a
crearlo, si ya se encuentra disponible, se selecciona como directorio de
trabajo.

    if( !dir.exists(wd) ) {
        dir.create(file.path(wd), recursive=TRUE) 
        print("Directorio de trabajo creado correctamente")
        setwd(wd)
      } else {
        print("Ya existe el directorio de trabajo")
        setwd(wd)
      }

### Validar la existencia de la carpeta Descargas

Se verifica que en el Directorio de trabajo se encuentre una carpeta
llamada *Descargas*, en la que se depositarán los archivos **.gz**
descargados de la página <https://www.ncdc.noaa.gov/>

    if( !dir.exists(Descargas) ) {
      dir.create(file.path(Descargas), recursive=TRUE) 
      print('Se ha creado la carpeta Descargas')
     }else{
        print('Ya existe la carpeta Descargas')
      }

### Validar la existena de la carpeta Archivos

Se verifica que en el Directorio de trabajo se encuentre una carpeta
llamada *Archivos*, en la que se depositarán los archivos
descomprimidos, es decir, aquí se encontrarán los ficheros **.csv** con
los que se trabajará para obtener la información solicitada:

    if( !dir.exists(Archivos) ) {
      dir.create(file.path(Archivos), recursive=TRUE) 
      print('Se ha creado la carpeta Archivos')
    }else{
       print('Ya existe la carpeta Archivos')
     } 

### Crear vector con los archivos .csv

Se crea un vector con los nombres de los archivos, el cual servirá para
recolectar la información necesaria de cada uno de ellos.

    FILES = c(file1,file2,file3,file4,file5,file6,file7,file8,file9,file10)

### Descargar y descomprimir archivos

Con el siguiente código se realizan estas tareas:

-   Se valida si el archivo descompactado ya existe en la carpeta
    *Archivos*, si no existe se busca el archivo compactado en la
    carpeta *Descargas*.
-   Si no existe en la carpeta de *Descargas*, se procede a descargar el
    archivo de la fuente de datos en línea.
-   Al finalizar el ciclo que recorre el vector con el nombre de los
    archivos, se descomprimen aquellos archivos que fueron descargados.
-   Si el archivo buscado ya se encuentra en la carepta *Descargas*,
    sólo se descomprime en la carpeta *Archivos*:

<!-- -->

    for (file in FILES) {
        setwd(Archivos)
        if (!file.exists(file)) {
         
            setwd(Descargas)
            fileExt <- paste(file, extension, sep = "")
            print('El archivo .csv no existe, se busca en Descargas')
            
            if (!file.exists(fileExt) && !fileExt == "") {
                print('El archivo .gz no existe en Descargas, se procede a obtenerlo del repositorio en linea')
                fileLink <- paste(rutaDescarga, fileExt, sep = "")
                rutaGunzip <- paste(Descargas, fileExt, sep = "")
                rutaArchivoDescargado <- paste(Descargas, fileExt, sep = "")
                download.file(fileLink, rutaArchivoDescargado)
                archivosParaDescomprimir <-TRUE
            } else {
                print('El archivo .gz si existe en Descargas, se descomprime en Archivos')
                setwd(Descargas)
                rutaGunzip <- paste(Archivos, file, sep = "")
                gunzip(fileExt, rutaGunzip, overwrite = FALSE, remove = FALSE)
            }
        }
    }
    if (archivosParaDescomprimir) {
        print('Existen archivos para descomprimir, se procede con la extracción en la carpeta Archivos')
        setwd(Descargas)
        for (file in FILES) {
            fileExt <- paste(file, extension, sep = "")
            rutaGunzip <- paste(Archivos, file, sep = "")
            gunzip(fileExt, rutaGunzip, overwrite = FALSE, remove = FALSE)
        }
    }

### Explotación de datos

Una vez que se cuenta con los archivos obtenidos, se procede a trabajar
con los datos de los archivos **.csv**, en primer lugar se presenta la
cantidad de registros de cada archivo:

    setwd(Archivos)
    for( file in FILES ){
      print(nrow(read.csv(file, header = TRUE, sep = ",")))
    }

### Union de los datos en un solo Data frame

Al contar con los archivos dentro de un vector, se procede a unir todos
los registros dentro de una sola trama de datos:

    setwd(Archivos)
    for( file in FILES ){
        if( !exists("Fatalities" ) ) {
            Fatalities<-read.csv( file, header=T, sep=",", na.strings="")
        } else {
            data<-read.csv(file, header=T, sep=",", na.strings="")
            Fatalities<-rbind(Fatalities,data)
        }
    }

### Resultado

El número total de muertes a causa de tormentas en Estados unidos entre
los años 1985 y 1994 (de acuerdo a los archivos seleccionados del
repositorio) fueron:

    print(nrow(Fatalities))

A continuación se presenta un resumen de los datos obtenidos:

    summary(Fatalities)

### Limpieza

Se eliminan las variables temporales para no acumular los valores si es
que el código es ejecutado nuevamente.

    rm(Fatalities)
    rm(data)
    
**NOTA:**
El archivo README.Rmd contiene el script listo para ser ejecutado, se agrega también este archivo de manera informativa.

