#!/bin/bash

LOG_FILE="/mediastream/recolecta_info.log"
TIMESTAMP=$(date "+%Y-%m-%d %H:%M:%S")

{
    echo "=== $TIMESTAMP ==="
    echo "Últimas 3 líneas de /var/log/syslog:"
    tail -n 3 /var/log/syslog
    echo ""
    echo "Espacio utilizado en el RAID:"
    df -h /mediastream
    echo ""
    echo "Hash SHA256 de /var/log/auth.log:"
    sha256sum /var/log/auth.log
    echo "====================================="
} >> "$LOG_FILE"
