#!/bin/bash

# Colors for formatting
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
NC='\033[0m'  # No Color

TASK_FILE="tasks.txt"

get_current_date() {
    echo "$(date +%Y)-$(date +%m)-$(date +%d)"
}

add_task() {
    echo "Enter task description:"
    read description

    year=$(date +%Y)
    month=$(date +%m)
    day=$(date +%d)

    echo "Enter task deadline year (default: $year):"
    read input_year
    year=${input_year:-$year}

    echo "Enter task deadline month (default: $month):"
    read input_month
    month=${input_month:-$month}

    echo "Enter task deadline day (default: $day):"
    read input_day
    day=${input_day:-$day}

    deadline="$year-$month-$day"
    id=$(($(wc -l < "$TASK_FILE") + 1))
    echo "$id | $description | $deadline | ❌" >> "$TASK_FILE"
    echo "Task added!"
}

view_tasks() {
    if [ ! -f "$TASK_FILE" ] || [ ! -s "$TASK_FILE" ]; then
        echo "No tasks available."
    else
        echo -e "\n${PURPLE}==== SHOWING ALL TASKS ====${NC}\n"
        echo -e "${BLUE}ID${NC} | ${GREEN}Description${NC} | ${YELLOW}Deadline${NC} | ${RED}Status${NC}"
        cat "$TASK_FILE" # cat: outputs the contents of a text file
        echo -e "\n${RED}<-${NC} Press ENTER key to go back"
        read -p ""
    fi
}

remove_task() {
    echo "Enter task ID to remove:"
    read id
    sed -i "/^$id |/d" "$TASK_FILE" # sed: manipulates the contents of a file
    echo "Task removed!"
}

mark_done() {
    echo "Enter task ID to mark as done:"
    read id
    sed -i "/^$id |/s/❌/✅/" "$TASK_FILE" # sed: manipulates the contents of a file
    echo "Task marked as done!"
}

# Main menu
while true; do
    echo -e "${PURPLE}==================================${NC}"
    echo -e "${PURPLE}||       📝  Task Scheduler     ||${NC}"
    echo -e "${PURPLE}==================================${NC}"
    echo "1. Add Task"
    echo "2. View Tasks"
    echo "3. Remove Task"
    echo "4. Mark Task as Done"
    echo "5. Exit"
    echo "Choose an option:"
    read option
    case $option in
        1) add_task ;;
        2) view_tasks ;;
        3) remove_task ;;
        4) mark_done ;;
        5) exit 0 ;;
        *) echo "Invalid option. Please try again." ;;
    esac
done
