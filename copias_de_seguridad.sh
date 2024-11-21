#!/bin/bash

crearCopiaCompleta () {
    clear
    echo
    echo "Seleccionó la opción de Crear Copia de Seguridad Completa."
    echo
    echo -n "Escriba la dirección de origen (Dirección Absoluta): "
    read direccionOrigen

   
    
    fecha=$(date +%Y-%m-%d)

    fecha2=$(date +%Y-%m-%d-%H%M%S)
    direccionDestino=/backups/backup-$fecha

    sudo mkdir -p $direccionDestino
   
    cadena=${direccionOrigen//\//-}

    filename=backup-${cadena}-${fecha2}.tar.gz

    sudo tar -cvzpf $direccionDestino/${filename} $direccionOrigen

    echo "----------------------------------------"
    echo "Copia de seguridad creada con exito."
    echo "----------------------------------------"
    echo -n "¿Desea programar la frecuencia de la copia de seguridad? (Y/N): "
    read opc

    while [ true ]
    do
        case $opc in
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
    
    fecha=$(date +%Y-%m-%d)

    direccionDestino="/backups/backup-$fecha"

    TIMESTAMP="timestamp.dat"
    
    sudo mkdir -p ${direccionDestino}

    cadena=${direccionOrigen//\//-}
    contador=0

    # Bucle para encontrar un nombre único
    while [[ -e "${cadena}-$(printf "%02d" $contador)" ]]; do
        ((contador++))
    done

    # Crear el nombre único
    nombre_final="${cadena}-$(printf "%02d" $contador)"


    filename=backup-${nombre_final}-${fecha}.tar.gz
   
    sudo tar -cpzf ${direccionDestino}/${filename} -g ${direccionDestino}/${TIMESTAMP} $direccionOrigen

    echo "----------------------------------------"
    echo "Copia de seguridad creada con exito."
    echo "----------------------------------------"
    echo -n "¿Desea programar la frecuencia de la copia de seguridad? (Y/N): "
    read opc

    while [ true ]
    do
        case $opc in
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
    echo "Hola"
}

restablecerArchivo () {
    echo "Hola"
}

programarCopia () {
    echo "hola"
}

while [ true ]
do
    echo
    echo $HOME
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