@echo off

pdflatex -jobname=project-proposal template
pdflatex -jobname=project-proposal template
pdflatex -jobname=project-proposal template
start "" project-proposal.pdf

echo Cleaning output files
del project-proposal.aux
del project-proposal.toc
