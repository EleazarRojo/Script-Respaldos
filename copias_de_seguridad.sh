#!/bin/bash

crearCopiaCompleta () {
    clear
    echo
    echo "Seleccionó la opción de Crear Copia de Seguridad Completa."
    echo
    echo -n "Escriba la dirección de origen (Dirección Absoluta): "
    read direccionOrigen
    
    fecha=$(date +%Y-%m-%d)

    fecha2=$(date +%Y-%m-%d-%H-%M-%S)
    direccionDestino="$HOME/backups/"

    sudo mkdir -p $direccionDestino
   
    cadena=${direccionOrigen//\//-}

    filename=backup-${cadena}-${fecha2}.tar.gz

    sudo tar -cvzpf $direccionDestino/${filename} $direccionOrigen

    echo "----------------------------------------"
    echo "Copia de seguridad creada con exito."
    echo "----------------------------------------"
   
}

crearCopiaIncremental () {
    clear
    echo
    echo "Seleccionó la opción de Crear Copia de Seguridad Incremental."
    echo
    echo -n "Escriba la dirección de origen (Dirección Absoluta): "
    read direccionOrigen
  
    fecha2=$(date +%Y-%m-%d-%H-%M-%S)

    direccionDestino="$HOME/backups"

    sudo mkdir -p ${direccionDestino}

    cadena=${direccionOrigen//\//-}

    contador=0


    filename=${cadena}-$fecha2-inc.tar.gz
   
    sudo tar -cvpzf ${direccionDestino}/${filename} -g ${direccionDestino}/snapshot.snar $direccionOrigen

    echo "----------------------------------------"
    echo "Copia de seguridad creada con exito."
    echo "----------------------------------------"


    
}

listarCopias () {
    clear
    echo
    echo "Seleccionó la opción de Listar Copias de Seguridad Creadas."
    echo
    echo "Las copias de seguridad creadas hasta el momento son:"
    cd $HOME/backups
    ls -l
    echo
    echo
}

eliminarCopia () {
    clear
    echo "Seleccionó la opción de eliminar copias de Seguridad"
    echo 
    echo
    echo "Directorio de back ups $HOME/backups"
    echo
    cd $HOME/backups
    ls -l
    echo
    echo "Ingrese el nombre de la copia de seguridad para eliminar"
    read nombre

    if [ -e $nombre ]
    then
    sudo rm -r $HOME/backups/$nombre

    echo "----------------------------------------"
    echo "Copia de seguridad eliminada con exito."
    echo "----------------------------------------"
    else
          echo "----------------------------------------"
        echo "Copia de seguridad no encontrada"
        echo "----------------------------------------"
    fi
}

while [ true ]
do
    echo
    echo "-------------------------------------------------------"
    echo "Bienvenido al Script Gestor de Copias de Seguridad"
    echo "-------------------------------------------------------"
    echo
    echo "Opciones Disponibles:"
    echo "1.- Crear una Copia de Seguridad Completa"
    echo "2.- Crear una Copia de Seguridad Incremental"
    echo "3.- Listar Copias de Seguridad"
    echo "4.- Eliminar Copia de Seguridad"
    echo "5.- Salir"
    echo
    echo -n "Seleccione una opcion: "
    read opcion

    case $opcion in
        1)
            crearCopiaCompleta
        ;;
        2)
            crearCopiaIncremental
        ;;  
        3)
            listarCopias
        ;;
        4)
            eliminarCopia
        ;;
        5)
            echo "Saliendo del programa."
            sleep 2
            exit
        ;;
        *)
            echo "Opcion invalida."
        ;;
    esac
done