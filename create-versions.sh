#!/usr/bin/env bash

# -dPDFSETTINGS=/screen   (screen-view-only quality, 72 dpi images)
# -dPDFSETTINGS=/ebook    (low quality, 150 dpi images)
# -dPDFSETTINGS=/printer  (high quality, 300 dpi images)
# -dPDFSETTINGS=/prepress (high quality, color preserving, 300 dpi imgs)
# -dPDFSETTINGS=/default  (almost identical to /screen)
# Source: https://tex.stackexchange.com/questions/14429/pdftex-reduce-pdf-size-reduce-image-quality
#         https://tex.stackexchange.com/questions/18987/how-to-make-the-pdfs-produced-by-pdflatex-smaller

FILE=$1

if [[ ${FILE: -4} != ".pdf" ]]; then
  echo "Only .pdf files are supported!"
  exit 1
fi

for x in /screen /ebook /printer /prepress
do
  echo "Generating ${x:1} version..."
  gs -sDEVICE=pdfwrite \
     -dCompatibilityLevel=1.5 \
     -dPrinted=false \
     -dPDFSETTINGS=$x \
     -dNOPAUSE \
     -dQUIET \
     -dBATCH \
     -sOutputFile=$(basename $FILE .pdf)-${x:1}.pdf \
      $FILE
done

# Generate report
ls -dhn -- *.pdf | awk '{print $5, $9}' > report.txt
