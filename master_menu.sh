#!/bin/bash

PURPLE='\033[0;35m'
NC='\033[0m'  # No Color

# Email function script
EMAIL_SCRIPT="./email_notify.sh"
LOG_FILE="user_actions.log"

# Include the email script
source $EMAIL_SCRIPT

# Function to log user actions
log_action() {
    local action=$1
    echo "$(date): $action" >> $LOG_FILE
}

# Function to display the main menu
main_menu() {
    echo -e "${PURPLE}==================================${NC}"
    echo -e "${PURPLE}||         🛠️   PWR TOOLS        ||${NC}"
    echo -e "${PURPLE}==================================${NC}"
    echo "Choose an option:"
    echo "1. Backup Script"
    echo "2. File Organizer Script"
    echo "3. System Monitor Script"
    echo "4. Task Scheduler Script"
    echo "5. Exit"
    echo -n "Enter your choice: "
    read choice

    case $choice in
        1)
            ./backup.sh
            log_action "Backup Script executed"
            ;;
        2)
            ./file_organizer.sh
            log_action "File Organizer Script executed"
            ;;
        3)
            ./system_monitor.sh
            log_action "System Monitor Script executed"
            ;;
        4)
            ./task_scheduler.sh
            log_action "Task Scheduler Script executed"
            ;;
        5) 
            log_action "User exited the program"
            send_email "Program Exit" "$(cat $LOG_FILE)"
            rm $LOG_FILE
            exit 0 
            ;;
        *) 
            echo "Invalid choice, please try again."
            log_action "Invalid choice selected"
            ;;
    esac
}

# Main loop
while true; do
    main_menu
done
