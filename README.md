# ADA_IPN
Repositorio que contiene archivos y proyectos de la materia Almacenamiento de datos y su administración, especificamente de la tarea número 6, la cual consiste en lo siguiente:

1.- Crear un script en el lenguaje R que realice lo siguiente:
  
   -Cargar paquetes necesarios para realizar un análisis y exploración de datos de la información publicada en la liga                        https://www.ncdc.noaa.gov/ acerca de los datos de Clima severo (tormentas), en este caso, para las fatalidades causadas por esta           situación durante una decada específica. 
   -Establecer el directorio de trabajo.
   -Validar la existencia y crear un directorio de descarga.
   -El script contará con la lista de los nombres de archivos a trabajar. Si el archivo no está presente en el directorio de datos deberá    buscarse en el directorio de descarga, si no está presente deberá descargarse.
   -Una vez descargado el archivo, y ya presente en el sistema deberá descompactarse dejando el archivo de datos en el directorio             apropiado.
   -Una vez con todos los archivos presentes, se leerán todos los archivos, mostrando por cada uno el número de registros y estos            archivos se fusionarán en una sola estructura de datos. Para esto último es necesario considerar lo siguiente:
   
      -Si la intención es que este script pueda ser ejecutado varias veces, es importante que la estructura de datos sea                          limpiada en cada ejecución.
                
      -La lectura de los archivos debe considerar dos casos: La lectura inicial, en la que la estructura es inicialmente                          llenada con la lectura del primer archivo. 
      -Las lectura subsecuentes.
    -Desplegar  el número de registros del data frame creado,  que deberá ser la suma de los registros de cada archivo

