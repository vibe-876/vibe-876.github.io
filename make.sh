#!/bin/bash


echo "<!DOCTYPE html><head><title>Blog</title><link rel=\"stylesheet\" href=\"styles.css\"><body><h1>Blog Entries</h1><a href=\"index.html\">Back Home</a><ul>" > blog.html

pages=$(find ./posts -type f -iname \*.org)
for page in $pages
do
    pandoc $page -o .$(echo $page | cut -f2 -d'.').html --css="styles.css" -s
    echo "<li><a href=\".$(echo $page | cut -f2 -d'.').html\">$(grep "#+title" $page | cut -f2- -d' '), $(grep "#+date" $page | cut -f2 -d' ')</a></li>" >> blog.html
done

echo "</ul></body>" >> blog.html


pandoc index.org -o index.html --css="styles.css" -s
