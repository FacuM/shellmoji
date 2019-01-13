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

# Get the path to the script.
ME=$(dirname $(realpath $0))
#   /\        /\
#   ||        ||
#
# According to https://bit.ly/2OjAUd9

# Arrays
EMOJIS=(
'\xF0\x9F\x93\x84' # (page facing up)
'\xF0\x9F\x93\x81' # (file folder)
'\xF0\x9F\x93\x9F' # (pager)
'\xF0\x9F\x92\xBD' # (minidisc)
'\xF0\x9F\x93\x9C' # (scroll)
'\xF0\x9F\x92\xBB' # (personal computer)
'\xE2\x99\xA8'     # (hot springs)
'\xE2\x9D\x93'     # (black question mark ornament)
'\xF0\x9F\x8E\xB5' # (musical note)
'\xF0\x9F\x93\x85' # (calendar)
)

EARTHS=(
'\xF0\x9F\x8C\x8D' # (earth globe europe-africa)
'\xF0\x9F\x8C\x8E' # (earth globe america)
)

BOOKS=(
'\xF0\x9F\x93\x95' # (closed book)
'\xF0\x9F\x93\x97' # (green book)
'\xF0\x9F\x93\x98' # (blue book)
'\xF0\x9F\x93\x99' # (orange book)
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
function getEarthEmoji
{
 printf "${EARTHS[ $(( $RANDOM % 2 + 1 )) ]}"
}

function getBookEmoji
{
 printf "${BOOKS[ $(( $RANDOM % 2 + 1 )) ]}"
}

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
   # IFS setup, end of field ONLY if newline found.
   IFS=$'\n'
   for content in $OUT_LS
   do
    . "$ME"/includes/do_anim_cycle.sh
    SEEK=$(echo "$content" | tr -cd '/' | wc -c)
    CURRENT=$(echo "$content" | cut -d '/' -f $(( $SEEK + 1 )) )
    # Regular file
    if [ -f "$content" ]
    then
     if [ -s "$content" ]
     then
      SECONDSEEK=$(echo "$content" | tr -cd '.' | wc -c)
      SECONDCURRENT=$(echo "$content" | cut -d '.' -f $(( $SECONDSEEK + 1 )) | cut -d '/' -f $(( $SECONDSEEK + 1 )) )
      case "$SECONDCURRENT" in
        'LICENSE')
          OUT="$OUT""${EMOJIS[4]}"' '"$CURRENT"
          ;;
        'sh')
          OUT="$OUT""${EMOJIS[5]}"' '"$CURRENT"
          ;;
        'epub')
          OUT="$OUT""$(getBookEmoji)"' '"$CURRENT"
          ;;
        'flac' | 'mp3' | 'wma' | 'aac' | 'ac3' | 'dsf' | 'dts' | 'wav')
          OUT="$OUT""${EMOJIS[8]}"' '"$CURRENT"
          ;;
        *)
          OUT="$OUT""${EMOJIS[0]}"' '"$CURRENT"
          ;;
      esac
     else
      OUT="$OUT""${EMOJIS[0]}"' '"$CURRENT"
     fi
    else
     # Directory
     if [ -d "$content" ]
     then
      # If the directory name is ".git", show a different icon.
      if [ "$CURRENT" == '.git' ]
      then
       OUT="$OUT""${EMOJIS[9]}"' '"$CURRENT"
      else
       OUT="$OUT""${EMOJIS[1]}"' '"$CURRENT"
      fi
     else
      # Special file
      if [ -c "$content" ]
      then
       OUT="$OUT""${EMOJIS[2]}"' '"$CURRENT"
      else
       if [ -b "$content" ]
       then
        OUT="$OUT""${EMOJIS[3]}"' '"$CURRENT"
       else
        if [ -S "$content" ]
        then
         OUT="$OUT""$(getEarthEmoji)"' '"$CURRENT"
        else
         OUT="$OUT""${EMOJIS[7]}"' '"$CURRENT"
	fi
       fi
      fi
     fi
    fi
    OUT="$OUT"'\n'
  done
  clear_line
  printf "$OUT"
}

# Main
printf '\n'
if [ -t 1 ]
then
 alias_ls $1
else
 ls $1
fi
