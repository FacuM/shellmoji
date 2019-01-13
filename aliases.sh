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
function clear_line
{
  printf '\r'
  COL=1
  COLS=$(tput cols)
  while [ $COL -lt $COLS ]
  do
    printf ' '
    COL=$(( $COL + 1 ))
  done
}

function alias_ls
{
   OUT=''; OUT_LS=$(find $1 -maxdepth 1)
   for content in $OUT_LS
   do
    . includes/do_anim_cycle.sh
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
  done
  clear_line
  printf "$OUT"
}

# Main
printf '\n'
alias_ls $1
