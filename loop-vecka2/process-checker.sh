#!/bin/bash
# Talar om att detta är ett bash-skript.

logfile="process_check.txt"
# Filen där vi sparar alla resultat.

log() {
    # Funktion som skriver text till skärmen och till loggfilen.
    echo "$(date) - $1" | tee -a "$logfile"
}

check_process() {
    # Funktion som kontrollerar om en process körs i Windows.
    local p=$1
    # Sparar processnamnet som skickas in.

    # tasklist listar alla processer i Windows
    # grep -i letar efter processnamnet (ignorerar stora/små bokstäver)
    if tasklist | grep -i "$p" > /dev/null; then
        log "Processen '$p' körs."
        # Om processen hittas → skriv att den körs.
    else
        log "VARNING: Processen '$p' körs inte."
        # Om den inte hittas → skriv varning.
    fi
}

run_checks() {
    # Funktion som läser processlistan och kontrollerar varje process.
    local file=$1
    # Sparar filnamnet som skickas in.

    if [ ! -f "$file" ]; then
        # Kontrollerar om filen inte finns.
        log "FEL: Filen $file saknas."
        exit 1
        # Avslutar skriptet om filen saknas.
    fi

    while read -r process; do
        # Läser en rad i taget från filen.
        check_process "$process"
        # Kontrollerar processen från raden.
    done < "$file"
    # Slutar läsa när filen är slut.
}

run_checks "processlist.txt"
# Startar programmet och skickar in filen med processer.

log "Kontroller slutförda."
# Skriver att alla kontroller är klara.
