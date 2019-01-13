#!/usr/bin/env bash
########################################
#  Shellmoji, beautify your shell.
########################################
#
#  Author: Facundo Montero <facumo.fm@gmail.com>
#
########################################
#
# Depends on: UTF-8 shell support.
#
########################################

# Arrays
EMOJIS=(
'\xF0\x9F\x93\x84' # (page facing up)
'\xF0\x9F\x93\x81' # (file folder)
'\xF0\x9F\x93\x9F' # (pager)
)

CLOCKS=(
'\xF0\x9F\x95\x90'
'\xF0\x9F\x95\x91'
'\xF0\x9F\x95\x92'
'\xF0\x9F\x95\x93'
'\xF0\x9F\x95\x94'
'\xF0\x9F\x95\x95'
'\xF0\x9F\x95\x96'
'\xF0\x9F\x95\x97'
'\xF0\x9F\x95\x98'
'\xF0\x9F\x95\x99'
'\xF0\x9F\x95\x9A'
'\xF0\x9F\x95\x9B'
)

# Functions
function animate_clock
{
 echo $1
 if [ $1 -lt 1 ]
 then
  COUNT=0
  while [ $COUNT -lt ${#CLOCKS[@]} ]
  do
    printf '\r'${CLOCKS["$COUNT"]}
    COUNT=$(( $COUNT + 1 ))
    sleep 0.1
  done
 fi
 return $(( $1 + 1 ))
}

function alias_ls
{
 if [ -t 1 ]
 then
   OUT=''; OUT_LS=$(find $1 -maxdepth 1)
   for content in $OUT_LS
   do
    SEEK=$(echo "$content" | tr -cd '/' | wc -c)
    CURRENT=$(echo "$content" | cut -d '/' -f $(( $SEEK + 1 )) )
    # Regular file
    if [ -f "$content" ]
    then
     OUT="$OUT""${EMOJIS[0]}"' '"$CURRENT\n"
    else
     # Directory
     if [ -d "$content" ]
     then
      OUT="$OUT""${EMOJIS[1]}"' '"$CURRENT\n"
     else
      # Special file
      if [ -c "$content" ]
      then
       OUT="$OUT""${EMOJIS[2]}"' '"$CURRENT\n"
      fi
     fi
    fi
    #animate_clock $QUEUE &
    QUEUE=$(( $QUEUE + $? ))
   done
   if [ "$QUEUE" -eq 0 ]
   then
    printf "$OUT"
   fi
 else
   ls "$1"
 fi
}

# Main
QUEUE=0
printf '\n'
alias_ls $1
