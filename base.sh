#!/bin/bash

#=============unixTimestamp function=============
# Puropse: Computes unix date with provided input
unixTimeStamp(){
    date=$1"/"$2"/"$3" 12:00:00"
    unixTime=$(date --date="$date" +"%s")

}
#=============greet function=============
# Puropse: Prompts user to input birthday
greet(){
    # local day month
    echo "Enter your day of birth (DD):"
    read day
    echo "Enter your month of birth (MM):"
    read month
    # error handle invalid dates
    if [ "$day" -gy "31" ] || [ "$month" -gy "12" ]; then
        printf "Error: Please enter a valid day and month that appears on your calendar!\n"
        exit 1
    fi
    year=$(date +"%Y")

}

# Perform welcome message
user=$(whoami)
echo "Hello $user"
unixDay=$(date +%s)

# Compute current date
todaysDate=$(date -d @"$unixDay")
echo "The current date is: $todaysDate"


# Call greet
greet

# Handles leap year
nextYear=0
if [ "$day" == "29" ] && ( [ "$month" == "02" ] || [ "$month" == "2" ] ); then
    while [ $(expr $year % 4) != 0 ]
    do
        year=$(( $year + 1 ))
    done
    nextYear=$(( $year + 4 ))
else
    nextYear=$(( $year + 1 ))
fi

# Call unixTimeStamp
unixTimeStamp $month $day $year

# echo "$unixTime"
difference=$(( ( $unixTime - $unixDay ) / 86400 ))
if [ "$difference" -le "0" ]; then
    newDate=$(( 365 + $difference ))
    echo "Your birthday will be in $newDate days"
else
    echo "Your birthday will be in $difference days"
fi
#Feature 1
