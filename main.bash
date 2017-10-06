#!/bin/bash

# Don't download it if it's already there, we don't want to hurt their servers
[[ -e all-counties.txt ]] || {
    rm *.html *.html.*
    echo ':: Downloading county lists...'
    wget --no-verbose http://ng3k.com/Misc/usc_{a-c,d-h,i-k,l-m,n,o-r,s-u,v-w}.html; }
echo ':: Concatenating and formatting downloaded files...'
cat *.html | grep '<li>' | grep County | grep -v '</a>' | sed -r 's/(\s*<.?li>\s*)|(\([A-Z]+\))|County|Area//g;s/^ *//;s/ *$//' > all-counties.txt
echo ':: Raw county list written to all-counties.txt'
echo -n ':: Enter desired sample size: '
read sample_size

echo ':: Selecting sample...'
awk -vsampleSize=$sample_size -vlineCount=$(wc -l < all-counties.txt) -f select-sample.awk all-counties.txt > sampled-counties.txt
awk '{print length($1)}' sampled-counties.txt | sort -n > sampled-lengths.txt
echo ':: Sample written to sampled-counties.txt, lengths written to sampled-lengths.txt'
echo ':: Scraping complete. Have a nice day!'
