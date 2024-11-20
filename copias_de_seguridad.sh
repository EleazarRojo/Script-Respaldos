#!/bin/bash

crearCopiaCompleta () {
    clear
    echo
    echo "Seleccionó la opción de Crear Copia de Seguridad Completa."
    echo
    echo -n "Escriba la dirección de origen (Dirección Absoluta): "
    read direccionOrigen
    echo
    echo -n "Escribe donde guardar la Copia de Seguridad (Dirección Absoluta): "
    read direccionDestino

    fecha=$(date +%Y-%m-%d-%H%M%S)
    tar -cvzpf $direccionDestino/backup-$fecha.tar.gz $direccionOrigen

    echo "----------------------------------------"
    echo "Copia de seguridad creada con exito."
    echo "----------------------------------------"
    echo -n "¿Desea programar la frecuencia de la copia de seguridad? (Y/N): "
    read opc

    while [ true ]
    do
        switch $opc in
            "Y" | "y")
                programarCopia ""
            ;;
            "N" | "n")
            break
            ;;
            *)
                echo "Opcion Invalida."
            ;;
        esac
    done
}

crearCopiaIncremental () {
    clear
    echo
    echo "Seleccionó la opción de Crear Copia de Seguridad Incremental."
    echo
    echo -n "Escriba la dirección de origen (Dirección Absoluta): "
    read direccionOrigen
    echo
    echo -n "Escribe donde guardar la Copia de Seguridad (Dirección Absoluta): "
    read direccionDestino

    BACKUP_DIR="/ carpetadestino /backup"
    ROTATE_DIR="/ carpetadestino /backup/rotate"

    fecha=$(date +%Y-%m-%d-%H%M%S)
    tar -cvzpf $direccionDestino/backup-$fecha.tar.gz $direccionOrigen

    echo "----------------------------------------"
    echo "Copia de seguridad creada con exito."
    echo "----------------------------------------"
    echo -n "¿Desea programar la frecuencia de la copia de seguridad? (Y/N): "
    read opc

    while [ true ]
    do
        switch $opc in
            "Y" | "y")
                programarCopia ""
            ;;
            "N" | "n")
            break
            ;;
            *)
                echo "Opcion Invalida."
            ;;
        esac
    done
}

listarCopias () {

}

eliminarCopia () {

}

restablecerArchivo () {

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
    echo "5.- Restablecer Archivos"
    echo "6.- Salir"
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
            restablecerArchivo
        ;;
        6)
            programarCopia
        ;;
        7)
            echo "Saliendo del programa."
            sleep 2
            exit
        ;;
        *)
            echo "Opcion invalida."
        ;;
    esac
done