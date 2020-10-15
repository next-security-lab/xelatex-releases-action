#!/usr/bin/env bash

FILE=$1

for x in /screen /ebook /printer /prepress
do
  gs -sDEVICE=pdfwrite \
     -dCompatibilityLevel=1.4 \
     -dPDFSETTINGS=$x \
     -dNOPAUSE \
     -dQUIET \
     -dBATCH \
     -sOutputFile=${basename $FILE .pdf}-${x:1}.pdf \
      $FILE
done
