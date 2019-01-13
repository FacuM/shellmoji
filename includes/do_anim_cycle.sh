# Reset framecount if not set or greater than maximum, animate clock.
if [ -z $FRAMECOUNT ]
then
  FRAMECOUNT=0
else
  if [ $FRAMECOUNT -lt $(( ${#CLOCKS[@]} - 1 )) ]
  then
    FRAMECOUNT=$(( $FRAMECOUNT + 1 ))
  else
    FRAMECOUNT=0
  fi
fi
# Process dots, generate a string off the integer.
if [ "$DOTS" == '...' ]
then
 DOTS=''
else
 DOTS="$DOTS"'.'
fi
printf '\r'${CLOCKS["$FRAMECOUNT"]}' ''Loading'"$DOTS"'   '
