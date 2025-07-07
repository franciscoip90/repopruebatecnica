#!/bin/bash

DIRECTORIO_BACKUP="/mediastream/mongo_backups"
ARCHIVO_LOG="/var/log/mongo_backup.log"
TIMESTAMP=$(date "+%Y%m%d_%H%M%S")
ARCHIVO_BACKUP="${DIRECTORIO_BACKUP}/mongodb_backup_${TIMESTAMP}"

{
    echo "------------ Inicio de backup: $(date) ------------- "
    
    mkdir -p "${DIRECTORIO_BACKUP}"
    
    mongodump --out "${ARCHIVO_BACKUP}"
   
    tar -czf "${BACKUP_FILE}.tar.gz" -C "${DIRECTORIO_BACKUP}" "mongodb_backup_${TIMESTAMP}"
    rm -rf "${ARCHIVO_BACKUP}"
    
    echo "Backup completado: ${ARCHIVO_BACKUP}.tar.gz"
    echo "Tamaño del backup: $(du -h "${ARCHIVO_BACKUP}.tar.gz" | cut -f1)"
    echo "------------- Fin de backup: $(date) -------------"
    echo ""
} >> "${ARCHIVO_LOG}" 2>&1
