if [ $# -eq 0 ] ; then
    echo Usage: $0 '*.vsm'
    exit
fi

VSM_FILES=$*
ASM_FILES=`echo $VSM_FILES | sed -e 's/\.vsm/.asm/g'`
TXT_FILES=`echo $VSM_FILES | sed -e 's/\.vsm/.txt/g'`

cat << JUNKY
include ../scripts/mn-core-rule.ninja

build all: phony gen-asm run-sim
default all

build gen-asm: phony $ASM_FILES
build run-sim: phony $TXT_FILES

JUNKY

for i in $VSM_FILES
do
NAME=`basename -s .vsm $i`
cat << JUNKY
#----------------------------------------------------------------
build $NAME.asm: gen-mncore2-asm $NAME.vsm
build $NAME.txt: run-mncore2-sim $NAME.asm

JUNKY
done
