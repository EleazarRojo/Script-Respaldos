#!/bin/bash

crearCopiaCompleta () {
    clear
    echo
    echo "Seleccionó la opción de Crear Copia de Seguridad Completa."
    echo
    echo -n "Escriba la dirección de origen (Dirección Absoluta): "
    read direccionOrigen
    
    fecha=$(date +%Y-%m-%d-%H%M%S)
    direccionDestino = "/backups/backup-$fecha"

    mkdir -p ${BACKUP_DIR}
    set -- ${BACKUP_DIR}/backup-$fecha-??.tar.gz
    lastname=${!#}
    backupnr=${lastname##*backup-}
    backupnr=${backupnr%%.*}
    backupnr=${backupnr//\?/0}
    backupnr=$[10#${backupnr}

    filename=backup-${backupnr}.tar.gz

    sudo tar -cvzpf $direccionDestino/${filename} $direccionOrigen

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
    
    fecha=$(date +%Y-%m-%d-%H%M%S)
    BACKUP_DIR="/backups/backup-$fecha"
    ROTATE_DIR="/backups/backup-$fecha/rotate"

    TIMESTAMP="timestamp.dat"
    SOURCE="$HOME/$direccionOrigen"
    
    EXCLUDE="--exclude=/mnt/* --exclude=/proc/* --exclude=/sys/* --exclude=/tmp/*"
    cd /
    
    mkdir -p ${BACKUP_DIR}
    set -- ${BACKUP_DIR}/backup-$fecha-??.tar.gz
    lastname=${!#}
    backupnr=${lastname##*backup-}
    backupnr=${backupnr%%.*}
    backupnr=${backupnr//\?/0}
    backupnr=$[10#${backupnr}

    if [ "$[backupnr++]" -ge 30 ]; then
        mkdir -p ${ROTATE_DIR}/${fecha}
        mv ${BACKUP_DIR}/b* ${ROTATE_DIR}/${DATE}
        mv ${BACKUP_DIR}/t* ${ROTATE_DIR}/${DATE}
        backupnr=1
    fi

    tar -cpzf ${BACKUP_DIR}/${filename} -g ${BACKUP_DIR}/${TIMESTAMP} -X $EXCLUDE ${SOURCE}

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
    clear
    echo
    echo "Seleccionó la opción de Listar Copias de Seguridad Creadas."
    echo
    echo "Las copias de seguridad creadas hasta el momento son:"
    cd /backups
    ls
    echo
    echo
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