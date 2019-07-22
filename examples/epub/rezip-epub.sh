#!/bin/bash
#
# PreTeXt EPUB example
# This just re-zips the EPUB file properly if the HTML or CSS has been
# edited to improve testing.
#
# History
#
#  2019-07-22  Initiated

shopt -s -o nounset

# MathBook XML paths
declare MB=${HOME}/Documents/github/mathbook
declare MBXSL=${MB}/xsl
declare EPUBSCRIPT=${MB}/examples/epub

# Working areas
# DEBUG saves post-xsltproc, pre-mathjax-node
# and also post-mathjax-node, pre-sed
declare SCRATCH=${MB}/examples/epub/scratch
declare EPUBOUT=${SCRATCH}/epub
declare DEBUG=${SCRATCH}/debug

# Sources
# 1.  Assumes an "images" directory below source directory
# 2.  Cover image must be a PNG, and in "images" directory

# EPUB Sampler, test file
declare SRC=${MB}/examples/epub
declare SRCMASTER=${SRC}/epub-sampler.xml
declare COVERIMAGE=Verne_Tour_du_Monde.png
declare OUTFILE=sampler.epub

# sed -i is different depending on if you have BSD sed (macOS)
# or GNU sed (Linux and Windows Subystem for Linux)
# To deal with this, we see which is in use and define a function called
# sed_i that we invoke rather than plain sed.
# https://unix.stackexchange.com/questions/92895/how-can-i-achieve-portability-with-sed-i-in-place-editing
case $(sed --help 2>&1) in
  *GNU*) sed_i () { sed -i "$@"; };;
  *) sed_i () { sed -i '' "$@"; };;
esac

# Back to usual default directory
# zip with  mimetype  first
cd ${EPUBOUT}
zip -0Xq  ${OUTFILE} mimetype
zip -Xr9Dq ${OUTFILE} *

# exit cleanly
exit 0
