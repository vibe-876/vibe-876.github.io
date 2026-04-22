#!/bin/bash


echo "<!DOCTYPE html><head><title>Blog</title><link rel=\"stylesheet\" href=\"styles.css\"><body><h1>Blog Entries</h1><a href=\"index.html\">Back Home</a><ul>" > blog.html

pages=$(find ./posts -type f -iname \*.org | sort)
for page in $pages
do
    echo "Building $page..."
    pandoc $page -o .$(echo $page | cut -f2 -d'.').html --css="../styles.css" -s

    pagename=.$(echo $page | cut -f2 -d'.').html
    pagetitle=$(grep "#+title" $page | cut -f2- -d' ' | head -n1)
    pagedate=$(grep "#+date" $page | cut -f2 -d' ')
    echo "<li><a href=\"$pagename\">$pagetitle, $pagedate</a></li>" >> blog.html
done

echo "</ul></body>" >> blog.html


pandoc index.org -o index.html --css="styles.css" -s
