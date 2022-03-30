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
    if [ "$day" -gt "31" ] || [ "$month" -gt "12" ]; then
        printf "Error: Please enter a valid day and month that appears on your calendar!\n"
        exit 1
    fi
    year=$(date +"%Y")

}

#=============holiday function=============
# Puropse: Prints holiday message if current day is a holiday
holiday(){
    currentDay=$1
    if [ "$currentDay" == "12-25" ]; then
        echo "It's a holiday! Merry Christmas!"
    elif [ "$currentDay" == "10-31" ]; then
        echo "It's a holiday! Happy Halloween!"
    elif [ "$currentDay" == "03-17" ]; then
        echo "It's a holiday! Happy Saint Pats!"
    elif [ "$currentDay" == "07-1" ]; then
        echo "It's a holiday! Happy Canada Day!"
    fi
    
    if [ $2 ]; then
        if [ "$2" == "12-25" ]; then
            echo "Your birthday is a holiday! Merry Christmas!"
        elif [ "$2" == "10-31" ]; then
            echo "Your birthday is a holiday! Happy Halloween!"
        elif [ "$2" == "03-17" ]; then
            echo "Your birthday is a holiday! Happy Saint Pats!"
        elif [ "$2" == "07-1" ]; then
            echo "Your birthday is a holiday! Happy Canada Day!"
        fi
    fi

}


unixOffset(){
    newUnixDate=$(( $1 + ( $2 * 86400 ) ))
    #|| [ "$2" -ge "20000" ] || "$2" -le "-20000" ]
    upperYear=$(date -d "+15 years" +%s)
    lowerYear=$(date -d "-15 years" +%s)
    if [ "$newUnixDate" -ge "$upperYear" ] || [ "$newUnixDate" -le "$lowerYear" ]; then
        echo "Error: Offset too large. Please ensure the date is within the 21st century."
        exit 1
    fi
}

# Perform welcome message
user=$(whoami)
echo "Hello $user"
unixDay=$(date +%s)

# Compute current date
todaysDate=$(date -d @"$unixDay")
echo "The current date is: $todaysDate"


if [ $1 ]; then
    newOffset=$(( $unixDay + ( $1 * 86400 ) ))
    unixOffset unixDay $1 #TODO: Get offset to work.
    dateToday=$(date -d @"$newUnixDate")
    unixOffsetDay=$newUnixDate
    echo "offset: $unixOffsetDay"
    echo "Offset by $1 days, the date is $dateToday"
else
    todaysDate=$(date -d @"$unixDay")
    # echo "The current date is: $todaysDate"
fi

# Call greet
greet

# Handles leap year
nextYear=0
if [ "$day" == "29" ] && ( [ "$month" == "02" ] || [ "$month" == "2" ] ); then
    echo "Leap year entered. This date is not valid. Try a different birthday :)"
    exit 1
fi


# Call unixTimeStamp
if [ $1 ]; then
    offsetYear=$(date -d "@$unixOffsetDay" '+%Y')
    unixTimeStamp $month $day $offsetYear
else
    unixTimeStamp $month $day $year
fi
# echo "$unixTime"
if [ $1 ]; then
    difference=$(( ( $unixTime - $unixOffsetDay ) / 86400 ))
else
    difference=$(( ( $unixTime - $unixDay ) / 86400 ))

fi
if [ "$difference" == "0" ]; then
    echo "Happy birthday to you!"
elif [ "$difference" -lt "0" ]; then
    newDate=$(( 365 + $difference ))
    echo "Your birthday will be in $newDate days"
else
    echo "Your birthday will be in $difference days"
fi

#Check for holidays
if [ $1 ]; then
    currentDay=$(date -d "@$unixOffsetDay" '+%m-%d')
    birthDay=$(date -d "@$unixTime" '+%m-%d')
    holiday $currentDay $birthDay
else
    currentDay=$(date -d "today" '+%m-%d')
    birthDay=$(date -d "@$unixTime" '+%m-%d')
    holiday $currentDay $birthDay
fi

#Feature 1
