@echo off

pdflatex -jobname=final-report template
pdflatex -jobname=final-report template
pdflatex -jobname=final-report template
start "" final-report.pdf

echo Cleaning output files
del final-report.aux
del final-report.toc
