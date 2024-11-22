#!/bin/bash

    direccionOrigen="$HOME/datos"


    fecha2=$(date +%Y-%m-%d-%H-%M-%S)

    direccionDestino="$HOME/backups"

    sudo mkdir -p ${direccionDestino}

    cadena=${direccionOrigen//\//-}

    filename=${cadena}-$fecha2-inc.tar.gz
   
    sudo tar -cvpzf ${direccionDestino}/${filename} -g ${direccionDestino}/snapshot.snar $direccionOrigen