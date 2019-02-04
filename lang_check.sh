#!/bin/bash
CWL_DIR=/usr/share/aspell/
OUT_DIR=/tmp/tex

shopt -s extglob

mkdir $OUT_DIR

for cwl in $CWL_DIR/*.cwl.gz; do
  LANG_CODE=${cwl//+(*\/|.*)}
  TEX_FILE=${OUT_DIR}/main-${LANG_CODE}.tex
  echo ${TEX_FILE}
  rm -f ${TEX_FILE}
  echo "\documentclass{article}" >> ${TEX_FILE}
  echo "\begin{document}" >> ${TEX_FILE}

  zcat $cwl | precat | head -n 5 | tr '\n' ' ' >> ${TEX_FILE}
  zcat $cwl | precat | tail -n 5 | tr -d '\n'  >> ${TEX_FILE}
  zcat $cwl | precat | head -n 5 | tr '\n' ' ' >> ${TEX_FILE}
  echo "" >> ${TEX_FILE}
  echo "\end{document}" >> ${TEX_FILE}

  cat ${TEX_FILE} | aspell pipe -t --encoding=utf-8 -d ${LANG_CODE}

done
