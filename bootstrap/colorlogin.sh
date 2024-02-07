RAINBOW_COLORS=(1 214 11 10 12 63 13)
COLORED_LINE="\e[38;5;%dm%s\e[0m"
SEGMENT=4

doLine() {
  line=$1
  offset=$2
  counter=0
  if [ $offset == 0 ]; then
    color_index=0
  else
    color_index=6
  fi

  while [ $counter -le ${#line} ]; do
    if [ $counter == 0 ] && [ $offset -gt 0 ]; then
      printf "$COLORED_LINE" "${RAINBOW_COLORS["$color_index"]}" "${line:$counter:$offset}"
      counter=$(($counter + $offset))
    else
      printf "$COLORED_LINE" "${RAINBOW_COLORS["$color_index"]}" "${line:$counter:$SEGMENT}"
      counter=$(($counter + $SEGMENT))
    fi
    if [ $color_index -lt 6 ]; then
       color_index=$(($color_index + 1))
    else
       color_index=0
    fi
  done

  printf "\n"
}

lines=(
  " ____ ____ ____ ____ ____ ____"
  "||A |||n |||g |||e |||l |||o ||"
  "||__|||__|||__|||__|||__|||__||"
  "|/__\|/__\|/__\|/__\|/__\|/__\|"
)

for i in {0..3} ; do
    doLine "${lines[$i]}" $i
done
echo ""
