#!/bin/bash

# Enkel säkerhetskontrollskript
# Detta är bara en titel. Skriptet ska kolla om en fil och en användare finns.

logfile="security_log.txt"
# Här bestämmer vi namnet på filen där vi ska skriva ner allt som händer.

log() {
    # Detta är en funktion som heter "log". En funktion är som ett litet miniprogram i programmet.
    echo "$(date) - $1" | tee -a $logfile
    # Här skriver vi ut text med datum framför.
    # "$1" betyder "det första ordet du skickar in till funktionen".
    # tee -a betyder: skriv både på skärmen och lägg till i loggfilen.
}

check_file() {
    # Funktion som kollar om en fil finns.
    local file=$1
    # Vi sparar filnamnet som skickas in i variabeln "file".

    if [ -f "$file" ]; then
        # -f betyder: finns det en fil med detta namn?
        log "Filen '$file' finns."
        # Om filen finns, så loggar vi det.
        ls -l "$file" | tee -a $logfile
        # ls -l visar detaljer om filen och skriver även det i loggfilen.
    else
        log "VARNING: Filen '$file' saknas."
        # Om filen inte finns, skriver vi en varning.
    fi
}

# Funktion för att kontrollera om en användare finns
check_user() {
    # Nu gör vi samma sak fast för användare.
    local user=$1
    # Vi sparar användarnamnet i variabeln "user".

    if id "$user" &>/dev/null; then
        # Kommandot id kollar om en användare finns.
        # &>/dev/null betyder att vi gömmer alla felmeddelanden.
        log "Användaren '$user' finns."
        # Om användaren finns, loggar vi det.
    else
        log "VARNING: Användaren '$user' saknas."
        # Annars skriver vi en varning.
    fi
}

read -p "Ange fil att kontrollera: " file_input
# Här frågar vi användaren vilken fil de vill kolla, och sparar svaret i file_input.

check_file "$file_input"
# Här kör vi funktionen som kollar filen användaren skrev in.

read -p "Ange användarnamn att kontrollera: " user_input
# Nu frågar vi användaren vilket användarnamn de vill kolla.

check_user "$user_input"
# Här kör vi funktionen som kollar användaren.

log "Kontroller slutförda."
# Till slut skriver vi att alla kontroller är klara :)
