#lo primero guardamos la hora en el log:
$ruta=$pwd.path
$hora=get-date
set-Content "$ruta\log.txt" "$hora"


#hacemos la lista de los que hemos descargado de su FTP y excluimos los que terminan en extension *._ o *.algo_ , ademas solo queremos los ficheros y no los directorios
$listaficheros = get-childitem -name -Recurse -include *.* -Exclude *.*_ -path $ruta\descargados_de_su_sistema\
 
#Una vez tenemos el listado de todos los ficheros que se han descargado del FTP, procedemos a compararlos con los locales
foreach ($fichero in $listaficheros)
{
#Reseteamos la variable de iguales=0 por cada fichero antes de compararlo
$iguales=0

#Metemos en una variable el comando que compara guardando el resultado en temp.txt y lo invocamos
$comando= "fc /b `"$ruta\descargados_de_su_sistema\$fichero`" `"$ruta\locales\$fichero`""
$comparado="cmd /c $comando > $ruta\temp.txt"
Invoke-Expression $comparado

#Leemos el resultado del comando, y buscamos en la salida del comando que haya tenido éxito, en caso positivo, ponemos la variable iguales=1 indicando que los ficheros son iguales, en caso de que la variable iguales siga siendo 0, es que la salida del comando no ha tenido el resultado adecuado y significa que el fichero es distinto.
$texto = Get-Content "$ruta\temp.txt"
foreach ($linea in $texto) { if ($linea -eq 'FC: no differences encountered') {$iguales=1} }

if ($iguales -eq 1) { 
write-host "$fichero correcto"
add-Content "$ruta\log.txt" "$fichero correcto" }

else { write-host "$fichero DISTINTO!!!!!" 
add-Content "$ruta\log.txt" "$fichero DISTINTO!!!!!" }

}
#Indicamos el fin de la comprobación tanto por pantalla como en el log.
write-host "Fin de la comprobacion"
add-Content "$ruta\log.txt" "Fin de la comprobacion"
