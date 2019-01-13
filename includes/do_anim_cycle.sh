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
# Reset dotcount if not set or greater than maximum, animate dots.
if [ -z $DOTCOUNT ]
then
  DOTCOUNT=0
fi
# Process dots, generate a string off the integer.
case $DOTCOUNT in
  0)
    DOTS=''
    DOTCOUNT=1
    ;;

  1)
    DOTS='.'
    DOTCOUNT=2
    ;;

  2)
    DOTS='..'
    DOTCOUNT=3
    ;;

  3)
    DOTS='...'
    DOTCOUNT=4
    ;;

  *)
    DOTS=''
    DOTCOUNT=0
    ;;
esac
printf '\r'${CLOCKS["$FRAMECOUNT"]}' ''Loading'"$DOTS"'   '
