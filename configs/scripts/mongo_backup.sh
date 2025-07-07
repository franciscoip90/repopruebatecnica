#!/bin/bash

# Configuración
DIRECTORIO_BACKUP="/mediastream/mongo_backups"
ARCHIVO_LOG="/var/log/mongo_backup.log"
TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
ARCHIVO_BACKUP="mongodb_backup_$TIMESTAMP"
RUTA_COMP="$DIRECTORIO_BACKUP/$ARCHIVO_BACKUP"

mkdir -p "$DIRECTORIO_BACKUP"

echo "------------ Inicio de backup: $(date) -------------" >> "$ARCHIVO_LOG"

mongodump --out "$RUTA_COMP" 2>> "$ARCHIVO_LOG"

if [ $? -eq 0 ]; then
    # Comprimir backup
    tar -czf "$RUTA_COMP.tar.gz" -C "$DIRECTORIO_BACKUP" "$ARCHIVO_BACKUP" 2>> "$ARCHIVO_LOG"
    
    if [ $? -eq 0 ]; then
        # Eliminar archivos sin comprimir
        rm -rf "$RUTA_COMP"
        
        # Registrar éxito
        echo "Backup completado: $RUTA_COMP.tar.gz" >> "$ARCHIVO_LOG"
        echo "Tamaño del backup: $(du -h "$RUTA_COMP.tar.gz" | cut -f1)" >> "$ARCHIVO_LOG"
    else
        echo "Error al comprimir el backup" >> "$ARCHIVO_LOG"
    fi
else
    echo "Error durante el dump de MongoDB" >> "$ARCHIVO_LOG"
fi

echo "------------- Fin de backup: $(date) -------------" >> "$ARCHIVO_LOG"
