#!/bin/bash

send_email() {
    local subject=$1
    local message=$2
    local recipient="your_email@example.com"

    echo -e "Subject: ${subject}\n\n${message}" | mail -s "${subject}" ${recipient}
}
