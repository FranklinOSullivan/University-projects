@echo off

pdflatex -jobname=risk-analysis template
start "" risk-analysis.pdf

echo Cleaning output files
del risk-analysis.aux
