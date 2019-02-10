#!/bin/bash
CWL_DIR=/usr/share/aspell/
TMP_DIR=/tmp/wordlists
OUT_DIR=/tmp/tex

shopt -s extglob

mkdir $TMP_DIR $OUT_DIR 

#There's something odd about gl-minimos
DICTIONARIES=`aspell dicts | grep -v ^gl$`

for DICTIONARY in $DICTIONARIES; do
  echo "Testing dictionary $DICTIONARY"
  if [ "$DICTIONARY" = "gl-minimos" ]; then
    LANG="gl-minimos"
  elif [ "$DICTIONARY" = "pt_BR" ]; then
    LANG="pt_BR"
  elif [ "$DICTIONARY" = "pt_PT" ]; then
    LANG="pt_PT"
  else 
    TEMP=${DICTIONARY%%_*}
    LANG=${TEMP%%-*}
  fi
  WORDLIST=$TMP_DIR/$DICTIONARY-wordlist.txt
  aspell -d $DICTIONARY dump master | aspell -l $LANG expand | cut -d ' ' -f 1 | awk 'length>3' | head -n 500 > $WORDLIST
  TEX_FILE=${OUT_DIR}/main-${DICTIONARY}.tex
  rm -f ${TEX_FILE}
  echo "\documentclass{article}" >> ${TEX_FILE}
  echo "\begin{document}" >> ${TEX_FILE}

  cat $WORDLIST | head -n 5 | tr '\n' ' ' >> ${TEX_FILE}
  cat $WORDLIST | tail -n 5 | tr -d '\n'  >> ${TEX_FILE}
  cat $WORDLIST | head -n 5 | tr '\n' ' ' >> ${TEX_FILE}
  echo "" >> ${TEX_FILE}
  echo "\end{document}" >> ${TEX_FILE}

  cat ${TEX_FILE} | aspell pipe -t  -d ${DICTIONARY}
  
done
